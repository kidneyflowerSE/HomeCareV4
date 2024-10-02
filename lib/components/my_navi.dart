import 'package:flutter/material.dart';

class MyNavigation extends StatelessWidget {
  const MyNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(
        left: 10.0,
        right: 10,
        top: 10,
        bottom: 10,
      ),
      color: Colors.green[400],
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: Image.asset(
              'lib/images/avt.png',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 20),
          const Expanded(
            // Đảm bảo Column có thể mở rộng
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Chào bạn, Huy!",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Quicksand',
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.attach_money_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                    Text(
                      "3.348.120.000đ",
                      style: TextStyle(
                          color: Colors.white, fontFamily: 'Quicksand'),
                    ),
                  ],
                ),
                Text(
                  "11 Nguyễn Đình Chiểu - Đa Kao - Quận 1 - TP.Hồ Chí Minh",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Quicksand',
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
