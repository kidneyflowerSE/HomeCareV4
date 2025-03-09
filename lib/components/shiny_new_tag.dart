import 'dart:math';

import 'package:flutter/material.dart';

class ShinyNewTag extends StatefulWidget {
  @override
  _ShinyNewTagState createState() => _ShinyNewTagState();
}

class _ShinyNewTagState extends State<ShinyNewTag>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true); // Tạo hiệu ứng lặp vô hạn
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [
                0.0,
                (_controller.value - 0.1).clamp(0.0, 1.0),
                _controller.value,
                (_controller.value + 0.1).clamp(0.0, 1.0),
                1.0,
              ],
              colors: [
                Colors.white,
                Colors.yellowAccent.withOpacity(0.8),
                Colors.orangeAccent.withOpacity(0.9),
                Colors.yellowAccent.withOpacity(0.8),
                Colors.white,
              ],
            ).createShader(bounds);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.redAccent.withOpacity(0.5),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: const Text(
              'NEW',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Quicksand',
              ),
            ),
          ),
        );
      },
    );
  }
}
