import 'package:flutter/material.dart';
import 'package:foodapp/components/my_button.dart';
import 'package:foodapp/components/my_textfield.dart';
import 'package:foodapp/data/model/CostFactor.dart';
import 'package:foodapp/data/model/customer.dart';
import 'package:foodapp/data/model/request.dart';
import 'package:foodapp/data/model/service.dart';
import 'package:foodapp/pages/home_page.dart';
import 'package:foodapp/pages/register_page.dart';

import '../data/repository/repository.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({
    super.key,
    this.onTap,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  List<Requests> requestsCustomer = [];
  List<Customer> customers = [];
  List<Requests> requests = [];
  List<Services> services = [];
  List<CostFactor> costFactor = [];

  String? phoneError;
  String? passwordError;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    var repository = DefaultRepository();

    final customerData = await repository.loadCustomer();
    final requestData = await repository.loadRequest();
    final servicesData = await repository.loadServices();
    final costFactorData = await repository.loadCostFactor();

    setState(() {
      customers = customerData ?? [];
      requests = requestData ?? [];
      services = servicesData ?? [];
      costFactor = costFactorData ?? [];
    });
  }

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

    for (int i = 0; i < customers.length; i++) {
      if (customers[i].phone == phone &&
          customers[i].password == password) {
        isValid = true;
        customerIndex = i;
        break;
      }
    }

    if (isValid) {
      requestsCustomer = requests
          .where((request) =>
              request.customerInfo.fullName ==
              customers[customerIndex].name)
          .toList();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            customer: customers[customerIndex],
            requests: requestsCustomer,
            services: services,
            costFactor: costFactor,
            featuredStaff: [
              {
                'name': 'Phạm Nguyễn Quốc Huy',
                'avatar': 'lib/images/staff/anhhuy.jpg',
                'position': 'Thợ sửa ổng nước',
                'rating': "4.8",
                'completedJobs': "120",
              },
              {
                'name': 'Trần Phi Hùng',
                'avatar': 'lib/images/staff/anhhung.jpg',
                'position': 'Thợ điện chuyên nghiệp',
                'rating': "4.5",
                'completedJobs': "98",
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
