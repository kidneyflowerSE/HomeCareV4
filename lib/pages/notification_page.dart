import 'package:flutter/material.dart';
import 'package:foodapp/pages/noti_detail_page.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'dart:math';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool isLoading = true;
  List<Map<String, dynamic>> notifications = [];
  int notificationCount = 10; // Số lượng thông báo ban đầu
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    await Future.delayed(const Duration(seconds: 1)); // Giả lập tải dữ liệu
    List<Map<String, dynamic>> fakeData = List.generate(
      notificationCount,
      (index) => {
        "id": index + 1,
        "title": _generateTitle(),
        "description": _generateDescription(),
        "time": DateTime.now().subtract(Duration(
            minutes: _random.nextInt(59),
            hours: _random.nextInt(24),
            days: _random.nextInt(10))),
        "isRead": _random.nextBool(),
      },
    );

    setState(() {
      notifications = fakeData;
      isLoading = false;
    });
  }

  Future<void> _loadMoreNotifications() async {
    await Future.delayed(
        const Duration(seconds: 1)); // Giả lập tải thêm dữ liệu

    List<Map<String, dynamic>> newNotifications = List.generate(
      5,
      (index) => {
        "id": notifications.length + index + 1,
        "title": _generateTitle(),
        "description": _generateDescription(),
        "time": DateTime.now().subtract(Duration(
            minutes: _random.nextInt(59),
            hours: _random.nextInt(24),
            days: _random.nextInt(10))),
        "isRead": _random.nextBool(),
      },
    );

    setState(() {
      notifications.addAll(newNotifications);
    });
  }

  void _markAsRead(int index) {
    setState(() {
      notifications[index]["isRead"] = true;
    });
  }

  void _deleteNotification(int index) {
    setState(() {
      notifications.removeAt(index);
    });
  }

  String _formatTime(DateTime dateTime) {
    return DateFormat('HH:mm dd/MM/yyyy').format(dateTime);
  }

  String _generateTitle() {
    List<String> titles = [
      "Lịch hẹn mới!",
      "Cập nhật đơn hàng",
      "Thông báo hệ thống",
      "Ưu đãi đặc biệt!",
      "Nhắc nhở lịch trình",
      "Cảnh báo bảo mật",
      "Tài khoản của bạn",
      "Đánh giá dịch vụ",
      "Cập nhật chính sách",
      "Sự kiện sắp diễn ra"
    ];
    return titles[_random.nextInt(titles.length)];
  }

  String _generateDescription() {
    List<String> descriptions = [
      "Bạn có một lịch hẹn vào ngày mai lúc 9:00 AM.",
      "Đơn hàng của bạn đã được xác nhận.",
      "Hệ thống sẽ bảo trì vào lúc 23:00 hôm nay.",
      "Nhận ưu đãi giảm 20% khi đặt dịch vụ hôm nay.",
      "Bạn có lịch trình vào lúc 14:00 ngày mai.",
      "Có cảnh báo đăng nhập từ một thiết bị mới.",
      "Vui lòng cập nhật mật khẩu của bạn để bảo vệ tài khoản.",
      "Hãy để lại đánh giá của bạn về dịch vụ.",
      "Chúng tôi vừa cập nhật chính sách quyền riêng tư.",
      "Sự kiện giảm giá lên đến 50% sắp diễn ra!"
    ];
    return descriptions[_random.nextInt(descriptions.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Thông báo",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Quicksand',
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: isLoading
          ? Center(
              child: Lottie.asset(
                'lib/images/loading.json', // Lottie loading
                width: 120,
                height: 120,
                repeat: true,
              ),
            )
          : RefreshIndicator(
              color: Colors.green,
              onRefresh: _loadNotifications,
              child: notifications.isEmpty
                  ? Center(
                      child: ClipRRect(
                      child: Image.asset('lib/images/logo.png'),
                    ))
                  : ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: notifications.length + 1,
                      itemBuilder: (context, index) {
                        if (index == notifications.length) {
                          return Center(
                            child: ElevatedButton(
                              onPressed: _loadMoreNotifications,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                "Tải thêm thông báo",
                                style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        }

                        final notification = notifications[index];

                        return Dismissible(
                          key: Key(notification["id"].toString()),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            color: Colors.red,
                            child:
                                const Icon(Icons.delete, color: Colors.white),
                          ),
                          onDismissed: (direction) {
                            _deleteNotification(index);
                          },
                          child: GestureDetector(
                            onTap: () {
                              _markAsRead(index);
                            },
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        NotificationDetailPage(
                                            notification: notification),
                                  ),
                                );
                              },
                              child: Card(
                                color: notification["isRead"]
                                    ? Colors.white
                                    : Colors.green.shade50,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 3,
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: notification["isRead"]
                                        ? Colors.grey.shade300
                                        : Colors.green.shade700,
                                    child: Icon(
                                      notification["isRead"]
                                          ? Icons.notifications_none
                                          : Icons.notifications_active,
                                      color: Colors.white,
                                    ),
                                  ),
                                  title: Text(
                                    notification["title"],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Quicksand',
                                      color: Colors.black87,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        notification["description"],
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[700],
                                          fontFamily: 'Quicksand',
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        _formatTime(notification["time"]),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: notification["isRead"]
                                      ? null
                                      : Container(
                                          width: 10,
                                          height: 10,
                                          decoration: const BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
    );
  }
}
