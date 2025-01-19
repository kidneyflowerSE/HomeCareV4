import 'package:flutter/material.dart';
import 'package:foodapp/auth/login_or_register.dart';
import 'package:foodapp/data/model/customer.dart';
import 'package:foodapp/data/model/request.dart';
import 'package:foodapp/data/model/service.dart';
import 'package:foodapp/data/repository/repository.dart';

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

  List<Customer> customers = [];
  List<Requests> requests = [];
  List<Services> services = [];

  @override
  void initState() {
    super.initState();

    // AnimationController chạy trong 3 giây cho typing effect
    _typingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() {
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
        final int dotCount = ((_dotsController.value * 3).floor() % 4);
        setState(() {
          _dots = "." * dotCount;
        });
      });

    _typingController.forward().then((_) {
      _dotsController.repeat();
    });

    // Tải dữ liệu khi splashscreen chạy
    loadData();
  }

  Future<void> loadData() async {
    var repository = DefaultRepository();

    final customerData = await repository.loadCustomer();
    final requestData = await repository.loadRequest();
    final servicesData = await repository.loadServices();

    setState(() {
      customers = customerData ?? [];
      requests = requestData ?? [];
      services = servicesData ?? [];
    });

    // Chuyển sang LoginPage sau khi dữ liệu được tải
    Future.delayed(const Duration(seconds: 5), _navigateToLoginPage);
  }

  void _navigateToLoginPage() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            LoginOrRegister(
          key: const ValueKey("LoginOrRegister"),
          customers: customers,
          requests: requests,
          services: services,
        ),
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
  void dispose() {
    _typingController.dispose();
    _dotsController.dispose();
    super.dispose();
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
