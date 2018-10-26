import 'package:flutter/material.dart';
import 'package:loading_screen_experiment/homepage.dart';

class LaunchAnimation extends StatefulWidget {
  @override
  _LaunchAnimationState createState() => _LaunchAnimationState();
}

class _LaunchAnimationState extends State<LaunchAnimation>
    with TickerProviderStateMixin {
  AnimationController animationController;

//  Animation<double> circleAnimation;
  Animation colorAnimation;
  Animation<Alignment> logoAnimation;
  Animation<Alignment> textAnimation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 3000),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => HomePage(),
            ),
          );
        }
      });

//    circleAnimation =
//        Tween<double>(begin: 45.0, end: 700.0).animate(animationController);
    colorAnimation = ColorTween(begin: Colors.black, end: Colors.yellow).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0.0,
          0.2,
          curve: Curves.linear,
        ),
      ),
    );
    logoAnimation =
        AlignmentTween(begin: Alignment.center, end: Alignment(0.0, -0.6))
            .animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0.220,
          0.440,
          curve: Curves.linear,
        ),
      ),
    );
    textAnimation =
        AlignmentTween(end: Alignment.center, begin: Alignment(0.0, 0.6))
            .animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0.220,
          0.440,
          curve: Curves.linear,
        ),
      ),
    );

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorAnimation.value,
      body: Center(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: logoAnimation.value,
              child: FadeTransition(
                opacity: Tween<double>(begin: 1.0, end: 0.0).animate(
                  CurvedAnimation(
                    parent: animationController,
                    curve: Interval(
                      0.250,
                      0.550,
                      curve: Curves.linear,
                    ),
                  ),
                ),
                child: FlutterLogo(
                  size: 45.0,
                ),
              ),
            ),
            Align(
              alignment: textAnimation.value,
              child: FadeTransition(
                opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                    parent: animationController,
                    curve: Interval(
                      0.430,
                      0.580,
                      curve: Curves.linear,
                    ),
                  ),
                ),
                child: Text(
                  'Random Text',
                  style: Theme.of(context).textTheme.title,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
