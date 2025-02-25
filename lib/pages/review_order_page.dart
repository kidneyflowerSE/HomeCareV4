import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/data/model/CostFactor.dart';
import 'package:foodapp/data/model/helper.dart';
import 'package:foodapp/pages/order_success_page.dart';
import 'package:foodapp/pages/payment_page.dart';
import 'package:intl/intl.dart';
import '../data/model/customer.dart';
import '../data/model/request.dart';
import '../data/model/service.dart';
import '../data/repository/repository.dart';

class ReviewOrderPage extends StatefulWidget {
  final Customer customer;
  final Helper helper;
  final Requests request;
  final List<CostFactor> costFactors;
  final List<Services> services;

  const ReviewOrderPage({
    super.key,
    required this.customer,
    required this.helper,
    required this.request,
    required this.costFactors,
    required this.services,
  });

  @override
  _ReviewOrderPageState createState() => _ReviewOrderPageState();
}

class _ReviewOrderPageState extends State<ReviewOrderPage> {
  bool isOnlinePayment = true;
  String _formatTime(double time) {
    double roundedTime = double.parse(
        time.toStringAsFixed(2)); // Làm tròn đến 2 chữ số thập phân
    num hours = roundedTime.floor(); // Lấy phần nguyên (giờ)
    num minutes = ((roundedTime - hours) * 60)
        .round(); // Chuyển phần lẻ thành phút và làm tròn

    if (minutes == 0) {
      return '$hours giờ';
    } else {
      return '$hours giờ $minutes phút';
    }
  }

  String _formatCurrency(double amount) {
    final NumberFormat formatter = NumberFormat("#,###", "vi_VN");
    num roundedAmount = amount.round(); // Làm tròn số
    return "${formatter.format(roundedAmount)} đ";
  }

