import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:foodapp/auth/login_or_register.dart';
import 'package:foodapp/components/spashscreen.dart';
import 'package:foodapp/themes/theme_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: context.watch<ThemeProvider>().themeData,
      home: const SplashScreen(),
    );
  }
}
