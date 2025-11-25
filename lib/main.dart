import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/nav_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔥 Safe Hive Initialization
  try {
    await Hive.initFlutter();
    await Hive.openBox('wishlist');
    print("✅ Hive Initialized Successfully");
  } catch (e) {
    print("⚠️ Hive Failed to Load (Web Issue?): $e");
    // App crash hone se bacha lenge
  }

  runApp(const NetflixApp());
}

class NetflixApp extends StatelessWidget {
  const NetflixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Netflix Clone",
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme.apply(bodyColor: Colors.white, displayColor: Colors.white),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE50914), brightness: Brightness.dark),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        NavScreen.routeName: (context) => const NavScreen(),
      },
    );
  }
}