import 'package:bleach/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  /// For background
  List<Color> pallete = [
    const Color(0xFF8A2BE2),
    const Color(0xFF000000),
  ];

  /// Funtion for navigation
  navigateToHome(){
    Future.delayed(const Duration(
      seconds: 3
    )).then((value) {
      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => const HomeScreen(),));
    },);
  }

  @override
  void initState() {
    //navigateToHome();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: pallete,
            )
          ),
          child:  Center(
            child: Text(
              "BLEACH",
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 6,
                fontSize: 40,
              ),
            ),
          )
        ),
        ),
    );
  }
}
