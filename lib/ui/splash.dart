import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  late int counter = 8;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      --counter;
      if (counter <= 0) {
        _timer.cancel();
        _navHome();
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) => Material(
    child: Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            "assets/images/bg_splash.jpeg",
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 96,
          right: 16,
          child: GestureDetector(
            onTap: _navHome,
            child: Container(
              width: 96,
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color.fromRGBO(255, 255, 255, 0.5),
              ),
              child: Text(
                "$counter s",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );

  void _navHome() => context.goNamed("home");

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}