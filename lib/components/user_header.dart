import 'package:flutter/material.dart';

import '../../data/model/customer.dart';

class UserHeader extends StatelessWidget {
  final Customer customer;
  const UserHeader({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Đảm bảo chiều rộng chiếm toàn bộ màn hình
      padding: const EdgeInsets.only(
        left: 10.0,
        right: 10,
        top: 30,
        bottom: 10,
      ),
      color: Colors.green[400],
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: Image.asset(
              'lib/images/banner_1.png',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            // Đảm bảo Column có thể mở rộng
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Chào bạn, ${customer.name}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Quicksand',
                  ),
                ),
                const Row(
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
                  customer.addresses[0].detailedAddress,
                  style: const TextStyle(
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
