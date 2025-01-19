import 'package:flutter/material.dart';
import 'package:foodapp/pages/noti_detail_component.dart';

class NotiComponent extends StatelessWidget {
  const NotiComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          _buildNotificationItem(
            context,
            title:
                "Lợi ích tuyệt vời khi vệ sinh ngôi nhà sạch sẽ thường xuyên",
            description:
                "🏡Giữ ngôi nhà sạch sẽ thường xuyên mang lại nhiều lợi ích quan trọng cho sức khỏe, tinh thần và cuộc sống hàng ngày của bạn",
            time: "Chủ nhật, 15/09/2024 - 10:51",
          ),
          _buildNotificationItem(
            context,
            title: "Mẹo hay giúp giữ cho ngôi nhà luôn gọn gàng và sạch sẽ",
            description:
                "HomeCare gợi ý cho bạn một số mẹo hay giúp cho ngôi nhà luôn sạch sẽ",
            time: "Thứ bảy, 14/09/2024 - 10:07",
          ),
          _buildNotificationItem(
            context,
            title: "Bạn nhận được 4 Voucher lên đến 120K",
            description:
                "Đổi Voucher Ưu Đãi và tận hưởng ngay trên ứng dụng HomeCare nha.",
            time: "Thứ sáu, 06/09/2024 - 03:29",
          ),
          _buildNotificationItem(
            context,
            title:
                "Đặt Lịch Dọn Dẹp Nhà Dễ Dàng Chỉ Trong 1 Phút! Ưu Đãi 120K cho bạn mới",
            description:
                "🎉Bạn quá bận rộn và không có thời gian để dọn dẹp nhà cửa? Hãy để HomeCare giúp bạn! Chỉ cần vài thao tác đơn giản trên ứng dụng.",
            time: "Thứ năm, 05/09/2024 - 20:53",
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(
    BuildContext context, {
    required String title,
    required String description,
    required String time,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotiDetailComponent(
              title: title,
              description: description,
              time: time,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        shadowColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.notifications,
                  color: Colors.green.shade700,
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Quicksand',
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Quicksand',
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
