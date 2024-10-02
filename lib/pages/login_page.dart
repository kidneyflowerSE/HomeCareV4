import 'package:foodapp/components/my_button.dart';
import 'package:foodapp/components/my_textfield.dart';
import 'package:foodapp/data/model/customer.dart';
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
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadCustomerData();
  }

  Future<void> loadCustomerData() async {
    var repository = DefaultRepository();
    var data = await repository.loadCustomer();
    setState(() {
      customers = data ?? [];
      _isLoading = false;
    });
  }

  //login method
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
      // navigate to home page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(customer: customers[index]),
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
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Nền với các hình tròn
          Positioned(
            left: 0,
            top: -70,
            child: ClipRect(
              child: Align(
                alignment: Alignment.topLeft,
                widthFactor: 1.0,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: const BoxDecoration(
                    color: Colors.yellow,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: -80,
            top: -30,
            child: ClipRect(
              child: Align(
                alignment: Alignment.topLeft,
                widthFactor: 1.0,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: -70,
            child: ClipRect(
              child: Align(
                alignment: Alignment.bottomRight,
                widthFactor: 1.0,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: const BoxDecoration(
                    color: Colors.yellow,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: -80,
            bottom: -30,
            child: ClipRect(
              child: Align(
                alignment: Alignment.bottomRight,
                widthFactor: 1.0,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),

          // Nội dung trang đăng nhập
          Padding(
            padding: const EdgeInsets.only(top: 45),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //logo
                  Image.asset(
                    'lib/images/logo.png',
                    width: 220,
                    height: 220,
                  ),

                  const SizedBox(height: 20),
                  // message, app slogan
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 25),
                        child: Text(
                          "Đăng nhập",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              fontFamily: 'Quicksand'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  // email textfield
                  MyTextField(
                    controller: emailController,
                    hintText: "Email hoặc số điện thoại",
                    obscureText: false,
                  ),

                  const SizedBox(height: 10),

                  // password textfield
                  MyTextField(
                    controller: passwordController,
                    hintText: "Mật khẩu",
                    obscureText: true,
                  ),

                  const SizedBox(height: 25),

                  // sign in button
                  MyButton(text: "Đăng nhập", onTap: login),

                  const SizedBox(height: 10),

                  // not a member? register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Chưa có tài khoản?",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Quicksand',
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: widget.onTap,
                        // onTap: login,
                        child: const Text(
                          "Đăng ký",
                          style: TextStyle(
                              fontFamily: 'Quicksand',
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
