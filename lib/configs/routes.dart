import 'package:flutter/material.dart';
import 'package:reminderapp_test/features/home/presentation/pages/home_page.dart';
import 'package:reminderapp_test/features/splash/splash_page.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashPage.ROUTE:
      return MaterialPageRoute(builder: (context) => const SplashPage());
    case HomePage.ROUTE:
      return MaterialPageRoute(builder: (context) => const HomePage());
  }
  return null;
}
