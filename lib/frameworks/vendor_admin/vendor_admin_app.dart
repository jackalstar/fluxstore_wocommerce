import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import '../../common/config.dart';
import '../../generated/l10n.dart';
import '../../models/app_model.dart';
import '../../models/entities/user.dart';
import '../../services/index.dart';
import 'colors_config/theme.dart';
import 'models/authentication_model.dart';
import 'models/category_model.dart';
import 'models/main_screen_model.dart';
import 'models/notification_screen_model.dart';
import 'models/product_attribute_model.dart';
import 'models/product_list_screen_model.dart';
import 'models/review_approval_screen_model.dart';
import 'models/review_pending_screen_model.dart';
import 'screens/login_screen.dart';
import 'screens/screen_index.dart';
import 'splash_screen.dart';

class VendorAdminApp extends StatefulWidget {
  final User user;
  final bool isFromMV;

  const VendorAdminApp({Key key, this.user, this.isFromMV = false})
      : super(key: key);

  @override
  _VendorAdminAppState createState() => _VendorAdminAppState();
}

class _VendorAdminAppState extends State<VendorAdminApp> {
  @override
  void initState() {
    Services().setAppConfig(serverConfig);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        if (widget.user == null)
          ChangeNotifierProvider<AppModel>(
            create: (_) => AppModel(),
          ),
        ChangeNotifierProvider<VendorAdminAuthenticationModel>(
            create: (_) => VendorAdminAuthenticationModel(user: widget.user)),
        ChangeNotifierProvider<VendorAdminCategoryModel>(
            create: (_) => VendorAdminCategoryModel()),
      ],
      child: Consumer2<AppModel, VendorAdminCategoryModel>(
        builder: (context, model, model3, _) {
          return MaterialApp(
            theme: ColorsConfig.getTheme(context, model.darkTheme),
            debugShowCheckedModeBanner: false,
            locale: Locale(model.langCode, ''),
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            home: widget.isFromMV
                ? Scaffold(
                    body: Consumer<VendorAdminAuthenticationModel>(
                      builder: (context, model2, _) => LayoutBuilder(
                        builder: (context, _) {
                          if (model2.state !=
                              VendorAdminAuthenticationModelState.loggedIn) {
                            return VendorAdminLoginScreen();
                          }
                          return MultiProvider(
                            providers: [
                              ChangeNotifierProvider<
                                      VendorAdminNotificationScreenModel>(
                                  create: (_) =>
                                      VendorAdminNotificationScreenModel(
                                          model2.user)),
                              ChangeNotifierProvider<
                                      VendorAdminProductListScreenModel>(
                                  create: (_) =>
                                      VendorAdminProductListScreenModel(
                                          model2.user)),
                              ChangeNotifierProvider<
                                      VendorAdminMainScreenModel>(
                                  create: (_) =>
                                      VendorAdminMainScreenModel(model2.user)),
                              ChangeNotifierProvider<
                                      VendorAdminReviewApprovalScreenModel>(
                                  create: (_) =>
                                      VendorAdminReviewApprovalScreenModel(
                                          model2.user)),
                              ChangeNotifierProvider<
                                      VendorAdminReviewPendingScreenModel>(
                                  create: (_) =>
                                      VendorAdminReviewPendingScreenModel(
                                          model2.user)),
                              ChangeNotifierProvider<
                                      VendorAdminProductAttributeModel>(
                                  create: (_) =>
                                      VendorAdminProductAttributeModel(
                                          model2.user)),
                            ],
                            builder: (context, _) {
                              return ScreenIndex(
                                isFromMv: widget.isFromMV,
                              );
                            },
                          );
                        },
                      ),
                    ),
                  )
                : Scaffold(
                    body: VendorAdminSplashScreen(
                      nextScreen: Consumer<VendorAdminAuthenticationModel>(
                        builder: (context, model2, _) =>
                            LayoutBuilder(builder: (context, _) {
                          if (model2.state !=
                              VendorAdminAuthenticationModelState.loggedIn) {
                            return VendorAdminLoginScreen();
                          }
                          return MultiProvider(
                            providers: [
                              ChangeNotifierProvider<
                                      VendorAdminNotificationScreenModel>(
                                  create: (_) =>
                                      VendorAdminNotificationScreenModel(
                                          model2.user)),
                              ChangeNotifierProvider<
                                      VendorAdminProductListScreenModel>(
                                  create: (_) =>
                                      VendorAdminProductListScreenModel(
                                          model2.user)),
                              ChangeNotifierProvider<
                                      VendorAdminMainScreenModel>(
                                  create: (_) =>
                                      VendorAdminMainScreenModel(model2.user)),
                              ChangeNotifierProvider<
                                      VendorAdminReviewApprovalScreenModel>(
                                  create: (_) =>
                                      VendorAdminReviewApprovalScreenModel(
                                          model2.user)),
                              ChangeNotifierProvider<
                                      VendorAdminReviewPendingScreenModel>(
                                  create: (_) =>
                                      VendorAdminReviewPendingScreenModel(
                                          model2.user)),
                              ChangeNotifierProvider<
                                      VendorAdminProductAttributeModel>(
                                  create: (_) =>
                                      VendorAdminProductAttributeModel(
                                          model2.user)),
                            ],
                            builder: (context, _) {
                              return ScreenIndex(isFromMv: widget.isFromMV);
                            },
                          );
                        }),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
