import 'package:flutter/material.dart';

class FeaturedStaffList extends StatelessWidget {
  final List<Map<String, dynamic>> staff;

  const FeaturedStaffList({super.key, required this.staff});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Nhân viên nổi bật",
          style: TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 190, // Chiều cao cố định lớn hơn để chứa thêm thông tin
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: staff.length,
            itemBuilder: (context, index) {
              final item = staff[index];
              return Container(
                margin: const EdgeInsets.only(right: 16),
                padding: const EdgeInsets.only(
                  top: 6,
                  right: 4,
                  left: 4,
                ),
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    width: 0.5,
                    color: Colors.green,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Ảnh đại diện
                    Stack(
                      children: [
                        Positioned(
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage(item['avatar']),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(4),
                            child: const Icon(
                              Icons.star,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Tên nhân viên
                    Text(
                      item['name'],
                      style: const TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    // Vị trí công việc
                    Text(
                      item['position'],
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    // Đánh giá
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star,
                            size: 16, color: Colors.yellow.shade700),
                        Text(
                          '${item['rating']} / 5',
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Số lượt phục vụ
                    Text(
                      '${item['completedJobs']} lượt phục vụ',
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 12,
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
