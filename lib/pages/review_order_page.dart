import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/data/model/helper.dart';
import 'package:foodapp/data/repository/repository.dart';
import 'package:foodapp/pages/order_success_page.dart';
import 'package:foodapp/pages/payment_page.dart';
import '../data/model/customer.dart';
import '../data/model/request.dart';

class ReviewOrderPage extends StatefulWidget {
  final Customer customer;
  final Helper helper;
  final Requests request;

  const ReviewOrderPage({
    super.key,
    required this.customer,
    required this.helper,
    required this.request,
  });

  @override
  _ReviewOrderPageState createState() => _ReviewOrderPageState();
}

class _ReviewOrderPageState extends State<ReviewOrderPage> {
  bool isOnlinePayment = true; // Trạng thái để lưu phương thức thanh toán

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
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
                  const Divider(height: 24),
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
                      widget.customer.phone ?? 'Sđt không có sẵn',
                      style: const TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    trailing: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF2E7D32),
                        side: const BorderSide(color: Color(0xFF2E7D32)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text('Thay đổi'),
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
                      'Ngày làm việc', 'Thứ năm, ngày 26/09/2024 - 14:00'),
                  _buildInfoRow('Làm trong', '3 giờ, 14:00 - 17:00'),
                  const Divider(height: 24),
                  const Text(
                    'Chi tiết công việc',
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow('Khối lượng công việc', '85m² / 3 phòng'),
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
        // decoration: BoxDecoration(
        //   color: Colors.white,
        //   boxShadow: [
        //     BoxShadow(
        //       color: Colors.grey.withOpacity(0.1),
        //       spreadRadius: 1,
        //       blurRadius: 10,
        //       offset: const Offset(0, -2),
        //     ),
        //   ],
        // ),
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
                    builder: (context) => const PaymentPage(
                      amount: 50.0000,
                    ),
                  ),
                );
              } else {
                // Điều hướng tới OrderSuccess
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrderSuccess(),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E7D32),
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
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Quicksand',
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
