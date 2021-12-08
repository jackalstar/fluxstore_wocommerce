import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

import 'onboarding_constants.dart';

class OnBoardingWidget extends StatefulWidget {
  final List data;
  final bool isRequiredLogin;
  final String titleSignIn;
  final String titleSignUp;
  final String titlePrev;
  final String titleSkip;
  final String titleNext;
  final String titleDone;
  final String layout;
  final Function onTapSignIn;
  final Function onTapSignUp;
  final Function onTapDone;

  OnBoardingWidget({
    @required this.data,
    this.isRequiredLogin = false,
    this.layout,
    this.titleSignIn,
    this.titleSignUp,
    this.titlePrev,
    this.titleSkip,
    this.titleNext,
    this.titleDone,
    this.onTapSignIn,
    this.onTapSignUp,
    this.onTapDone,
  });

  @override
  _OnBoardingWidgetState createState() => _OnBoardingWidgetState();
}

class _OnBoardingWidgetState extends State<OnBoardingWidget> {
  bool get isRequiredLogin => widget.isRequiredLogin ?? false;
  String get orderCompleted => ((data?.isNotEmpty ?? true) &&
          data.length == 3 &&
          (data[2]['image']?.isNotEmpty ?? false))
      ? data[2]['image']
      : '';
  List get data => widget.data ?? [];
  int page = 0;

  List<Slide> getSlides() {
    final slides = <Slide>[];

    final Widget loginWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        if (orderCompleted?.isNotEmpty ?? true)
          Image.asset(
            orderCompleted,
            fit: BoxFit.fitWidth,
          ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: widget.onTapSignIn,
                child: Text(
                  widget.titleSignIn ?? 'Sign In',
                  style: const TextStyle(
                    color: kColorTeal400,
                    fontSize: 20.0,
                  ),
                ),
              ),
              const Text(
                '    |    ',
                style: TextStyle(color: kColorTeal400, fontSize: 20.0),
              ),
              GestureDetector(
                onTap: widget.onTapSignUp ?? 'Sign Up',
                child: Text(
                  widget.onTapSignUp ?? '',
                  style: const TextStyle(
                    color: kColorTeal400,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );

    for (var i = 0; i < data.length; i++) {
      final slide = Slide(
        title: data[i]['title'],
        description: data[i]['desc'],
        marginTitle: const EdgeInsets.only(
          top: 125.0,
          bottom: 50.0,
        ),
        maxLineTextDescription: 2,
        styleTitle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25.0,
          color: kColorGrey900,
        ),
        backgroundColor: Colors.white,
        marginDescription: const EdgeInsets.fromLTRB(20.0, 75.0, 20.0, 0),
        styleDescription: const TextStyle(
          fontSize: 15.0,
          color: kColorGrey600,
        ),
        foregroundImageFit: BoxFit.fitWidth,
      );

      if (i == 2) {
        slide.centerWidget = loginWidget;
      } else {
        slide.pathImage = data[i]['image'];
      }
      slides.add(slide);
    }
    return slides;
  }

  static const textStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  List<Widget> getPages(List data) {
    return [
      for (int i = 0; i < data.length; i++)
        Container(
          color: HexColor(data[i]['background']),
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image.asset(
                data[i]['image'],
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 10),
              Column(
                children: <Widget>[
                  Text(
                    data[i]['title'],
                    style: textStyle.copyWith(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    data[i]['desc'],
                    style: textStyle,
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        )
    ];
  }

  Widget _buildDot(int index) {
    final selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((page ?? 0) - index).abs(),
      ),
    );
    final zoom = 1.0 + (2.0 - 1.0) * selectedness;
    return Container(
      width: 25.0,
      child: Center(
        child: Material(
          color: Colors.white,
          type: MaterialType.circle,
          child: Container(
            width: 8.0 * zoom,
            height: 8.0 * zoom,
          ),
        ),
      ),
    );
  }

  void pageChangeCallback(int lpage) {
    setState(() {
      page = lpage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final boardType = widget.layout;

    switch (boardType) {
      case 'liquid':
        return MaterialApp(
          home: Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: <Widget>[
                LiquidSwipe(
                  fullTransitionValue: 200,
                  enableSlideIcon: true,
                  enableLoop: true,
                  positionSlideIcon: 0.5,
                  onPageChangeCallback: pageChangeCallback,
                  waveType: WaveType.liquidReveal,
                  pages: getPages(data),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      const Expanded(child: SizedBox()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List<Widget>.generate(5, _buildDot),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      default:
        return Scaffold(
          backgroundColor: Colors.white,
          body: IntroSlider(
            slides: getSlides(),
            styleNameSkipBtn: const TextStyle(color: kColorGrey900),
            styleNameDoneBtn: const TextStyle(color: kColorGrey900),
            namePrevBtn: widget.titlePrev ?? 'Prev',
            nameSkipBtn: widget.titleSkip ?? 'Skip',
            nameNextBtn: widget.titleNext ?? 'Next',
            nameDoneBtn: isRequiredLogin ? '' : widget.titleDone ?? 'Done',
            isShowDoneBtn: !isRequiredLogin,
            onDonePress: widget.onTapDone,
          ),
        );
    }
  }
}
