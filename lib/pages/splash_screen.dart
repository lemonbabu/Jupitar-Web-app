import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jupiter_web_app/pages/homepage.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName='splashscreen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
 @override
  void initState() {
   Timer(
       const Duration(seconds: 2),
           () async {
         Navigator.pushReplacementNamed(context, HomePage.routeName);
           });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Center(
        child: SizedBox(width: 200.w,child: Image.asset("images/splash.PNG")),
      ),
    );
  }
}
