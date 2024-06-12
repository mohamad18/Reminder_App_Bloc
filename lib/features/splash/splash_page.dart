import 'dart:async';
import 'package:flutter/material.dart';
import 'package:reminderapp_test/features/home/presentation/pages/home_page.dart';

class SplashPage extends StatefulWidget {
  static const String ROUTE = "splash_page";

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToNextPage();
  }

  _navigateToNextPage() async {
    Timer(const Duration(seconds: 3),
        () => Navigator.pushReplacementNamed(context, HomePage.ROUTE));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
