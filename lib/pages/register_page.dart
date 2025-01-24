import 'package:flutter/material.dart';
import 'package:foodapp/auth/login_or_register.dart';
import 'package:foodapp/components/my_button.dart';
import 'package:foodapp/components/my_textfield.dart';
import 'package:foodapp/pages/authen_page.dart';
import 'package:foodapp/pages/login_page.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({
    super.key,
    this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  String? phoneError;
  String? passwordError;
  String? confirmError;

  void validateAndRegister() {
    setState(() {
      phoneError = null;
      passwordError = null;
      confirmError = null;
    });

    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmController.text.trim();

    bool hasError = false;

    // Validate phone
    if (phone.isEmpty) {
      setState(() => phoneError = "Số điện thoại không được để trống.");
      hasError = true;
    } else if (!RegExp(r'^0\d{9}$').hasMatch(phone)) {
      setState(() => phoneError =
          "Số điện thoại không hợp lệ. Vui lòng nhập 10 chữ số và bắt đầu bằng số 0.");
      hasError = true;
    }

    // Validate password
    if (password.isEmpty) {
      setState(() => passwordError = "Mật khẩu không được để trống.");
      hasError = true;
    } else if (password.length < 6) {
      setState(() => passwordError = "Mật khẩu phải có ít nhất 6 ký tự.");
      hasError = true;
    }

    // Validate confirm password
    if (confirmPassword.isEmpty) {
      setState(() => confirmError = "Vui lòng xác nhận mật khẩu.");
      hasError = true;
    } else if (password != confirmPassword) {
      setState(() => confirmError = "Mật khẩu xác nhận không khớp.");
      hasError = true;
    }

    if (!hasError) {
      // Navigate to authentication page if validation passes
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AuthenticationPage(onTap: () {}),
        ),
      );
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

              // Welcome text
              const Text(
                "Tạo tài khoản mới",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Quicksand',
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Vui lòng nhập thông tin của bạn",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontFamily: 'Quicksand',
                ),
              ),

              const SizedBox(height: 30),

              // Phone textfield
              MyTextField(
                controller: phoneController,
                hintText: "Nhập số điện thoại",
                obscureText: false,
                keyboardType: TextInputType.number,
              ),
              if (phoneError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    phoneError!,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.red,
                      fontFamily: 'Quicksand',
                    ),
                  ),
                ),

              const SizedBox(height: 15),

              // Password textfield
              MyTextField(
                controller: passwordController,
                hintText: "Nhập mật khẩu",
                obscureText: true,
                keyboardType: TextInputType.text,
              ),
              if (passwordError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    passwordError!,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.red,
                      fontFamily: 'Quicksand',
                    ),
                  ),
                ),

              const SizedBox(height: 15),

              // Confirm password textfield
              MyTextField(
                controller: confirmController,
                hintText: "Xác nhận mật khẩu",
                obscureText: true,
                keyboardType: TextInputType.text,
              ),
              if (confirmError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    confirmError!,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.red,
                      fontFamily: 'Quicksand',
                    ),
                  ),
                ),

              const SizedBox(height: 25),

              // Sign up button
              MyButton(
                text: "Đăng ký",
                onTap: validateAndRegister,
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
                        fontFamily: 'Quicksand',
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
                      fontFamily: 'Quicksand',
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    ),
                    child: const Text(
                      " Đăng nhập",
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
