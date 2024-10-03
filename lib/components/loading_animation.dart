import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class LoadingIndicator extends StatelessWidget {
  final double progress; // Giá trị tiến trình
  final Duration loadingDuration; // Thời gian tải

  const LoadingIndicator({
    Key? key,
    required this.progress,
    required this.loadingDuration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Sử dụng Stack để đan xen màu
        Stack(
          children: [
            // Thanh tiến trình màu gradient
            LinearPercentIndicator(
              width: MediaQuery.of(context).size.width * 0.8,
              lineHeight: 30.0, // Chiều cao thanh tiến trình
              percent: progress,
              center: Text(
                "${(progress * 100).toStringAsFixed(0)}%", // Hiển thị phần trăm
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20, // Kích thước chữ
                ),
              ),
              backgroundColor: Colors.grey[300],
              progressColor: Colors.transparent, // Không màu cho thanh tiến trình gốc
              barRadius: const Radius.circular(20), // Tạo hiệu ứng đường tròn cho đầu
              animation: false,
            ),
            // Hiệu ứng Gradient cho thanh tiến trình
            Container(
              height: 30.0,
              width: MediaQuery.of(context).size.width * 0.8 * progress,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.greenAccent, Colors.green], // Gradient màu
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(20), // Đường tròn cho đầu
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26, // Bóng mờ
                    blurRadius: 8.0, // Mờ bóng
                    spreadRadius: 1.0,
                  ),
                ],
              ),
            ),
            // Thanh trắng di chuyển
            AnimatedContainer(
              duration: const Duration(milliseconds: 500), // Thời gian cho hoạt ảnh
              width: MediaQuery.of(context).size.width * 0.8 * progress, // Chiều rộng tùy thuộc vào tiến trình
              height: 30.0,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3), // Màu trắng trong suốt
                borderRadius: BorderRadius.circular(20), // Đường tròn cho đầu
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Thêm một văn bản thông báo với kiểu dáng đẹp hơn
        Text(
          "Đang tải dữ liệu... (${loadingDuration.inSeconds}s)",
          style: const TextStyle(
            fontSize: 20, // Tăng kích thước chữ
            fontWeight: FontWeight.bold, // Đậm hơn
            color: Colors.black87, // Màu sắc tối hơn
          ),
        ),
      ],
    );
  }
}