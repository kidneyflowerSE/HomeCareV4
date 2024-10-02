import 'package:flutter/material.dart';

class FieldOrderService extends StatelessWidget {
  final String hintText;

  const FieldOrderService({
    super.key,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green), // Viền ngoài
          borderRadius: BorderRadius.circular(8), // Bo góc
        ),
        child: TextField(
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                fontFamily: 'Quicksand',
                fontStyle: FontStyle.italic,
                fontSize: 15,
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
              border: InputBorder.none, // Không viền bên trong
              contentPadding: const EdgeInsets.symmetric(horizontal: 20)),
        ),
      ),
    );
  }
}
