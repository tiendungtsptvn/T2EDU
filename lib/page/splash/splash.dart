import 'package:flutter/material.dart';
import 'package:t4edu_source_source/global/app_path.dart';
import 'package:t4edu_source_source/global/app_routes.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  @override
  void initState() {
    new Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushNamed(context, AppRouter.confirmOTPForPass);
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        child: Center(
          child: Text("Splash",
            style: TextStyle(
              color: Colors.black,
              fontSize: 25
            ),
          ),
        ),
        // height: double.infinity,
        // child: Center(
        //   child: Image.asset(
        //     AppPath.logo_login,
        //   ),
        // ),
      ),
    );
  }
}