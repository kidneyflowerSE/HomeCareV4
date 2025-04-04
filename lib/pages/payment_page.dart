import 'package:flutter/material.dart';
import 'package:foodapp/data/model/CostFactor.dart';
import 'package:foodapp/data/model/request.dart';
import 'package:foodapp/data/model/requestdetail.dart';
import 'package:foodapp/pages/order_success_page.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import '../data/model/customer.dart';
import '../data/model/service.dart';
import '../data/repository/repository.dart';

class PaymentPage extends StatefulWidget {
  final num amount;
  final Customer customer;
  final List<CostFactor> costFactors;
  final List<Services> services;
  final RequestDetail requestDetail;

  const PaymentPage({
    super.key,
    required this.amount,
    required this.customer,
    required this.costFactors,
    required this.services,
    required this.requestDetail,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String selectedPaymentMethod = "bank";
  bool isProcessing = false;

  void _doneRequest(RequestDetail request) {
    var repository = DefaultRepository();
    repository.doneConfirmRequest(request.id);
    print(request.id);
    setState(() {
      request.status = "done";
    });
  }

  String formatCurrency(num amount) {
    final NumberFormat formatter = NumberFormat("#,###", "vi_VN");
    int roundedAmount = amount.round();
    return "${formatter.format(roundedAmount)} đ";
  }

  final List<Map<String, dynamic>> paymentMethods = [
    {
      'id': 'bank',
      'title': 'Vietcombank',
      'logo': 'lib/images/payment/vietcombank.jpg',
      'subtitle': 'Thanh toán qua Vietcombank',
    },
    {
      'id': 'momo',
      'title': 'Momo',
      'logo': 'lib/images/payment/momo.jpg',
      'subtitle': 'Thanh toán bằng Momo',
    },
    {
      'id': 'vnpay',
      'title': 'VNPay',
      'logo': 'lib/images/payment/vnpay.jpg',
      'subtitle': 'Thanh toán qua VNPay',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.green,
        title: const Text(
          "Thanh toán Online",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildAmountCard(widget.amount),
              const SizedBox(height: 24),
              _buildPaymentMethodSection(),
              const SizedBox(height: 24),
              _buildPaymentDetails(),
              const SizedBox(height: 80),
            ],
          ),
          _buildBottomPaymentButton(),
        ],
      ),
    );
  }

  Widget _buildAmountCard(num amount) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "Tổng tiền",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontFamily: 'Quicksand',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "${formatCurrency(amount)}",
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.green,
                fontFamily: 'Quicksand',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Chọn phương thức thanh toán",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            fontFamily: 'Quicksand',
          ),
        ),
        const SizedBox(height: 16),
        ...paymentMethods.map((method) => _buildPaymentMethodCard(method)),
      ],
    );
  }

  Widget _buildPaymentMethodCard(Map<String, dynamic> method) {
    final bool isSelected = selectedPaymentMethod == method['id'];

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? Colors.green : Colors.grey.shade300,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => setState(() => selectedPaymentMethod = method['id']),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.green.withOpacity(0.1)
                      : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    method['logo'],
                    width: 34,
                    height: 34,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      method['title'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight:
                        isSelected ? FontWeight.w700 : FontWeight.w500,
                        fontFamily: 'Quicksand',
                      ),
                    ),
                    Text(
                      method['subtitle'],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                        fontFamily: 'Quicksand',
                      ),
                    ),
                  ],
                ),
              ),
              Radio(
                value: method['id'],
                groupValue: selectedPaymentMethod,
                onChanged: (value) =>
                    setState(() => selectedPaymentMethod = value.toString()),
                activeColor: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentDetails() {
    if (selectedPaymentMethod == 'bank') {
      return _buildBankDetails();
    } else {
      return _buildQRCodeDetails();
    }
  }

  Widget _buildBankDetails() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "THÔNG TIN CHUYỂN KHOẢN",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                fontFamily: 'Quicksand',
              ),
            ),
            const SizedBox(height: 16),
            _buildDetailRow("Tài khoản nhận", "PHAM NGUYEN QUOC HUY"),
            _buildDetailRow("Số tài khoản", "1022681467"),
            _buildDetailRow("Ngân hàng", "Vietcombank"),
            _buildDetailRow("Chi nhánh", "PGD Son Tinh"),
          ],
        ),
      ),
    );
  }

  Widget _buildQRCodeDetails() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "${selectedPaymentMethod.toUpperCase()} QR Code",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                fontFamily: 'Quicksand',
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset(
                "lib/images/${selectedPaymentMethod}.png",
                height: 200,
                width: 200,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Scan QR code to pay with ${selectedPaymentMethod.toUpperCase()}",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
                fontFamily: 'Quicksand',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              fontFamily: 'Quicksand',
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'Quicksand',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomPaymentButton() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: ElevatedButton(
            onPressed: isProcessing ? null : _processPayment,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: isProcessing
                ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
                : Text(
              "Thanh toán ${formatCurrency(widget.amount)}",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontFamily: 'Quicksand',
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _processPayment() async {
    setState(() => isProcessing = true);

    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() => isProcessing = false);

      _doneRequest(widget.requestDetail);

      Navigator.pushReplacement(
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
  }
}