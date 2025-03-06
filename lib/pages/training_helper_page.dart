import 'package:flutter/material.dart';

class TrainingHelperPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Quy trình đào tạo người giúp việc",
          style: TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          // IconButton(
          //   icon: Icon(Icons.info_outline),
          //   onPressed: () {
          //     // Show info dialog
          //     showDialog(
          //       context: context,
          //       builder: (context) => AlertDialog(
          //         title: Text('Thông tin'),
          //         content: Text(
          //             'Chương trình đào tạo người giúp việc chuyên nghiệp.'),
          //         actions: [
          //           TextButton(
          //             onPressed: () => Navigator.pop(context),
          //             child: Text('Đóng'),
          //           ),
          //         ],
          //       ),
          //     );
          //   },
          // ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              // Share functionality
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
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        colors: [Colors.green, Colors.green.shade800],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.school, color: Colors.white, size: 36),
                            SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                "QUY TRÌNH ĐÀO TẠO NGƯỜI GIÚP VIỆC",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: 'Quicksand',
                                ),
                              ),
                            ),
                          ],
                        ),
                        // SizedBox(height: 12),
                        // Text(
                        //   "Chương trình đào tạo chuyên nghiệp với 4 bước đầy đủ",
                        //   style: TextStyle(
                        //     fontSize: 16,
                        //     color: Colors.white.withOpacity(0.9),
                        //     fontFamily: 'Quicksand',
                        //     fontWeight: FontWeight.w600,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12),

                // Process steps
                _buildEnhancedSection(
                  context,
                  "1. Tuyển chọn và đánh giá ban đầu",
                  [
                    "Kiểm tra lý lịch và kinh nghiệm làm việc của ứng viên.",
                    "Phỏng vấn và đánh giá thái độ, kỹ năng giao tiếp.",
                    "Kiểm tra sức khỏe để đảm bảo khả năng làm việc.",
                  ],
                  Icons.person_search,
                  Colors.blue,
                ),
                _buildEnhancedSection(
                  context,
                  "2. Đào tạo kỹ năng chuyên môn",
                  [
                    "Hướng dẫn kỹ năng dọn dẹp, nấu ăn, chăm sóc trẻ và người già.",
                    "Rèn luyện kỹ năng giao tiếp và ứng xử với khách hàng.",
                    "Đào tạo kỹ năng xử lý tình huống khẩn cấp.",
                  ],
                  Icons.build_circle,
                  Colors.orange,
                ),
                _buildEnhancedSection(
                  context,
                  "3. Đào tạo về đạo đức nghề nghiệp",
                  [
                    "Giáo dục tinh thần trách nhiệm và trung thực.",
                    "Đảm bảo tôn trọng quyền riêng tư và tài sản của khách hàng.",
                    "Hướng dẫn cách làm việc chuyên nghiệp và tận tâm.",
                  ],
                  Icons.volunteer_activism,
                  Colors.green,
                ),
                _buildEnhancedSection(
                  context,
                  "4. Kiểm tra và đánh giá cuối khóa",
                  [
                    "Bài kiểm tra thực hành để đánh giá tay nghề.",
                    "Đánh giá phản hồi từ khách hàng thử nghiệm.",
                    "Cấp chứng nhận hoàn thành khóa đào tạo.",
                  ],
                  Icons.fact_check,
                  Colors.purple,
                ),
                // SizedBox(height: 24),

                // Contact section
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
                            Icon(Icons.contact_support, color: Colors.green),
                            SizedBox(width: 8),
                            Text(
                              "Liên hệ tư vấn",
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
                              "Hotline: 1900 8686",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Quicksand',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(Icons.email,
                                size: 18, color: Colors.grey.shade700),
                            SizedBox(width: 8),
                            Text(
                              "Email: traininghelper@homecare.com",
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Quicksand',
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text('Đăng ký'),
        icon: Icon(Icons.app_registration),
        backgroundColor: Colors.green,
      ),
    );
  }

  Widget _buildEnhancedSection(
    BuildContext context,
    String title,
    List<String> points,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: color.withOpacity(0.2),
                  radius: 24,
                  child: Icon(icon, color: color, size: 24),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                      fontFamily: 'Quicksand',
                    ),
                  ),
                ),
              ],
            ),
            Divider(color: Colors.grey.shade300, height: 24),
            ...points.map((point) => Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.check_circle, color: color, size: 20),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          point,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade700,
                            height: 1.3,
                            fontFamily: 'Quicksand',
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
