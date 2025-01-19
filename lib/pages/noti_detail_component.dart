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
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image Section
            Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.green),
                  borderRadius: BorderRadius.circular(8)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'lib/images/logo.png',
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Title
            Text(
              title,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 20,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 15),
            // Description
            Text(
              description,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Quicksand',
                color: Colors.black87,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            // Time
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                time,
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'Quicksand',
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
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
