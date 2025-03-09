import 'package:flutter/material.dart';

class SupportCenterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Trung tâm hỗ trợ",
          style: TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.green,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Search functionality
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.indigo.shade50, Colors.white],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header section
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        colors: [Colors.green, Colors.green.shade800],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.support_agent,
                          color: Colors.white,
                          size: 48,
                        ),
                        SizedBox(height: 12),
                        Text(
                          "CHÚNG TÔI CÓ THỂ GIÚP GÌ CHO BẠN?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Quicksand',
                          ),
                        ),
                        SizedBox(height: 12),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Tìm kiếm hỗ trợ...",
                              hintStyle: TextStyle(
                                fontFamily: 'Quicksand',
                              ),
                              border: InputBorder.none,
                              icon: Icon(Icons.search, color: Colors.green),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24),

                // Quick support options
                Text(
                  "DỊCH VỤ HỖ TRỢ NHANH",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                    fontFamily: 'Quicksand',
                  ),
                ),
                SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: _buildQuickSupportCard(
                        context,
                        "Tư vấn viên trực tuyến",
                        Icons.headset_mic,
                        Colors.blue,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _buildQuickSupportCard(
                        context,
                        "Gọi điện ngay đến 1800 6868",
                        Icons.phone_in_talk,
                        Colors.green,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildQuickSupportCard(
                        context,
                        "Gửi yêu cầu đến chúng tôi",
                        Icons.mail_outline,
                        Colors.orange,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _buildQuickSupportCard(
                        context,
                        "Hỏi đáp thường gặp",
                        Icons.help_outline,
                        Colors.purple,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),

                // Contact info card
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.green,
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Thông tin liên hệ",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                                fontFamily: 'Quicksand',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(Icons.phone,
                                size: 18, color: Colors.grey.shade700),
                            SizedBox(width: 8),
                            Text(
                              "Hotline: 1900 6868",
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Quicksand',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(
                              Icons.email,
                              size: 18,
                              color: Colors.grey.shade700,
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Email: support@homekare.service",
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Quicksand',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 18,
                              color: Colors.grey.shade700,
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Giờ làm việc: 8:00 - 20:00 (T2-CN)",
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Quicksand',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(Icons.home,
                                size: 18, color: Colors.grey.shade700),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "Địa chỉ: 11 Nguyễn Đình Chiểu, P. ĐaKao, Quận 1, TP. Hồ Chí Minh",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Quicksand',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.chat),
        backgroundColor: Colors.green,
        tooltip: 'Trò chuyện trực tiếp',
      ),
    );
  }

  Widget _buildQuickSupportCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          // Handle support option tap
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundColor: color.withOpacity(0.2),
                radius: 24,
                child: Icon(icon, color: color, size: 24),
              ),
              SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                  fontFamily: 'Quicksand',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
