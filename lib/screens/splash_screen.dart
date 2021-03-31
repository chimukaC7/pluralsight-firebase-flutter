import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wiredbrain/models/activity.dart';
import 'package:wiredbrain/services/auth.dart';
import 'package:wiredbrain/services/firestore.dart';

import '../coffee_router.dart';
import 'home.dart';
import 'menu.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen();

  static String routeName = 'splashScreen';
  static Route<SplashScreen> route() {
    return MaterialPageRoute<SplashScreen>(
      settings: RouteSettings(name: routeName),
      builder: (BuildContext context) => SplashScreen(),
    );
  }

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthService _authService = AuthService.instance;
  final FirestoreService _firestoreService = FirestoreService.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/coffeback.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 600),
        child: SpinKitFadingCircle(
          color: Colors.white,
          size: 70.0,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(milliseconds: 1000),
      () {
        if (_authService.currentUser != null) {
          _firestoreService.addLog(
            activity: Activity.login,
            userId: _authService.currentUser!.uid,
          );
          CoffeeRouter.instance.pushReplacement(MenuScreen.route());
        } else {
          CoffeeRouter.instance.pushReplacement(HomeScreen.route());
        }
      },
    );
  }
}
