import 'package:flutter/material.dart';
import 'package:foodapp/components/my_button.dart';
import 'package:foodapp/components/my_textfield.dart';

class EditStaffPage extends StatelessWidget {
  const EditStaffPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "Chỉnh sửa thông tin",
          style: TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                "lib/images/staff/anhhuy.jpg",
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 40),
            MyTextField(
              controller: nameController,
              hintText: "Họ tên của bạn",
              obscureText: false,
              keyboardType: TextInputType.text,
            ),
            MyTextField(
              controller: emailController,
              hintText: "Nhập email của bạn (không bắt buộc)",
              obscureText: false,
              keyboardType: TextInputType.text,
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: MyButton(
            text: "Lưu",
            onTap: () {
              Navigator.pop(context);
            }),
      ),
    );
  }
}
