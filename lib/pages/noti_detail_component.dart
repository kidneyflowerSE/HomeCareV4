import 'package:flutter/material.dart';
import 'package:foodapp/components/my_button.dart';

class NotiDetailComponent extends StatelessWidget {
  final String title;
  final String description;
  final String time;

  const NotiDetailComponent({
    super.key,
    required this.title,
    required this.description,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chi tiết thông báo',
          style: TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
        // automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              child: Image.asset('lib/images/logo.png'),
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            Text(
              time,
              style: const TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: MyButton(text: "Đăng ký người giúp việc ngay", onTap: () {}),
      ),
    );
  }
}
