import 'package:flutter/material.dart';
import 'package:foodapp/pages/login_page.dart';
import 'package:foodapp/pages/payment_page.dart';
import 'package:foodapp/pages/register_page.dart';

import '../auth/login_or_register.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _typingController;
  late AnimationController _dotsController;

  String _displayedText = "";
  String _fullText = "Cho cuộc sống tiện lợi hơn";
  String _dots = "";

  @override
  void initState() {
    super.initState();

    // AnimationController chạy trong 3 giây cho typing effect
    _typingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() {
        // Cập nhật văn bản dựa trên animation value
        final int currentLength =
            (_typingController.value * _fullText.length).floor();
        setState(() {
          _displayedText = _fullText.substring(0, currentLength);
        });
      });

    // AnimationController cho dấu ba chấm lặp lại
    _dotsController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
        // Hiển thị dấu ba chấm
        final int dotCount = ((_dotsController.value * 3).floor() % 4);
        setState(() {
          _dots = "." * dotCount;
        });
      });

    // Bắt đầu typing animation
    _typingController.forward().then((_) {
      // Sau khi typing xong, bắt đầu animation dấu ba chấm
      _dotsController.repeat();
    });

    // Chuyển sang LoginPage sau 5 giây
    Future.delayed(const Duration(seconds: 5), _navigateToLoginPage);
  }

  @override
  void dispose() {
    _typingController.dispose();
    _dotsController.dispose();
    super.dispose();
  }

  void _navigateToLoginPage() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const LoginOrRegister(),
        // const PaymentPage(amount: 500000),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset(
              'lib/images/logo.png',
              width: MediaQuery.of(context).size.width * 0.6,
              fit: BoxFit.contain,
            ),

            // Typing text animation
            Text(
              '$_displayedText$_dots',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
                fontFamily: 'Quicksand',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
