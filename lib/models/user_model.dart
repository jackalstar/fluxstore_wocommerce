import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/config.dart';
import '../common/constants.dart';
import '../common/firebase_services.dart';
import '../generated/l10n.dart';
import '../services/index.dart';
import 'entities/user.dart';

abstract class UserModelDelegate {
  void onLoaded(User user);

  void onLoggedIn(User user);

  void onLogout(User user);
}

class UserModel with ChangeNotifier {
  UserModel() {
    getUser();
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final Services _service = Services();
  User user;
  bool loggedIn = false;
  bool loading = false;
  UserModelDelegate delegate;

  void updateUser(User newUser) {
    if (newUser != null) {
      user = newUser;
    }
    notifyListeners();
  }

  Future<String> submitForgotPassword(
      {String forgotPwLink, Map<String, dynamic> data}) async {
    return await _service.api
        .submitForgotPassword(forgotPwLink: forgotPwLink, data: data);
  }

  /// Login by apple, This function only test on iPhone
  Future<void> loginApple({Function success, Function fail, context}) async {
    try {
      final result = await AppleSignIn.performRequests([
        const AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
      ]);

      switch (result.status) {
        case AuthorizationStatus.authorized:
          {
            user = await _service.api.loginApple(
                token: String.fromCharCodes(result.credential.identityToken));
            if (FirebaseServices().isAvailable) {
              final AuthCredential credential =
                  OAuthProvider('apple.com').credential(
                accessToken:
                    String.fromCharCodes(result.credential.authorizationCode),
                idToken: String.fromCharCodes(result.credential.identityToken),
              );
              await FirebaseServices().auth.signInWithCredential(credential);
            }

            loggedIn = true;
            await saveUser(user);
            success(user);

            notifyListeners();
          }
          break;

        case AuthorizationStatus.error:
          fail(S.of(context).error(result.error));
          break;
        case AuthorizationStatus.cancelled:
          fail(S.of(context).loginCanceled);
          break;
      }
    } catch (err) {
      fail(S.of(context).loginErrorServiceProvider(err.toString()));
    }
  }

  /// Login by Firebase phone
  Future<void> loginFirebaseSMS(
      {String phoneNumber, Function success, Function fail, context}) async {
    try {
      user = await _service.api.loginSMS(token: phoneNumber);
      loggedIn = true;
      await saveUser(user);
      success(user);

      notifyListeners();
    } catch (err) {
      fail(S.of(context).loginErrorServiceProvider(err.toString()));
    }
  }

  /// Login by Facebook
  Future<void> loginFB({Function success, Function fail, context}) async {
    try {
      final result = await FacebookLogin().logIn(['email', 'public_profile']);

      if (result?.accessToken?.declinedPermissions?.isNotEmpty ?? false) {
        fail(S.of(context).loginCanceled);
        return;
      }

      switch (result.status) {
        case FacebookLoginStatus.loggedIn:
          final accessToken = result.accessToken;
          if (FirebaseServices().isAvailable) {
            AuthCredential credential =
                FacebookAuthProvider.credential(accessToken.token);
            await FirebaseServices().auth.signInWithCredential(credential);
          }

          user = await _service.api.loginFacebook(token: accessToken.token);

          loggedIn = true;

          await saveUser(user);

          success(user);
          break;
        case FacebookLoginStatus.cancelledByUser:
          fail(S.of(context).loginCanceled);
          break;
        case FacebookLoginStatus.error:
          fail(S.of(context).error(result.errorMessage));
          break;
      }

      notifyListeners();
    } catch (err) {
      fail(S.of(context).loginErrorServiceProvider(err.toString()));
    }
  }

  Future<void> loginGoogle({Function success, Function fail, context}) async {
    try {
      var _googleSignIn = GoogleSignIn(scopes: ['email']);
      var res = await _googleSignIn.signIn();

      if (res == null) {
        fail(S.of(context).loginCanceled);
      } else {
        var auth = await res.authentication;
        if (FirebaseServices().isAvailable) {
          AuthCredential credential =
              GoogleAuthProvider.credential(accessToken: auth.accessToken);
          await FirebaseServices().auth.signInWithCredential(credential);
        }
        user = await _service.api.loginGoogle(token: auth.accessToken);
        loggedIn = true;
        await saveUser(user);
        success(user);
        notifyListeners();
      }
    } catch (err, trace) {
      printLog(trace);
      printLog(err);
      fail(S.of(context).loginErrorServiceProvider(err.toString()));
    }
  }

  Future saveUserToFirestore() async {
    try {
      final token = await _firebaseMessaging.getToken();
      printLog('token: $token');
      await FirebaseServices().firestore.collection('users').doc(user.email).set(
          {'deviceToken': token, 'isOnline': true}, SetOptions(merge: true));
    } catch (e) {
      printLog(e);
    }
  }

  Future<void> saveUser(User user) async {
    final storage = LocalStorage('fstore');
    try {
      // ignore: unawaited_futures
      if (FirebaseServices().isAvailable &&
          kFluxStoreMV.contains(serverConfig['type'])) {
        await saveUserToFirestore();
      }

      // save to Preference
      var prefs = await SharedPreferences.getInstance();
      await prefs.setBool('loggedIn', true);

      // save the user Info as local storage
      final ready = await storage.ready;
      if (ready) {
        await storage.setItem(kLocalKey['userInfo'], user);
        delegate?.onLoaded(user);
      }
    } catch (err) {
      printLog(err);
    }
  }

  Future<void> getUser() async {
    final storage = LocalStorage('fstore');
    try {
      final ready = await storage.ready;

      if (ready) {
        final json = storage.getItem(kLocalKey['userInfo']);
        if (json != null) {
          user = User.fromLocalJson(json);
          loggedIn = true;
          final userInfo = await _service.api.getUserInfo(user.cookie);
          if (userInfo != null) {
            userInfo.isSocial = user.isSocial;
            user = userInfo;
          }
          delegate?.onLoaded(user);
          notifyListeners();
        }
      }
    } catch (err) {
      printLog(err);
    }
  }

  void setLoading(bool isLoading) {
    loading = isLoading;
    notifyListeners();
  }

  Future<void> createUser({
    String username,
    String password,
    String firstName,
    String lastName,
    String phoneNumber,
    bool isVendor,
    Function success,
    Function fail,
  }) async {
    try {
      loading = true;
      notifyListeners();
      if (FirebaseServices().isAvailable) {
        await FirebaseServices().auth?.createUserWithEmailAndPassword(
            email: username, password: password);
      }

      user = await _service.api.createUser(
        firstName: firstName,
        lastName: lastName,
        username: username,
        password: password,
        phoneNumber: phoneNumber,
        isVendor: isVendor ?? false,
      );
      loggedIn = true;
      await saveUser(user);
      success(user);

      loading = false;
      notifyListeners();
    } catch (err) {
      fail(err.toString());
      loading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    if (FirebaseServices().isAvailable) {
      await FirebaseServices().auth?.signOut();
    }

    await FacebookLogin().logOut();
    delegate?.onLogout(user);
    user = null;
    loggedIn = false;
    final storage = LocalStorage('fstore');
    try {
      final ready = await storage.ready;
      if (ready) {
        await storage.deleteItem(kLocalKey['userInfo']);
        await storage.deleteItem(kLocalKey['shippingAddress']);
        await storage.deleteItem(kLocalKey['recentSearches']);
        await storage.deleteItem(kLocalKey['opencart_cookie']);
        await storage.setItem(kLocalKey['userInfo'], null);

        var prefs = await SharedPreferences.getInstance();
        await prefs.setBool('loggedIn', false);
      }
      await _service.api.logout();
    } catch (err) {
      printLog(err);
    }
    notifyListeners();
  }

  Future<void> login(
      {username, password, Function success, Function fail}) async {
    try {
      loading = true;
      notifyListeners();
      user = await _service.api.login(
        username: username,
        password: password,
      );

      if (FirebaseServices().isAvailable) {
        try {
          await FirebaseServices().auth?.signInWithEmailAndPassword(
            email: username,
            password: password,
          );
        } catch (err) {
          /// In case this user was registered on web
          /// so Firebase user was not created.
          if (err is FirebaseAuthException && err.code == 'user-not-found') {
            /// Create Firebase user automatically.
            await FirebaseServices().auth?.createUserWithEmailAndPassword(
              email: username,
              password: password,
            );
          }

          /// Ignore other cases.
        }
      }

      loggedIn = true;
      await saveUser(user);
      success(user);
      loading = false;
      notifyListeners();
    } catch (err) {
      loading = false;
      fail(err.toString());
      notifyListeners();
    }
  }

  Future<bool> isLogin() async {
    final storage = LocalStorage('fstore');
    try {
      final ready = await storage.ready;
      if (ready) {
        final json = storage.getItem(kLocalKey['userInfo']);
        return json != null;
      }
      return false;
    } catch (err) {
      return false;
    }
  }
}
