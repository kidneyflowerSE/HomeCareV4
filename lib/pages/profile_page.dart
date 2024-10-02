import 'package:flutter/material.dart';
import 'package:foodapp/components/my_button.dart';
import 'package:foodapp/pages/edit_staff_page.dart';
import 'package:foodapp/pages/login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    super.key,
  });

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
      ),
      body: ListView(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'Pham Nguyen Quoc Huy',
                              style: TextStyle(
                                fontFamily: 'Quicksand',
                                fontSize: 16,
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const EditStaffPage()),
                                );
                              },
                              child: const Icon(
                                Icons.edit_square,
                                size: 16,
                                color: Colors.green,
                              ),
                            )
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
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
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              //================== LIST PERSONAL ================================
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    height: 50,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                    ),
                    child: const Text(
                      "Cá nhân",
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    height: 50,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      // border: Border.symmetric(
                      //   horizontal: BorderSide(
                      //     color: Colors.grey.shade600,
                      //   ),
                      // ),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.edit_calendar,
                          size: 16,
                          color: Colors.green,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "Lịch sử thanh toán",
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    height: 50,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      border: Border.symmetric(
                        horizontal: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          size: 16,
                          color: Colors.green,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "Địa chỉ đã lưu",
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    height: 50,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      // border: Border.symmetric(
                      //   horizontal: BorderSide(
                      //     color: Colors.grey.shade400,
                      //   ),
                      // ),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.heart_broken,
                          size: 16,
                          color: Colors.green,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "Nhân viên yêu thích",
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    height: 50,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      border: Border.symmetric(
                        horizontal: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.person_off_rounded,
                          size: 16,
                          color: Colors.green,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "Yêu cầu xóa tài khoản",
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              //==================== LIST PRIVACY =====================
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    height: 50,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                    ),
                    child: const Text(
                      "Quy trình, điều khoản, chính sách",
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    height: 50,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      // border: Border.symmetric(
                      //   horizontal: BorderSide(
                      //     color: Colors.grey.shade600,
                      //   ),
                      // ),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.person_pin_rounded,
                          size: 16,
                          color: Colors.green,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "Quyền lợi của khách hàng",
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    height: 50,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      border: Border.symmetric(
                        horizontal: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.gavel_rounded,
                          size: 16,
                          color: Colors.green,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "Pháp lý",
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    height: 50,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      // border: Border.symmetric(
                      //   horizontal: BorderSide(
                      //     color: Colors.grey.shade400,
                      //   ),
                      // ),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.school,
                          size: 16,
                          color: Colors.green,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "Quy trình đào tạo người giúp việc",
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              //================== ASK =======================
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    height: 50,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                    ),
                    child: const Text(
                      "Trợ giúp & hỗ trợ",
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    height: 50,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      border: Border.symmetric(
                        horizontal: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.headset_mic,
                          size: 16,
                          color: Colors.green,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "Trung tâm hỗ trợ",
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    height: 50,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      // border: Border.symmetric(
                      //   horizontal: BorderSide(
                      //     color: Colors.grey.shade400,
                      //   ),
                      // ),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.question_mark_rounded,
                          size: 16,
                          color: Colors.green,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "Câu hỏi thường gặp",
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    height: 50,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      border: Border.symmetric(
                        horizontal: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.question_answer_rounded,
                          size: 16,
                          color: Colors.green,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "Góp ý, khiếu nợ qua App",
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          MyButton(
            text: "Đăng xuất",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(
                    onTap: () {},
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
