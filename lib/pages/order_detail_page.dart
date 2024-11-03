import 'package:flutter/material.dart';

import '../data/model/request.dart';

class OrderDetailPage extends StatefulWidget {
  final Requests request;

  const OrderDetailPage({super.key, required this.request});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}
class _OrderDetailPageState extends State<OrderDetailPage>{

  @override
  Widget build(BuildContext context) {
    // Get the screen width and height for responsiveness
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Chi tiết dịch vụ",
          style: TextStyle(
            fontFamily: 'Quicksand',
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded( // Use Expanded to allow this button to stretch
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.1, // Adjusted horizontal padding
                  vertical: screenHeight * 0.015,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFe7e7e7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "Đặt dài hạn",
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(width: 10), // Space between buttons
            Expanded( // Use Expanded for the second button
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.1, // Adjusted horizontal padding
                  vertical: screenHeight * 0.015,
                ),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "Đặt lại",
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView( // Added SingleChildScrollView for scrolling
        child: Container(
          color: const Color(0xFFf2f1f6),
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.01),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(screenWidth * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.request.customerInfo.fullName,
                          style: const TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Container(
                          padding: EdgeInsets.all(screenWidth * 0.02),
                          decoration: const BoxDecoration(
                            color: Color(0xFFe2e1e8),
                          ),
                          child: Text(
                            widget.request.customerInfo.phone,
                            style: const TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        'lib/images/staff/anhhuy.jpg',
                        height: screenWidth * 0.2,
                        width: screenWidth * 0.2,
                        fit: BoxFit.cover, // Use BoxFit to ensure the image fits well
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Container(
                padding: EdgeInsets.all(screenWidth * 0.05),
                color: Colors.white,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFb3c7d5),
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(screenWidth * 0.025),
                        decoration: const BoxDecoration(
                          color: Color(0xFFebf7ff),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.calendar_month_outlined,
                              size: 40,
                              color: Colors.lightGreen,
                            ),
                            SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                            const Expanded( // Use Expanded to allow the text column to grow and prevent overflow
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Lên lịch dịch vụ",
                                    style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    "Đặt lịch dài hạn cho bạn",
                                    style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                            Container(
                              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                "Đặt lịch ngay",
                                style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(screenWidth * 0.025),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.circle,
                                  size: 16,
                                  color: Colors.green,
                                ),
                                SizedBox(width: screenWidth * 0.02),
                                const Expanded(
                                  child: Text(
                                    "Dọn dẹp nhà cửa, lau nhà, rửa chén, đổ rác",
                                    style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontSize: 15,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_rounded,
                                  size: 18,
                                  color: Colors.green,
                                ),
                                SizedBox(width: screenWidth * 0.02),
                                const Expanded(
                                  child: Text(
                                    "11 Nguyễn Đình Chiều, Phường ĐaKao, Quận 1, TP.Hồ Chí Minh",
                                    style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontSize: 15,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(screenWidth * 0.025),
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_today_rounded),
                            SizedBox(width: screenWidth * 0.02),
                            const Text(
                              "15:12",
                              style: TextStyle(
                                fontFamily: 'Quicksand',
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.02),
                            const Icon(Icons.circle, size: 8),
                            SizedBox(width: screenWidth * 0.02),
                            const Text(
                              "T2, T3, T4, T5, T6",
                              style: TextStyle(
                                fontFamily: 'Quicksand',
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(20),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Thanh toán",
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Cước phí",
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          "20.000đ",
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Khuyến mại",
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          "- 5.000đ",
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tổng cộng",
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "15.000đ",
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(20),
                      color: Colors.white,
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Mã đơn: 9088573842",
                            style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "19/10/2024 | 15:12",
                            style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Icon(
                                Icons.cleaning_services_rounded,
                                size: 24,
                                color: Colors.green,
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  "Dọn dẹp nhà cửa, lau nhà, rửa chén, đổ rác.",
                                  style: TextStyle(
                                    fontFamily: 'Quicksand',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.location_on_rounded,
                                size: 24,
                                color: Colors.red,
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "11 Nguyễn Đình Chiểu, Phường DaKao",
                                      style: TextStyle(
                                        fontFamily: 'Quicksand',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      "Quận 1, Thành Phố Hồ Chí Minh",
                                      style: TextStyle(
                                        fontFamily: 'Quicksand',
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFe7e7e7),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "Bạn cần hỗ trợ?",
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
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
      ),
    );
  }
}
