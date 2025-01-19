import 'package:flutter/material.dart';
import 'package:foodapp/components/my_button.dart';
import 'package:foodapp/components/spashscreen.dart';
import 'package:foodapp/pages/edit_staff_page.dart';
import 'package:foodapp/pages/login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        title: const Text(
          "Profile Page",
          style: TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 4,
      ),
      body: ListView(
        children: [
          // Profile Header Section
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    'lib/images/staff/anhhuy.jpg',
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Pham Nguyen Quoc Huy',
                              style: TextStyle(
                                fontFamily: 'Quicksand',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const EditStaffPage(),
                                ),
                              );
                            },
                            child: const Icon(
                              Icons.edit_square,
                              size: 20,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: const [
                          Icon(
                            Icons.phone,
                            size: 16,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 6),
                          Text(
                            '0796592839',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Personal Section
          _buildSectionHeader("Cá nhân"),
          _buildListTile(
            icon: Icons.edit_calendar,
            text: "Lịch sử thanh toán",
          ),
          _buildListTile(
            icon: Icons.location_on_rounded,
            text: "Địa chỉ đã lưu",
          ),
          _buildListTile(
            icon: Icons.heart_broken,
            text: "Nhân viên yêu thích",
          ),
          _buildListTile(
            icon: Icons.person_off_rounded,
            text: "Yêu cầu xóa tài khoản",
          ),
          const SizedBox(height: 20),

          // Privacy Section
          _buildSectionHeader("Quy trình, điều khoản, chính sách"),
          _buildListTile(
            icon: Icons.person_pin_rounded,
            text: "Quyền lợi của khách hàng",
          ),
          _buildListTile(
            icon: Icons.gavel_rounded,
            text: "Pháp lý",
          ),
          _buildListTile(
            icon: Icons.school,
            text: "Quy trình đào tạo người giúp việc",
          ),
          const SizedBox(height: 20),

          // Help & Support Section
          _buildSectionHeader("Trợ giúp & hỗ trợ"),
          _buildListTile(
            icon: Icons.headset_mic,
            text: "Trung tâm hỗ trợ",
          ),
          _buildListTile(
            icon: Icons.question_mark_rounded,
            text: "Câu hỏi thường gặp",
          ),
          _buildListTile(
            icon: Icons.question_answer_rounded,
            text: "Góp ý, khiếu nại qua App",
          ),
          const SizedBox(height: 20),

          // Logout Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SplashScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Đăng xuất",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Quicksand',
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // Section Header Widget
  Widget _buildSectionHeader(String title) {
    return Container(
      padding: const EdgeInsets.only(left: 20),
      height: 50,
      alignment: Alignment.centerLeft,
      color: Colors.grey[300],
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Quicksand',
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // List Tile Widget
  Widget _buildListTile({required IconData icon, required String text}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 50,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: Colors.green,
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
