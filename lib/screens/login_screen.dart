import 'package:flutter/material.dart';
import 'nav_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: (){}),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 🔥 LOGO ADDED HERE
              Image.asset(
                "assets/images/netflix_logo.png",
                width: 250, // Logo ka size
              ),
              const SizedBox(height: 40),
              
              _buildTextField("Email or phone number"),
              const SizedBox(height: 15),
              _buildTextField("Password", isPassword: true),
              
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE50914), // Netflix Red Button
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, NavScreen.routeName);
                  },
                  child: const Text("Sign In", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 20),
              const Text("Need help?", style: TextStyle(color: Colors.white54)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, {bool isPassword = false}) {
    return TextField(
      obscureText: isPassword,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade800,
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      ),
    );
  }
}