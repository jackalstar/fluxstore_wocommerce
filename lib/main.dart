import 'dart:io' show HttpClient;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pedantic/pedantic.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'app.dart';
import 'common/config.dart';
import 'common/constants.dart';
import 'common/firebase_services.dart';
import 'common/tools.dart';
import 'env.dart';
// import 'frameworks/vendor_admin/vendor_admin_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Configurations().setConfigurationValues(environment);

  GestureBinding.instance.resamplingEnabled = true;

  Provider.debugCheckInvalidValueType = null;
  printLog('[main] ============== main.dart START ==============');

  if (!kIsWeb) {
    /// enable network traffic logging
    HttpClient.enableTimelineLogging = true;

    unawaited(SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]));
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );
  }
//Remove this method to stop OneSignal Debugging
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.init(
      "YOUR_ONESIGNAL_APP_ID",
      iOSSettings: {
        OSiOSSettings.autoPrompt: false,
        OSiOSSettings.inAppLaunchUrl: false
      }
  );
  OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  await OneSignal.shared.promptUserForPushNotificationPermission(fallbackToSettings: true);
  // Initialize Firebase due to version 0.5.0+ requires to
  if (!isWindow) {
    await GmsTools().checkGmsAvailability();
    await FirebaseServices().init();

    if (FirebaseServices().isAvailable) {
      // await Configurations().loadRemoteConfig();
      printLog('[main] Initialize Firebase successfully');
    }
  }

  // if (serverConfig['type'] == 'vendorAdmin') {
  //   return runApp(const VendorAdminApp());
  // }

  ResponsiveSizingConfig.instance.setCustomBreakpoints(
      const ScreenBreakpoints(desktop: 900, tablet: 600, watch: 100));
  runApp(App());
}
