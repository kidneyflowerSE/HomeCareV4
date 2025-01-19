import 'package:flutter/material.dart';
import 'package:foodapp/components/my_button.dart';
import 'package:foodapp/components/my_textfield.dart';
import 'package:foodapp/data/model/customer.dart';
import 'package:foodapp/data/model/request.dart';
import 'package:foodapp/data/model/service.dart';
import 'package:foodapp/pages/home_page.dart';
import 'package:foodapp/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  final List<Customer> customers;
  final List<Requests> requests;
  final List<Services> services;

  const LoginPage({
    super.key,
    required this.customers,
    required this.requests,
    required this.services,
    this.onTap,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  List<Requests> requestsCustomer = [];

  String? phoneError;
  String? passwordError;

  void login() {
    setState(() {
      phoneError = null;
      passwordError = null;
    });

    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();

    if (phone.isEmpty) {
      setState(() => phoneError = "Số điện thoại không được để trống.");
      return;
    }

    if (!RegExp(r'^\d{10}$').hasMatch(phone)) {
      setState(() =>
          phoneError = "Số điện thoại không hợp lệ. Vui lòng nhập 10 số.");
      return;
    }

    if (password.isEmpty) {
      setState(() => passwordError = "Mật khẩu không được để trống.");
      return;
    }

    bool isValid = false;
    int customerIndex = 0;

    for (int i = 0; i < widget.customers.length; i++) {
      if (widget.customers[i].phone == phone &&
          widget.customers[i].password == password) {
        isValid = true;
        customerIndex = i;
        break;
      }
    }

    if (isValid) {
      requestsCustomer = widget.requests
          .where((request) =>
              request.customerInfo.fullName ==
              widget.customers[customerIndex].name)
          .toList();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            customer: widget.customers[customerIndex],
            requests: requestsCustomer,
            services: widget.services,
            featuredStaff: [
              {
                'name': 'Nguyễn Văn A',
                'avatar': 'lib/images/staff/anhhuy.jpg',
                'position': 'Chuyên gia sửa chữa',
                'rating': "4.8",
                'completedJobs': "120",
                'isTopRated': "true",
              },
              {
                'name': 'Trần Phi Hùng',
                'avatar': 'lib/images/staff/anhhung.jpg',
                'position': 'Thợ điện chuyên nghiệp',
                'rating': "4.5",
                'completedJobs': "98",
                'isTopRated': "false",
              },
            ],
          ),
        ),
      );
    } else {
      setState(() => passwordError = "Số điện thoại hoặc mật khẩu không đúng.");
    }
  }

  @override
  Widget build(BuildContext context) {
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

              const Text(
                "Chào mừng trở lại!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Quicksand',
                ),
              ),

              const SizedBox(height: 8),
              const Text(
                "Hãy đăng nhập để tiếp tục",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontFamily: 'Quicksand',
                ),
              ),

              const SizedBox(height: 30),

              MyTextField(
                controller: phoneController,
                hintText: "Số điện thoại",
                obscureText: false,
                keyboardType: TextInputType.number,
              ),
              if (phoneError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    phoneError!,
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ),

              const SizedBox(height: 15),

              MyTextField(
                controller: passwordController,
                hintText: "Mật khẩu",
                obscureText: true,
                keyboardType: TextInputType.text,
              ),
              if (passwordError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    passwordError!,
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ),

              const SizedBox(height: 25),

              MyButton(
                text: "Đăng nhập",
                onTap: login,
              ),

              const SizedBox(height: 20),

              Row(
                children: const [
                  Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Hoặc",
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Quicksand',
                      ),
                    ),
                  ),
                  Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                ],
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Chưa có tài khoản?",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontFamily: 'Quicksand',
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterPage(),
                      ),
                    ),
                    child: const Text(
                      " Đăng ký",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Quicksand',
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
