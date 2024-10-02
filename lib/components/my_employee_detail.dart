import 'package:flutter/material.dart';
import 'package:foodapp/components/my_button.dart';

class MyEmployeeDetail extends StatelessWidget {
  const MyEmployeeDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0), // Chiều cao của AppBar
        child: Container(
          decoration: BoxDecoration(
            color: Colors.green[400], // Màu nền của AppBar
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3), // Màu bóng
                spreadRadius: 3, // Bán kính lan của bóng
                blurRadius: 10, // Độ mờ của bóng
                offset: const Offset(0, 3), // Độ lệch của bóng theo trục x, y
              ),
            ],
          ),
          child: AppBar(
            automaticallyImplyLeading: false,
            // backgroundColor: Colors.transparent,
            // elevation: 0,
            centerTitle: true,
            title: const Text(
              "Chi tiết nhân viên",
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            leading: const Icon(Icons.arrow_back_ios_new_outlined),
            actions: [
              Icon(
                Icons.heart_broken,
                color: Colors.redAccent[700],
              ),
              const SizedBox(width: 16),
              const Icon(Icons.info_outline_rounded),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 25),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 100),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.green[400],
              ),
              height: 25,
              child: const Text(
                "Mã nhân viên: #49549",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Quicksand',
                    fontSize: 16),
              ),
            ),
            const SizedBox(height: 25),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(154),
                border: Border.all(
                  color: Colors.green,
                  width: 4,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(150),
                child: Image.asset(
                  'lib/images/staff/anhhuy.jpg',
                  height: 300,
                  width: 300,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Phạm Nguyễn Quốc Huy",
              style: TextStyle(
                  color: Colors.green[400],
                  fontFamily: 'Quicksand',
                  fontSize: 25,
                  fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on_sharp,
                  color: Colors.grey[400],
                ),
                const SizedBox(width: 5),
                Text(
                  "Quận Thủ Đức, TP.Hồ Chí Minh",
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 16,
                    fontFamily: 'Quicksand',
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                        "20",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Quicksand',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Tuổi",
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontFamily: 'Quicksand',
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "5",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Quicksand',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.amberAccent,
                          )
                        ],
                      ),
                      Text(
                        "Số sao",
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontFamily: 'Quicksand',
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                        "582",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Quicksand',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Giờ làm",
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontFamily: 'Quicksand',
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                        "239",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Quicksand',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Đánh giá",
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontFamily: 'Quicksand',
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.green.shade500,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 4),
                          )
                        ],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          width: 2,
                          color: Colors.green.shade800,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Quét nhà',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.green.shade500,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 4),
                          )
                        ],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          width: 2,
                          color: Colors.green.shade800,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Rửa chén',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.green.shade500,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 4),
                          )
                        ],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          width: 2,
                          color: Colors.green.shade800,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Nấu cơm',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.green.shade500,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 4),
                          )
                        ],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          width: 2,
                          color: Colors.green.shade800,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Giặt đồ',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: MyButton(text: "Đặt lịch với nhân viên này", onTap: () {}),
      ),
    );
  }
}
