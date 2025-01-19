import 'package:flutter/material.dart';
import 'package:foodapp/components/my_button.dart';
import 'package:foodapp/components/my_textfield.dart';
import 'package:foodapp/pages/authen_page.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({
    super.key,
    required this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  void authen() {
    // Navigate to authentication page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AuthenticationPage(onTap: () {}),
      ),
    );
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

              // Welcome text
              const Text(
                "Tạo tài khoản mới",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Quicksand', // Đặt font chữ Quicksand
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Vui lòng nhập thông tin của bạn",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontFamily: 'Quicksand', // Đặt font chữ Quicksand
                ),
              ),

              const SizedBox(height: 30),

              // Email textfield
              MyTextField(
                controller: emailController,
                hintText: "Nhập email hoặc số điện thoại",
                obscureText: false,
              ),

              const SizedBox(height: 15),

              // Password textfield
              MyTextField(
                controller: passwordController,
                hintText: "Nhập mật khẩu",
                obscureText: true,
              ),

              const SizedBox(height: 15),

              // Confirm password textfield
              MyTextField(
                controller: confirmController,
                hintText: "Xác nhận mật khẩu",
                obscureText: true,
              ),

              const SizedBox(height: 25),

              // Sign up button
              MyButton(
                text: "Đăng ký",
                onTap: authen,
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
                        fontFamily: 'Quicksand', // Đặt font chữ Quicksand
                      ),
                    ),
                  ),
                  Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                ],
              ),

              const SizedBox(height: 20),

              // Already have an account? Login here
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Đã có tài khoản?",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontFamily: 'Quicksand', // Đặt font chữ Quicksand
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      " Đăng nhập",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Quicksand', // Đặt font chữ Quicksand
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
