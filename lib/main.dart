import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jupiter_web_app/pages/homepage.dart';
import 'package:jupiter_web_app/pages/splash_screen.dart';
import 'package:jupiter_web_app/pages/webview.dart';
import 'package:jupiter_web_app/provider/link_provider.dart';
import 'package:provider/provider.dart';
import 'globals.dart' as globals;

void main() {
  globals.weblink = "";
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: LinkProvider()..getallLinkss()),
          ],
          child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              initialRoute:SplashScreen.routeName,
              routes: {
                HomePage.routeName: (context) =>const HomePage(),
                SplashScreen.routeName: (context) => const SplashScreen(),
                WebView.routeName: (context) =>  WebView(),
              }),
        );
      },
    );
  }
}

