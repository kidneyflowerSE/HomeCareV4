import 'package:flutter/material.dart';
import 'package:foodapp/pages/noti_detail_component.dart';

class NotiComponent extends StatelessWidget {
  const NotiComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 229, 229, 229),
      body: ListView(
        padding: const EdgeInsets.all(8),
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
          _buildNotificationItem(
            context,
            title: "Nhà sạch thảnh thơi, căng tràn hứng khởi",
            description:
                "Cuộc sống bận rộn, nhiều việc nhà? Đừng lo lắng! Có HomeCare, việc nhà trở thành việc nhỏ ngay lập tức.",
            time: "Thứ năm, 05/09/2024 - 17:13",
          ),
          _buildNotificationItem(
            context,
            title: "Cuộc sống tiện lợi ngay trong tầm tay bạn",
            description:
                "Từ nay bạn không phải lo lắng về công việc nhà, khó khăn tìm người giúp việc, giá cả rõ ràng và nhiều ưu đãi",
            time: "Thứ năm, 05/09/2024 - 13:11",
          ),
          _buildNotificationItem(
            context,
            title: "Save Time with On-demand Home Services",
            description:
                "Is your busy life leaving you no time to take care of your family",
            time: "Thứ tư, 04/09/2024 - 09:34",
          ),
          _buildNotificationItem(
            context,
            title: "Cám ơn bạn đã chọn HomeCare",
            description:
                "Tặng bạn 4 Voucher lên đến 120K. Đổi với Voucher Ưu Đãi ngay trên ứng dụng HomeCare.🎁",
            time: "Thứ tư, 04/09/2024 - 08:03",
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
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.green.shade800,
            width: 1,
          ),
          color: const Color.fromARGB(255, 248, 247, 247),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              child: Image.asset(
                'lib/images/logo_noti.png',
                height: 40,
                width: 40,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 8),
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(color: Colors.grey.shade400),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Quicksand',
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      description,
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      time,
                      style: const TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// class NotificationDetailPage extends StatelessWidget {
//   final String title;
//   final String description;
//   final String time;

//   const NotificationDetailPage({
//     Key? key,
//     required this.title,
//     required this.description,
//     required this.time,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chi tiết thông báo'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: TextStyle(
//                 fontFamily: 'Quicksand',
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               description,
//               style: TextStyle(
//                 fontFamily: 'Quicksand',
//                 fontSize: 16,
//               ),
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Thời gian: $time',
//               style: TextStyle(
//                 fontFamily: 'Quicksand',
//                 fontSize: 12,
//                 color: Colors.grey.shade600,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }













// import 'package:flutter/material.dart';

// class NotiComponent extends StatelessWidget {
//   const NotiComponent({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 229, 229, 229),
//       body: Column(
//         children: [
//           Container(
//             padding: EdgeInsets.all(8),
//             margin: EdgeInsets.all(8),
//             decoration: BoxDecoration(
//                 border: Border.all(
//                   color: Colors.grey.shade400,
//                   width: 1,
//                 ),
//                 color: const Color.fromARGB(255, 241, 241, 241),
//                 borderRadius: BorderRadius.circular(14)),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 ClipRRect(
//                   child: Image.asset(
//                     'lib/images/logo_noti.png',
//                     height: 40,
//                     width: 40,
//                   ),
//                 ),
//                 SizedBox(width: 8),
//                 Expanded(
//                   child: Container(
//                     padding: EdgeInsets.only(left: 8),
//                     decoration: BoxDecoration(
//                       border: Border(
//                         left: BorderSide(color: Colors.grey.shade400),
//                       ),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Lợi ích tuyệt vời khi vệ sinh ngôi nhà sạch sẽ thường xuyên",
//                           softWrap: true,
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontFamily: 'Quicksand',
//                             color: Colors.green,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         const SizedBox(height: 5),
//                         Text(
//                           "Giữ ngôi nhà sạch sẽ thường xuyên mang lại nhiều lợi ích quan trọng cho sức khỏe, tinh thần và cuộc sống hàng ngày của bạn",
//                           softWrap: true,
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                             fontFamily: 'Quicksand',
//                             fontSize: 12,
//                           ),
//                         ),
//                         const SizedBox(height: 5),
//                         Text(
//                           "Chủ nhật, 15/09/2024 - 10:51",
//                           style: TextStyle(
//                             fontFamily: 'Quicksand',
//                             fontSize: 10,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.all(8),
//             margin: EdgeInsets.all(8),
//             decoration: BoxDecoration(
//                 border: Border.all(
//                   color: Colors.grey.shade400,
//                   width: 1,
//                 ),
//                 color: const Color.fromARGB(255, 241, 241, 241),
//                 borderRadius: BorderRadius.circular(14)),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 ClipRRect(
//                   child: Image.asset(
//                     'lib/images/logo_noti.png',
//                     height: 40,
//                     width: 40,
//                   ),
//                 ),
//                 SizedBox(width: 8),
//                 Expanded(
//                   child: Container(
//                     padding: EdgeInsets.only(left: 8),
//                     decoration: BoxDecoration(
//                       border: Border(
//                         left: BorderSide(color: Colors.grey.shade400),
//                       ),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Mẹo hay giúp giữ cho ngôi nhà luôn gọn gàng và sạch sẽ",
//                           softWrap: true,
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontFamily: 'Quicksand',
//                             color: Colors.green,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         const SizedBox(height: 5),
//                         Text(
//                           "HomeCare gợi ý cho bạn một số mẹo hay giúp cho ngôi nhà luôn sạch sẽ",
//                           softWrap: true,
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                             fontFamily: 'Quicksand',
//                             fontSize: 12,
//                           ),
//                         ),
//                         const SizedBox(height: 5),
//                         Text(
//                           "Thứ bảy, 14/09/2024 - 10:07",
//                           style: TextStyle(
//                             fontFamily: 'Quicksand',
//                             fontSize: 10,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.all(8),
//             margin: EdgeInsets.all(8),
//             decoration: BoxDecoration(
//                 border: Border.all(
//                   color: Colors.grey.shade400,
//                   width: 1,
//                 ),
//                 color: const Color.fromARGB(255, 241, 241, 241),
//                 borderRadius: BorderRadius.circular(14)),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 ClipRRect(
//                   child: Image.asset(
//                     'lib/images/logo_noti.png',
//                     height: 40,
//                     width: 40,
//                   ),
//                 ),
//                 SizedBox(width: 8),
//                 Expanded(
//                   child: Container(
//                     padding: EdgeInsets.only(left: 8),
//                     decoration: BoxDecoration(
//                       border: Border(
//                         left: BorderSide(color: Colors.grey.shade400),
//                       ),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Bạn nhận được 4 Voucher lên đến 120K",
//                           softWrap: true,
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontFamily: 'Quicksand',
//                             color: Colors.green,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         const SizedBox(height: 5),
//                         Text(
//                           "Đổi Voucher Ưu Đãi và tận hưởng ngay trên ứng dụng HomeCare nha.",
//                           softWrap: true,
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                             fontFamily: 'Quicksand',
//                             fontSize: 12,
//                           ),
//                         ),
//                         const SizedBox(height: 5),
//                         Text(
//                           "Thứ sáu, 06/09/2024 - 03:29",
//                           style: TextStyle(
//                             fontFamily: 'Quicksand',
//                             fontSize: 10,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.all(8),
//             margin: EdgeInsets.all(8),
//             decoration: BoxDecoration(
//                 border: Border.all(
//                   color: Colors.grey.shade400,
//                   width: 1,
//                 ),
//                 color: const Color.fromARGB(255, 241, 241, 241),
//                 borderRadius: BorderRadius.circular(14)),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 ClipRRect(
//                   child: Image.asset(
//                     'lib/images/logo_noti.png',
//                     height: 40,
//                     width: 40,
//                   ),
//                 ),
//                 SizedBox(width: 8),
//                 Expanded(
//                   child: Container(
//                     padding: EdgeInsets.only(left: 8),
//                     decoration: BoxDecoration(
//                       border: Border(
//                         left: BorderSide(color: Colors.grey.shade400),
//                       ),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Đặt Lịch Dọn Dẹp Nhà Dễ Dàng Chỉ Trong 1 Phút! Ưu Đãi 120K cho bạn mới",
//                           softWrap: true,
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontFamily: 'Quicksand',
//                             color: Colors.green,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         const SizedBox(height: 5),
//                         Text(
//                           "Bạn quá bận rộn và không có thời gian để dọn dẹp nhà cửa? Hãy để HomeCare giúp bạn! Chỉ cần vài thao tác đơn giản trên ứng dụng.",
//                           softWrap: true,
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                             fontFamily: 'Quicksand',
//                             fontSize: 12,
//                           ),
//                         ),
//                         const SizedBox(height: 5),
//                         Text(
//                           "Thứ năm, 05/09/2024 - 20:53",
//                           style: TextStyle(
//                             fontFamily: 'Quicksand',
//                             fontSize: 10,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.all(8),
//             margin: EdgeInsets.all(8),
//             decoration: BoxDecoration(
//                 border: Border.all(
//                   color: Colors.grey.shade400,
//                   width: 1,
//                 ),
//                 color: const Color.fromARGB(255, 241, 241, 241),
//                 borderRadius: BorderRadius.circular(14)),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 ClipRRect(
//                   child: Image.asset(
//                     'lib/images/logo_noti.png',
//                     height: 40,
//                     width: 40,
//                   ),
//                 ),
//                 SizedBox(width: 8),
//                 Expanded(
//                   child: Container(
//                     padding: EdgeInsets.only(left: 8),
//                     decoration: BoxDecoration(
//                       border: Border(
//                         left: BorderSide(color: Colors.grey.shade400),
//                       ),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Nhà sạch thảnh thơi, căng tràn hứng khởi",
//                           softWrap: true,
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontFamily: 'Quicksand',
//                             color: Colors.green,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         const SizedBox(height: 5),
//                         Text(
//                           "Cuộc sống bận rộn, nhiều việc nhà? Đừng lo lắng! Có HomeCare, việc nhà trở thành việc nhỏ ngay lập tức.",
//                           softWrap: true,
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                             fontFamily: 'Quicksand',
//                             fontSize: 12,
//                           ),
//                         ),
//                         const SizedBox(height: 5),
//                         Text(
//                           "Thứ năm, 05/09/2024 - 17:13",
//                           style: TextStyle(
//                             fontFamily: 'Quicksand',
//                             fontSize: 10,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.all(8),
//             margin: EdgeInsets.all(8),
//             decoration: BoxDecoration(
//                 border: Border.all(
//                   color: Colors.grey.shade400,
//                   width: 1,
//                 ),
//                 color: const Color.fromARGB(255, 241, 241, 241),
//                 borderRadius: BorderRadius.circular(14)),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 ClipRRect(
//                   child: Image.asset(
//                     'lib/images/logo_noti.png',
//                     height: 40,
//                     width: 40,
//                   ),
//                 ),
//                 SizedBox(width: 8),
//                 Expanded(
//                   child: Container(
//                     padding: EdgeInsets.only(left: 8),
//                     decoration: BoxDecoration(
//                       border: Border(
//                         left: BorderSide(color: Colors.grey.shade400),
//                       ),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Cuộc sống tiện lợi ngay trong tầm tay bạn",
//                           softWrap: true,
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontFamily: 'Quicksand',
//                             color: Colors.green,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         const SizedBox(height: 5),
//                         Text(
//                           "Từ nay bạn không phải lo lắng về công việc nhà, khó khăn tìm người gúp việc, giá cả rõ ràng và nhiều ưu đãi",
//                           softWrap: true,
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                             fontFamily: 'Quicksand',
//                             fontSize: 12,
//                           ),
//                         ),
//                         const SizedBox(height: 5),
//                         Text(
//                           "Thứ năm, 05/09/2024 - 13:11",
//                           style: TextStyle(
//                             fontFamily: 'Quicksand',
//                             fontSize: 10,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
