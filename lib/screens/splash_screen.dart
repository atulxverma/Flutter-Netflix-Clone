import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to Login after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        // If you don't have the image asset yet, use a Text or Icon
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             // Replace with Image.asset("assets/images/netflix_logo.png", width: 200)
            const Text(
              "NETFLIX",
              style: TextStyle(
                color: Color(0xFFE50914),
                fontSize: 50,
                fontWeight: FontWeight.w900,
                letterSpacing: 2.0,
              ),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(color: Color(0xFFE50914)),
          ],
        ),
      ),
    );
  }
}