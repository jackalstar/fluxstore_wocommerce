import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../common/constants.dart';
import '../../widgets/common/animated_splash.dart';
import '../../widgets/common/custom_splash.dart';
import '../../widgets/common/flare_splash_screen.dart';
import '../../widgets/common/rive_splashscreen.dart';
import '../../widgets/common/static_splashscreen.dart';

class VendorAdminSplashScreen extends StatelessWidget {
  final Widget nextScreen;

  const VendorAdminSplashScreen({Key key, @required this.nextScreen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var splashScreenType = kSplashScreenType;
    dynamic splashScreenData = kSplashScreen;
    void _showNextScreen() {
      Navigator.of(context).pushReplacement(
          CupertinoPageRoute(builder: (BuildContext context) => nextScreen));
    }

    if (splashScreenType == 'rive') {
      const animationName = kAnimationName;
      return RiveSplashScreen(
        onSuccess: _showNextScreen,
        asset: splashScreenData,
        animationName: animationName,
      );
    }

    if (splashScreenType == 'flare') {
      return SplashScreen.navigate(
        name: splashScreenData,
        startAnimation: 'fluxstore',
        backgroundColor: Colors.white,
        next: _showNextScreen,
        until: () => Future.delayed(const Duration(seconds: 2)),
      );
    }

    if (splashScreenType == 'animated') {
      debugPrint('[FLARESCREEN] Animated');
      return AnimatedSplash(
        imagePath: splashScreenData,
        next: _showNextScreen,
        duration: 2500,
        type: AnimatedSplashType.StaticDuration,
        isPushNext: true,
      );
    }
    if (splashScreenType == 'zoomIn') {
      return CustomSplash(
        imagePath: splashScreenData,
        backGroundColor: Colors.white,
        animationEffect: 'zoom-in',
        logoSize: 50,
        next: _showNextScreen,
        duration: 2500,
      );
    }
    if (splashScreenType == 'static') {
      return StaticSplashScreen(
        imagePath: splashScreenData,
        onNextScreen: _showNextScreen,
      );
    }
    return const SizedBox();
  }
}
