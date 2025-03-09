import 'package:flutter/material.dart';

class FieldOrderService extends StatelessWidget {
  final String hintText;
  final Function(String)? onChanged;

  const FieldOrderService({
    super.key,
    required this.hintText,
    this.onChanged, // Nhận callback
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green),
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextField(
          onChanged: onChanged, // Gửi dữ liệu ra ngoài
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              fontFamily: 'Quicksand',
              fontStyle: FontStyle.italic,
              fontSize: 15,
              color: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          ),
        ),
      ),
    );
  }
}
