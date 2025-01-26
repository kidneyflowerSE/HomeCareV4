import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/data/model/CostFactor.dart';
import 'package:foodapp/data/model/helper.dart';
import 'package:foodapp/pages/order_success_page.dart';
import 'package:foodapp/pages/payment_page.dart';
import '../data/model/customer.dart';
import '../data/model/request.dart';

class ReviewOrderPage extends StatefulWidget {
  final Customer customer;
  final Helper helper;
  final Requests request;
  final List<CostFactor> costFactors;

  const ReviewOrderPage({
    super.key,
    required this.customer,
    required this.helper,
    required this.request,
    required this.costFactors,
  });

  @override
  _ReviewOrderPageState createState() => _ReviewOrderPageState();
}

class _ReviewOrderPageState extends State<ReviewOrderPage> {
  bool isOnlinePayment = true;

  void showPopUpWarning(String warning) {
    AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.warning,
      desc: warning,
      btnOkOnPress: () {},
      btnCancelOnPress: () {},
    ).show();
  }

  Map<String, dynamic> totalCostCalculation(
      String date, String start, String end) {
    List<DateTime> holidays = [
      DateTime(2025, 4, 30), // Ngày Giải phóng miền Nam
      DateTime(2025, 5, 1), // Quốc tế Lao động
      DateTime(2025, 9, 2), // Quốc khánh
      DateTime(2025, 6, 1), // Quốc tế Thiếu nhi
      DateTime(2025, 7, 27), // Ngày Thương binh Liệt sĩ
      DateTime(2025, 11, 20) // Ngày Nhà giáo Việt Nam
    ];

    List<Coefficient> otherCoefficientList = [];

    // Lấy móc thời gian hành chính
    DateTime time = DateTime.parse(date);
    DateTime now = DateTime(time.year, time.month, time.day);
    DateTime eightAM = DateTime(now.year, now.month, now.day, 8, 0, 0);
    DateTime sixPM = DateTime(now.year, now.month, now.day, 16, 0, 0);

    // Chuyển đổi thời gian bắt đầu cho ngày trong tương lai
    DateTime startTimeNow = DateTime.parse(start);
    DateTime endTimeNow = DateTime.parse(end);
    DateTime startTime = DateTime(now.year, now.month, now.day,
        startTimeNow.hour, startTimeNow.minute, startTimeNow.second);
    DateTime endTime = DateTime(now.year, now.month, now.day, endTimeNow.hour,
        endTimeNow.minute, endTimeNow.second);

    // Gía của dịch vụ
    num basicPrice = widget.request.service.cost;

    // Hệ số cơ bản của dịch vụ
    num basicCoefficient = 0;

    // Lấy hệ số cơ bản
    for (var costFactor in widget.costFactors) {
      if (costFactor.title.compareTo('Hệ số lương cho dịch vụ') == 0) {
        basicCoefficient = costFactor.coefficientList
            .firstWhere((coefficient) =>
                coefficient.title.compareTo('Dịch vụ dọn dẹp') == 0)
            .value;
        break;
      }
    }

    // Lọc danh sách hệ số khác
    for (var costFactor in widget.costFactors) {
      if (costFactor.title.compareTo('Hệ số khác') == 0) {
        otherCoefficientList = costFactor.coefficientList;
      }
    }

    num totalCost = basicPrice * basicCoefficient;
    print('giá cơ bản: ${basicPrice}');
    print('hệ số dịch vụ: ${basicCoefficient}');
    print("giá cơ bản bình thường ${totalCost}");

    // Hệ số cho ngày lễ, Tết, Noel
    num holidayCoefficient = 1;
    if (holidays.any((holiday) =>
        holiday.month == startTime.month && holiday.day == startTime.day)) {
      holidayCoefficient =
          otherCoefficientList.firstWhere((e) => e.title == 'Hệ số lễ').value;
    } else if (startTime.month == 12 && startTime.day == 25) {
      // Noel
      holidayCoefficient =
          otherCoefficientList.firstWhere((e) => e.title == 'Hệ số noel').value;
    } else if (startTime.month == 1 && startTime.day == 1) {
      // Tết
      holidayCoefficient =
          otherCoefficientList.firstWhere((e) => e.title == 'Hệ số tết').value;
    }

    // Hệ số cho ngày cuối tuần
    num weekendCoefficient = 1;
    if (startTime.weekday == DateTime.saturday ||
        startTime.weekday == DateTime.sunday) {
      weekendCoefficient = otherCoefficientList
          .firstWhere((e) => e.title == 'Hệ số làm việc ngày cuối tuần')
          .value;
    }

    // Lấy hệ số lớn hơn giữa ngày lễ và cuối tuần
    num maxCoefficient = max(holidayCoefficient, weekendCoefficient);
    print('hệ số cho ngày lễ và cuối tuần ${maxCoefficient}');

    // Tổng số giờ tăng ca
    num otherCoefficent = 0;

    // Kiểm tra ngoài giờ
    num overTime = 1;
    num hours = 0;
    DateTime newStartTime = startTime;
    DateTime newEndTime = endTime;
    if (startTime.isBefore(eightAM) || endTime.isAfter(sixPM)) {
      overTime = otherCoefficientList
          .firstWhere((e) => e.title == 'Hệ số ngoài giờ')
          .value;

      // Kiểm tra nếu startTime trước 8h sáng
      if (startTime.isBefore(eightAM)) {
        // Thời gian chênh lệch buổi sáng
        Duration startDifference = eightAM.difference(startTime);
        hours += startDifference.inMinutes / 60.0;

        // Cập nhật startTime mới
        newStartTime = eightAM;
      }

      // Kiểm tra nếu endTime sau 6h tối
      if (endTime.isAfter(sixPM)) {
        Duration endDifference = endTime.difference(sixPM);
        num endHours = endDifference.inMinutes / 60.0;
        hours += endHours;

        // Cập nhật newEndTime mới
        newEndTime = sixPM;
      }
    }

    // Tính toán tổng chi phí tăng ca
    otherCoefficent =
        hours * overTime + (newEndTime.difference(newStartTime).inMinutes / 60);
    print('tổng số giờ tăng ca: ${hours}');
    print('hệ số tăng ca: ${overTime}');
    print('thời gian bắt đầu: ${newStartTime}');
    print('thời gian bắt đầu: ${newEndTime}');
    print(
        'tổng số giờ làm trong hành chính: ${(newEndTime.difference(newStartTime).inMinutes / 60)}');

    // Nhân overtime với hệ số lớn hơn giữa ngày lễ và cuối tuần
    otherCoefficent *= maxCoefficient;

    print('tông chi phí: ${totalCost * otherCoefficent}');
    num finalCost = totalCost * otherCoefficent;
    // Tính tổng chi phí
    // return totalCost * otherCoefficent;
    return {
      'basicPrice': basicPrice,
      'totalCost': totalCost,
      'basicCoefficient': basicCoefficient,
      'holidayCoefficient': holidayCoefficient,
      'weekendCoefficient': weekendCoefficient,
      'maxCoefficient': maxCoefficient,
      'overTimeCoefficient': overTime,
      'overTimeHours': hours,
      'finalCost': finalCost,
    };
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Quicksand',
          fontSize: 20,
          fontWeight: FontWeight.w800,
          color: Color(0xFF2E7D32),
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: const Color(0xFFE8F5E9),
          width: 1.5,
        ),
      ),
      child: child,
    );
  }

  // Widget _buildInfoRow(String label, String value) {
  //   final screenWidth = MediaQuery.of(context).size.width;

  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 8),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Expanded(

  //           child: Text(
  //             label,
  //             style: TextStyle(
  //               fontFamily: 'Quicksand',
  //               color: Colors.grey,
  //               fontSize: screenWidth > 600 ? 16 : 14,
  //             ),
  //           ),
  //         ),
  //         Expanded(
  //           child: Text(
  //             value,
  //             style: TextStyle(
  //               fontFamily: 'Quicksand',
  //               fontSize: screenWidth > 600 ? 16 : 14,
  //               fontWeight: FontWeight.w600,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  Widget _buildInfoRow(String label, String value) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 2, // Chia 2 phần
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'Quicksand',
                color: Colors.grey,
                fontSize: screenWidth > 600 ? 16 : 14,
              ),
            ),
          ),
          Flexible(
            flex: 1, // Chia 1 phần
            child: Text(
              value,
              textAlign: TextAlign.right, // Căn phải nếu cần
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: screenWidth > 600 ? 16 : 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    num totalCost = 0;
    num finalCost = 0;

    // List<String>? dateList = widget.request.startDate?.split(",");
    // for (var date in dateList!) {
    //   finalCost += totalCostCalculation(
    //       date, widget.request.startTime, widget.request.endTime);
    // }

    print(totalCost);
    print(widget.request.startDate);
    Map<String, dynamic> costData = totalCostCalculation(
        widget.request.oderDate,
        widget.request.startTime,
        widget.request.endTime);
    final basePrice = costData['basePrice'] ?? 0.0;
    final basicCoefficient = costData['basicCoefficient'] ?? 0.0;
    final overTimeHours = costData['overTimeHours'] ?? 0.0;
    final overTimeCoefficient = costData['overTimeCoefficient'] ?? 0.0;

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Xác nhận đơn hàng',
          style: TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _buildSectionTitle('Vị trí làm việc'),
            _buildCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFFE8F5E9),
                      child: Icon(Icons.location_on_rounded,
                          color: Color(0xFF2E7D32)),
                    ),
                    title: Text(
                      widget.customer.addresses[0].detailedAddress,
                      style: const TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle: Text(
                      widget.customer.addresses
                          .map((address) => address.toString())
                          .join(','),
                      style: const TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const Divider(
                    height: 24,
                    color: Colors.grey,
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFFE8F5E9),
                      child: Icon(Icons.person, color: Color(0xFF2E7D32)),
                    ),
                    title: Text(
                      widget.customer.name ?? 'Tên không có sẵn',
                      style: const TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle: Text(
                      widget.customer.phone ?? 'Số điện thoại không có sẵn',
                      style: const TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _buildSectionTitle('Thông tin công việc'),
            _buildCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Thời gian làm việc',
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow(
                      'Ngày làm việc', widget.request.startDate ?? 'N/A'),
                  _buildInfoRow(
                    'Làm trong',
                    // '${(DateTime.parse(widget.request.endTime).difference(DateTime.parse(widget.request.startTime))).inHours} giờ, ${(widget.request.startTime)} - ${widget.request.endTime}'
                    '${(DateTime.parse(widget.request.endTime).difference(DateTime.parse(widget.request.startTime))).inHours} giờ, ${DateTime.parse(widget.request.startTime).hour}:${DateTime.parse(widget.request.startTime).minute} - ${DateTime.parse(widget.request.endTime).hour}:${DateTime.parse(widget.request.endTime).minute}',
                  ),
                  const Divider(
                    height: 24,
                    color: Colors.grey,
                  ),
                  const Text(
                    'Chi tiết công việc',
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow('Khối lượng công việc',
                      widget.request.service.title ?? 'N/A'),
                ],
              ),
            ),
            _buildSectionTitle('Chi phí dịch vụ'),
            _buildCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // _buildInfoRow(
                  //   'Giá cơ bản',
                  //   '${widget.request.service.cost} VNĐ',
                  // ),
                  // _buildInfoRow(
                  //   'Hệ số dịch vụ cơ bản',
                  //   '${widget.costFactors.firstWhere((costFactor) => costFactor.title == 'Hệ số lương cho dịch vụ').coefficientList.firstWhere((coefficient) => coefficient.title == 'Dịch vụ dọn dẹp').value}',
                  // ),
                  _buildInfoRow(
                      'Số giờ làm', '${costData['overTimeHours']} giờ'),
                  _buildInfoRow('Giá cơ bản', '${widget.request.service.cost}'),
                  // _buildInfoRow(
                  //   'Hệ số ngoài giờ',
                  //   '${widget.costFactors.firstWhere((costFactor) => costFactor.title == 'Hệ số khác').coefficientList.firstWhere((coefficient) => coefficient.title == 'Hệ số ngoài giờ').value}',
                  // ),
                  _buildInfoRow(
                    'Số giờ làm ngoài giờ',
                    '${costData['overTimeHours']} giờ',
                  ),
                  // _buildInfoRow(
                  //   'Hệ số ngoài giờ',
                  //   '${widget.costFactors.firstWhere((costFactor) => costFactor.title == 'Hệ số khác').coefficientList.firstWhere((coefficient) => coefficient.title == 'Hệ số ngoài giờ').value}',
                  // ),
                  _buildInfoRow('Giá dịch vụ ngoài giờ',
                      '${widget.request.service.cost * costData['overTimeCoefficient']}'),
                  // _buildInfoRow('Dịch vụ thêm', '' ?? '0'),

                  // _buildInfoRow(
                  //   'Hệ số làm việc ngày cuối tuần',
                  //   '${widget.costFactors.firstWhere((costFactor) => costFactor.title == 'Hệ số khác').coefficientList.firstWhere((coefficient) => coefficient.title == 'Hệ số làm việc ngày cuối tuần').value}',
                  // ),
                  // _buildInfoRow(
                  //   'Hệ số lễ',
                  //   '${widget.costFactors.firstWhere((costFactor) => costFactor.title == 'Hệ số khác').coefficientList.firstWhere((coefficient) => coefficient.title == 'Hệ số lễ').value}',
                  // ),
                  // _buildInfoRow(
                  //   'Hệ số noel',
                  //   '${widget.costFactors.firstWhere((costFactor) => costFactor.title == 'Hệ số khác').coefficientList.firstWhere((coefficient) => coefficient.title == 'Hệ số noel').value}',
                  // ),
                  // _buildInfoRow(
                  //   'Hệ số Tết',
                  //   '${widget.costFactors.firstWhere((costFactor) => costFactor.title == 'Hệ số khác').coefficientList.firstWhere((coefficient) => coefficient.title == 'Hệ số tết').value}',
                  // ),
                  // _buildInfoRow(
                  //   'Tất cả hệ số',
                  //   '${widget.costFactors.firstWhere((costFactor) => costFactor.title == 'Hệ số khác').coefficientList.map((coefficient) => coefficient.title).join(', ')}',
                  // ),
                  const Divider(
                    height: 24,
                    color: Colors.grey,
                  ),
                  _buildInfoRow(
                    'Tổng chi phí',
                    // '${costData['finalCost']} VNĐ',
                    '${widget.request.service.cost * costData['overTimeCoefficient'] + widget.request.service.cost * costData['basicCoefficient']} VNĐ',
                  ),
                ],
              ),
            ),
            _buildSectionTitle('Phương thức thanh toán'),
            _buildCard(
              child: Column(
                children: [
                  RadioListTile(
                    value: true,
                    groupValue: isOnlinePayment,
                    onChanged: (value) {
                      setState(() {
                        isOnlinePayment = value!;
                      });
                    },
                    title: const Text(
                      'Chuyển khoản',
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    activeColor: const Color(0xFF2E7D32),
                  ),
                  RadioListTile(
                    value: false,
                    groupValue: isOnlinePayment,
                    onChanged: (value) {
                      setState(() {
                        isOnlinePayment = value!;
                      });
                    },
                    title: const Text(
                      'Thanh toán tiền mặt',
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 16,
                      ),
                    ),
                    activeColor: const Color(0xFF2E7D32),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            onPressed: () {
              if (isOnlinePayment) {
                // Điều hướng tới PaymentPage
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentPage(
                      amount: 500000,
                      customer: widget.customer,
                    ),
                  ),
                );
              } else {
                // Điều hướng tới OrderSuccess
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderSuccess(
                      customer: widget.customer,
                    ),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              isOnlinePayment ? "Tiến hành thanh toán" : "Đăng việc",
              style: const TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
