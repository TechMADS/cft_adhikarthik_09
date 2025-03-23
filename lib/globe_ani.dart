
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';

import 'authentication_page.dart';
import 'homepage.dart';


class GlobeAnimationScreen extends StatefulWidget {
  const GlobeAnimationScreen({super.key});

  @override
  _GlobeAnimationScreenState createState() => _GlobeAnimationScreenState();
}

class _GlobeAnimationScreenState extends State<GlobeAnimationScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this, duration: Duration(seconds: 4));

  @override
  void initState() {
    super.initState();
    for(int i=0; i<10; i++){
      print("$i \n ");
    }
    // fetchData();
    _controller.forward().whenComplete(() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

      // If logged in, go to MainPage; otherwise, go to Login Page
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => isLoggedIn ? HomeScreen() : AuthScreen())

      );
    });
  }

  late final Animation<double> _positionAnimation = Tween(begin: -200.0, end: 300.0).animate(_controller);
  late final Animation<double> _scaleAnimation = Tween(begin: 0.5, end: 2.8).animate(_controller);
  late final Animation<double> _rotationAnimation = Tween(begin: 0.0, end: pi * 2).animate(_controller);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, __) => Transform.translate(
            offset: Offset(0, _positionAnimation.value),
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: Transform.rotate(angle: _rotationAnimation.value, child: Image.asset('assets/globe_ani.png', width: 200)),
            ),
          ),
        ),
      ),
    );
  }
}