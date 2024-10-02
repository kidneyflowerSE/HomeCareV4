import 'package:flutter/material.dart';

class MyAvt extends StatelessWidget {
  const MyAvt({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(154),
        border: Border.all(
          color: Colors.green,
          width: 4,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(150),
        child: Image.asset(
          'lib/images/staff/anhhuy.jpg',
          height: 300,
          width: 300,
        ),
      ),
    );
  }
}
