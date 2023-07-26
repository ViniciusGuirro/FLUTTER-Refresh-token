import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/auth_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(
        seconds: 2,
      ),
      () async {
        SharedPreferences localStorage = await SharedPreferences.getInstance();

        validateToken().then(
          (value) async => {
            if (value != 'true')
              {
                Navigator.pushReplacementNamed(context, '/login'),
                localStorage.clear()
              }
            else
              {Navigator.pushReplacementNamed(context, '/home')}
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          end: Alignment.topRight,
          begin: Alignment.bottomLeft,
          stops: const [0.1, 0.5],
          colors: [
            Colors.indigo.shade600,
            Colors.indigo.shade900,
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          SizedBox(
            height: 20,
          ),
          CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(
            Colors.white,
          )),
        ],
      ),
    );
  }
}
