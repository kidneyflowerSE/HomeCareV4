import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // SliverAppBar
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.green.shade600, Colors.green.shade800],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, size: 50, color: Colors.green),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "User Name", // Tên tĩnh cho UI
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Quicksand',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // SliverList
          SliverList(
            delegate: SliverChildListDelegate(
              [
                // Section Cá nhân
                _buildSection(
                  context,
                  "Cá nhân",
                  [
                    MenuItem(Icons.edit_calendar, "Lịch sử thanh toán", () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const PaymentHistorySheet()),
                      // );
                    }),
                    MenuItem(Icons.person_off_rounded, "Yêu cầu xóa tài khoản",
                        () {
                      _showStaticDialog(context,
                          "Chức năng xóa tài khoản đang được thử nghiệm.");
                    }),
                  ],
                ),
                // Section Quy trình, điều khoản, chính sách
                _buildSection(
                  context,
                  "Quy trình, điều khoản, chính sách",
                  [
                    MenuItem(
                        Icons.person_pin_rounded, "Quyền lợi của khách hàng",
                        () {
                      _showStaticDialog(context,
                          "Quyền lợi khách hàng đang được thử nghiệm.");
                    }),
                    MenuItem(Icons.gavel_rounded, "Pháp lý", () {
                      _showStaticDialog(
                          context, "Pháp lý đang được thử nghiệm.");
                    }),
                    MenuItem(Icons.school, "Quy trình đào tạo người giúp việc",
                        () {
                      _showStaticDialog(
                          context, "Quy trình đào tạo đang được thử nghiệm.");
                    }),
                  ],
                ),
                // Section Trợ giúp & hỗ trợ
                _buildSection(
                  context,
                  "Trợ giúp & hỗ trợ",
                  [
                    MenuItem(Icons.headset_mic, "Trung tâm hỗ trợ", () {
                      _showStaticDialog(
                          context, "Trung tâm hỗ trợ đang được thử nghiệm.");
                    }),
                    MenuItem(Icons.question_mark_rounded, "Câu hỏi thường gặp",
                        () {
                      _showStaticDialog(
                          context, "Câu hỏi thường gặp đang được thử nghiệm.");
                    }),
                    MenuItem(Icons.question_answer_rounded,
                        "Góp ý, khiếu nại qua App", () {
                      _showStaticDialog(
                          context, "Phản hồi đang được thử nghiệm.");
                    }),
                  ],
                ),
                // Nút đăng xuất
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    onPressed: () {
                      _showStaticDialog(
                          context, "Đăng xuất đang được thử nghiệm.");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade600,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 2,
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
                // Phiên bản
                const Center(
                  child: Text(
                    "Version 2.0.25",
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Xây dựng section với tiêu đề và danh sách các menu item
  Widget _buildSection(
      BuildContext context, String title, List<MenuItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Text(
            title,
            style: const TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children:
                items.map((item) => _buildMenuItem(context, item)).toList(),
          ),
        ),
      ],
    );
  }

  // Xây dựng từng item trong danh sách menu
  Widget _buildMenuItem(BuildContext context, MenuItem item) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: ListTile(
        leading: Icon(item.icon, color: Colors.green.shade600, size: 22),
        title: Text(
          item.title,
          style: const TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
        trailing:
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: item.onTap,
      ),
    );
  }

  // Hiển thị hộp thoại tĩnh
  void _showStaticDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => Container(
        child: AlertDialog(
          title: const Text(
            "Thông báo",
            style: TextStyle(fontFamily: 'Quicksand'),
          ),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child:
                  const Text("OK", style: TextStyle(fontFamily: 'Quicksand')),
            ),
          ],
        ),
      ),
    );
  }
}

// Class đại diện cho các menu item
class MenuItem {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  MenuItem(this.icon, this.title, this.onTap);
}
