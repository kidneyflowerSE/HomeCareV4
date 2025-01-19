import 'dart:developer';
import 'package:foodapp/components/my_button.dart';
import 'package:foodapp/components/my_textfield.dart';
import 'package:foodapp/data/model/customer.dart';
import 'package:foodapp/data/model/request.dart';
import 'package:foodapp/data/model/service.dart';
import 'package:foodapp/data/repository/repository.dart';
import 'package:foodapp/pages/home_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({
    super.key,
    required this.onTap,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  List<Customer> customers = [];
  List<Requests> requests = [];
  List<Requests> requestsCustomer = [];
  List<Services> services = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadCustomerData();
    loadRequestData();
    loadServicesData();
  }

  Future<void> loadCustomerData() async {
    var repository = DefaultRepository();
    var data = await repository.loadCustomer();
    setState(() {
      customers = data ?? [];
      _isLoading = false;
    });
  }

  Future<void> loadRequestData() async {
    var repository = DefaultRepository();
    var data = await repository.loadRequest();
    setState(() {
      requests = data ?? [];
      _isLoading = false;
    });
  }

  Future<void> loadServicesData() async {
    var repository = DefaultRepository();
    var data = await repository.loadServices();
    setState(() {
      services = data ?? [];
      _isLoading = false;
    });
  }

  // Login method
  void login() {
    bool isTrue = false;
    int index = 0;
    for (index; index < customers.length; ++index) {
      if (passwordController.text == customers[index].password) {
        isTrue = true;
        break;
      }
    }
    if (isTrue) {
      requestsCustomer = requests
          .where((request) => request.customerInfo.fullName == 'tran phi hung')
          .toList();
      // Navigate to home page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            customer: customers[index],
            requests: requestsCustomer,
            services: services,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                'lib/images/logo.png',
                width: 180,
                height: 180,
              ),

              const SizedBox(height: 30),

              // Welcome text
              const Text(
                "Chào mừng trở lại!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Quicksand', // Sử dụng font Quicksand
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Hãy đăng nhập để tiếp tục",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontFamily: 'Quicksand', // Sử dụng font Quicksand
                ),
              ),

              const SizedBox(height: 30),

              // Email textfield
              MyTextField(
                controller: emailController,
                hintText: "Email hoặc số điện thoại",
                obscureText: false,
              ),

              const SizedBox(height: 15),

              // Password textfield
              MyTextField(
                controller: passwordController,
                hintText: "Mật khẩu",
                obscureText: true,
              ),

              const SizedBox(height: 25),

              // Login button
              MyButton(
                text: "Đăng nhập",
                onTap: login,
              ),

              const SizedBox(height: 20),

              // Divider with text
              Row(
                children: const [
                  Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Hoặc",
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Quicksand', // Sử dụng font Quicksand
                      ),
                    ),
                  ),
                  Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                ],
              ),

              const SizedBox(height: 20),

              // Register link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Chưa có tài khoản?",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontFamily: 'Quicksand', // Sử dụng font Quicksand
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      " Đăng ký",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Quicksand', // Sử dụng font Quicksand
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
