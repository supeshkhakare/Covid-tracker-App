import 'dart:async';
import 'dart:math' as math;

import 'package:covid_tracker_app/Screens/world_states.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationcontroller = AnimationController(
    duration: const Duration(seconds: 10),
    vsync:
        this, //The vsync parameter is used to improve performance by pausing animations when they're not visible.
    //  It expects a class that implements TickerProvider, which SingleTickerProviderStateMixin provides.
  )..repeat();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => WorldStates())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedBuilder(
              animation: _animationcontroller,
              builder: (BuildContext context, Widget? child) {
                return Transform.rotate(
                    angle: _animationcontroller.value * 2.0 * math.pi,
                    child: child);
              },
              child: Container(
                height: 200,
                width: 200,
                child: Center(
                    child: Image(image: AssetImage('Assets/Images/virus.png'))),
              )),
          SizedBox(
            height: 100,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              "Covid\nTracker App",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey),
            ),
          )
        ],
      )),
    );
  }
}