  void showCostDetailsPopup(
      BuildContext context, Map<String, dynamic> costData, String date) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tiêu đề popup
                  Center(
                    child: Text(
                      "Chi tiết dịch vụ ngày $date",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontFamily: 'Quicksand',
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Hiển thị nội dung tính toán chi phí trong card
                  _buildCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoRow(
                          'Số giờ làm',
                          _formatTime((costData['workingTime'] ?? 0).toDouble()),
                        ),
                        _buildInfoRow(
                          'Giá cơ bản',
                          _formatCurrency((costData['basicPrice'] ?? 0).toDouble() *
                              (costData['basicCoefficient'] ?? 1).toDouble()),
                        ),
                        _buildInfoRow(
                          'Số giờ làm ngoài giờ',
                          _formatTime((costData['overTimeHours'] ?? 0).toDouble()),
                        ),
                        _buildInfoRow(
                          'Giá dịch vụ ngoài giờ',
                          _formatCurrency((costData['overTimeCost'] ?? 0).toDouble()),
                        ),
                        Divider(height: 24, color: Colors.grey.shade200),
                        _buildInfoRow(
                          'Tổng chi phí',
                          _formatCurrency((costData['finalCost'] ?? 0).toDouble()),
                        ),
                      ],
                    ),
                  ),

                  // Nút đóng popup
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(); // Đóng popup
                      },
                      child: Text(
                        "Đóng",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Quicksand',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Map<String, dynamic> totalCostCalculation(
      String date, String start, String end)
  {
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

    // Gíá của dịch vụ
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
    num workingTime = (newEndTime.difference(newStartTime).inMinutes / 60);
    otherCoefficent = hours * overTime + workingTime;
    print('tổng số giờ tăng ca: ${hours}');
    print('hệ số tăng ca: ${overTime}');
    print('thời gian bắt đầu: ${newStartTime}');
    print('thời gian bắt đầu: ${newEndTime}');
    print(
        'tổng số giờ làm trong hành chính: ${(newEndTime.difference(newStartTime).inMinutes / 60)}');

    print('thời gian bắt đầu: ${otherCoefficent}');

    // Nhân overtime với hệ số lớn hơn giữa ngày lễ và cuối tuần
    otherCoefficent *= maxCoefficient;

    print('tông chi phí: ${totalCost * otherCoefficent}');
    num finalCost = totalCost * otherCoefficent;
    // Tính tổng chi phí

    widget.request.totalCost = finalCost;

    return {
      'workingTime': workingTime + hours,
      'basicPrice': basicPrice,
      'totalCost': totalCost,
      'basicCoefficient': basicCoefficient,
      'holidayCoefficient': holidayCoefficient,
      'weekendCoefficient': weekendCoefficient,
      'maxCoefficient': maxCoefficient,
      'overTimeCoefficient': overTime,
      'overTimeHours': hours,
      'finalCost': finalCost.round(),
      'overTimeCost': overTime * maxCoefficient * basicPrice
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
          color: const Color.fromARGB(255, 239, 246, 240),
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
  Widget _buildInfoRow(String label, String value,
      {String? buttonText, VoidCallback? onPressed})
  {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: (buttonText == null) ? 2 : 1,
            // Nếu có button thì chia 3 phần, nếu không thì chia 2
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'Quicksand',
                color: Colors.grey,
                fontSize: screenWidth > 600 ? 16 : 14,
              ),
            ),
          ),
          if (buttonText != null &&
              onPressed != null) // Chỉ hiển thị nếu có nút bấm
            Flexible(
              flex: 1,
              child: TextButton(
                onPressed: onPressed,
                child: Text(
                  buttonText,
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: screenWidth > 600 ? 16 : 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.red,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.red,
                  ),
                ),
              ),
            ),
          Flexible(
            flex: 1,
            child: Text(
              value,
              textAlign: TextAlign.right,
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
    num workingTime = 0;
    List<Map<String, dynamic>> singleDayCostData = [];
    bool isOnDemand = true;
    late Map<String, dynamic> costData;

    List<String>? dateList = widget.request.startDate?.split(",");
    if (dateList!.length > 1) isOnDemand = false;
    for (var date in dateList) {
      costData = totalCostCalculation(
          date, widget.request.startTime, widget.request.endTime);
      singleDayCostData.add(costData);
      finalCost += costData["finalCost"];
      workingTime += costData["workingTime"];
    }

    String? _formatDate(String? dateString) {
      if (dateString == null || dateString.isEmpty) return null;

      List<String> dates = dateString.split(",");
      List<String> formattedDates = dates.map((date) {
        try {
          DateTime parsedDate = DateTime.parse(date);
          return DateFormat('dd/MM').format(parsedDate);
        } catch (e) {
          return date; // Trả lại nguyên gốc nếu lỗi
        }
      }).toList();

      return formattedDates.join(", ");
    }

    String _formatTime(double workingTime) {
      double roundedTime = double.parse(workingTime.toStringAsFixed(2));
      num hours = roundedTime.floor();
      num minutes = ((roundedTime - hours) * 60).round();

      if (minutes == 0) {
        return '$hours giờ';
      } else {
        return '$hours giờ $minutes phút';
      }
    }

    print(totalCost);
    print(widget.request.startDate);

    // final basePrice = costData['basePrice'] ?? 0.0;
    // final basicCoefficient = costData['basicCoefficient'] ?? 0.0;
    // final overTimeHours = costData['overTimeHours'] ?? 0.0;
    // final overTimeCoefficient = costData['overTimeCoefficient'] ?? 0.0;

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
            // _buildSectionTitle('Vị trí làm việc'),
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
                      '${widget.customer.addresses[0].district}, ${widget.customer.addresses[0].province}',
                      style: const TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Divider(
                    height: 24,
                    color: Colors.grey.shade200,
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFFE8F5E9),
                      child: Icon(Icons.person, color: Color(0xFF2E7D32)),
                    ),
                    title: Text(
                      widget.customer.name,
                      style: const TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle: Text(
                      widget.customer.phone,
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
            // _buildSectionTitle('Thông tin công việc'),

            _buildCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                  _buildInfoRow('Ngày làm việc',
                      _formatDate(widget.request.startDate) ?? 'N/A'),
                  _buildInfoRow(
                    'Làm trong',
                    // '${(DateTime.parse(widget.request.endTime).difference(DateTime.parse(widget.request.startTime))).inHours} giờ, ${(widget.request.startTime)} - ${widget.request.endTime}'
                    // '${(DateTime.parse(widget.request.endTime).difference(DateTime.parse(widget.request.startTime))).inHours} giờ, ${DateTime.parse(widget.request.startTime).hour}:${DateTime.parse(widget.request.startTime).minute} - ${DateTime.parse(widget.request.endTime).hour}:${DateTime.parse(widget.request.endTime).minute}',
                    _formatTime(workingTime.toDouble()),
                  ),
                  Divider(
                    height: 24,
                    color: Colors.grey.shade200,
                  ),
                  const Text(
                    'Chi tiết dịch vụ',
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow(
                      'Loại dịch vụ', widget.request.service.title ?? 'N/A'),
                ],
              ),
            ),
            // _buildSectionTitle('Chi phí dịch vụ'),

            isOnDemand
                ? _buildCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Chi phí dịch vụ',
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        // _buildInfoRow(
                        //   'Giá cơ bản',
                        //   '${widget.request.service.cost} VNĐ',
                        // ),
                        // _buildInfoRow(
                        //   'Hệ số dịch vụ cơ bản',
                        //   '${widget.costFactors.firstWhere((costFactor) => costFactor.title == 'Hệ số lương cho dịch vụ').coefficientList.firstWhere((coefficient) => coefficient.title == 'Dịch vụ dọn dẹp').value}',
                        // ),
                        _buildInfoRow(
                          'Số giờ làm',
                          _formatTime(costData['workingTime'].toDouble()),
                        ),
                        _buildInfoRow('Giá cơ bản',
                            '${costData['basicPrice'] * costData['basicCoefficient']}'),
                        // _buildInfoRow(
                        //   'Hệ số ngoài giờ',
                        //   '${widget.costFactors.firstWhere((costFactor) => costFactor.title == 'Hệ số khác').coefficientList.firstWhere((coefficient) => coefficient.title == 'Hệ số ngoài giờ').value}',
                        // ),
                        _buildInfoRow(
                          'Số giờ làm ngoài giờ',
                          // '${costData['overTimeHours']} giờ',
                          _formatTime(costData['overTimeHours'].toDouble()),
                        ),
                        // _buildInfoRow(
                        //   'Hệ số ngoài giờ',
                        //   '${widget.costFactors.firstWhere((costFactor) => costFactor.title == 'Hệ số khác').coefficientList.firstWhere((coefficient) => coefficient.title == 'Hệ số ngoài giờ').value}',
                        // ),
                        _buildInfoRow(
                          'Giá dịch vụ ngoài giờ',
                          // '${costData['overTimeCost']}'),
                          _formatCurrency(costData['overTimeCost'].toDouble()),
                        ),
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
                        Divider(
                          height: 24,
                          color: Colors.grey.shade200,
                        ),
                        _buildInfoRow(
                          'Tổng chi phí dịch vụ',
                          // '${costData['finalCost']} VNĐ',
                          // '$finalCost đ',
                          _formatCurrency(finalCost.toDouble()),
                        ),
                      ],
                    ),
                  )
                : _buildCard(
                    child: Column(
                      children: [
                        Text(
                          'Chi phí dịch vụ',
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: dateList.length + 2,
                          itemBuilder: (context, index) {
                            if (index == dateList.length) {
                              return Divider(
                                height: 24,
                                color: Colors.grey.shade200,
                              );
                            } else if (index == dateList.length + 1) {
                              return _buildInfoRow('Tổng chi phí dịch vụ',
                                  _formatCurrency(finalCost.toDouble()));
                            } else if (index < singleDayCostData.length) {
                              var singleDayCost =
                                  singleDayCostData[index]['finalCost'];
                              return _buildInfoRow(
                                'Chi phí ngày ${widget.request.startDate?.split(',')[index]}',
                                // '$singleDayCost đ',
                                buttonText: 'Xem chi tiết',
                                onPressed: () {
                                  showCostDetailsPopup(
                                      context, singleDayCostData[index],widget.request.startDate!.split(',')[index]);
                                },
                                _formatCurrency(double.parse('$singleDayCost')),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
            // _buildSectionTitle('Phương thức thanh toán'),
            _buildCard(
              child: Column(
                children: [
                  Text('Phương thức thanh toán',
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      )),
                  const SizedBox(height: 12),
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
                        fontWeight: FontWeight.w400,
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
                        fontWeight: FontWeight.w400,
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
              widget.request.totalCost = finalCost;
              if (isOnlinePayment) {
                // Điều hướng tới PaymentPage
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentPage(
                      amount: widget.request.service.cost.toDouble() *
                              costData['overTimeCoefficient'].toDouble() +
                          widget.request.service.cost.toDouble() *
                              costData['basicCoefficient'].toDouble(),
                      // Tổng chi phí
                      customer: widget.customer,
                      costFactors: widget.costFactors,
                      services: widget.services,
                      request: widget.request,
                    ),
                  ),
                );
              } else {
                var repository = DefaultRepository();
                repository.sendRequest(widget.request);
                // Điều hướng tới OrderSuccess
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderSuccess(
                      customer: widget.customer,
                      costFactors: widget.costFactors,
                      services: widget.services,
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
