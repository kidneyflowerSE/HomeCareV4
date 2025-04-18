import 'package:flutter/material.dart';
import 'package:foodapp/data/model/CostFactor.dart';
import 'package:foodapp/data/model/customer.dart';
import 'package:foodapp/data/model/helper.dart';
import 'package:foodapp/data/model/service.dart';
import 'package:foodapp/pages/center_support_page.dart';
import 'package:foodapp/pages/feedback_complaint_page.dart';
import 'package:foodapp/pages/payment_detail_page.dart';
import 'package:foodapp/pages/payment_page.dart';
import 'package:foodapp/pages/rating_page.dart';
import 'package:foodapp/pages/services_order.dart';
import 'package:foodapp/pages/support_page.dart';
import 'package:intl/intl.dart';
import '../data/model/request.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../data/model/requestdetail.dart';
import '../data/repository/repository.dart';

class OrderDetailLongTermPage extends StatefulWidget {
  final Requests request;
  final List<RequestDetail> requestDetail;
  final List<Helper> helpers;
  final List<Services> services;
  final Customer customer;
  final List<CostFactor> costFactors;

  const OrderDetailLongTermPage({
    super.key,
    required this.requestDetail,
    required this.helpers,
    required this.services,
    required this.customer,
    required this.costFactors, required this.request,
  });

  @override
  State<OrderDetailLongTermPage> createState() =>
      _OrderDetailLongTermPageState();
}

class _OrderDetailLongTermPageState extends State<OrderDetailLongTermPage> {
  final List<Helper> requestHelpers = [];
  bool isLoading = true;
  double promotion = 5000;

  bool _allStatusDone() {
    return widget.requestDetail.isNotEmpty &&
        widget.requestDetail.every((detail) => detail.status == "done");
  }

  String formatCurrency(double amount) {
    final NumberFormat formatter = NumberFormat("#,###", "vi_VN");
    int roundedAmount = amount.round();
    return "${formatter.format(roundedAmount)} đ";
  }

  Color _getStatusBackgroundColor(String status) {
    switch (status) {
      case 'notDone':
        // return Color(0xFFE5FEDF); // Xanh nhạt
        return Colors.red;
      case 'assigned':
        return Color(0xFFFFF3CD); // Vàng nhạt
      case 'processing':
        return Color(0xFFD1ECF1); // Xanh dương nhạt
      case 'done':
        return Color(0xFFD4EDDA); // Xanh lá cây nhạt
      case 'cancelled':
        return Color(0xFFF8D7DA); // Đỏ nhạt
      default:
        return Colors.red;
    }
  }

  void _showConfirmationDialog(BuildContext context, Requests request) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Xác nhận",
          style: TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        content: Text(
          "Xác nhận người giúp việc đã hoàn thành việc và thanh toán ${formatCurrency(request.totalCost.toDouble())} cho người giúp việc?",
          style: TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 16,
          ),
        ),
        actions: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Không",
                style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextButton(
              onPressed: () {
                // Navigator.pop(context);
                // // _showPaymentDialog(context, request);
                // _doneRequest(request);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentPage(
                      amount: request.totalCost,
                      // Tổng chi phí
                      customer: widget.customer,
                      costFactors: widget.costFactors,
                      services: widget.services,
                      requestDetail: widget.requestDetail[0],
                    ),
                  ),
                );
              },
              child: Text(
                "Xác nhận",
                style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusTextColor(String status) {
    switch (status) {
      case 'notDone':
        // return Color(0xFF2FA559); // Xanh lá cây
        return Colors.red;
      case 'assigned':
        return Color(0xFF856404); // Vàng đậm
      case 'processing':
        return Color(0xFF0C5460);
      case 'waitPayment':
        return Colors.blue;// Xanh dương đậm
      case 'done':
        return Color(0xFF155724); // Xanh lá cây đậm
      case 'cancelled':
        return Color(0xFF721C24); // Đỏ đậm
      default:
        return Colors.white; // Mặc định màu đen
    }
  }

  String getStatusInVietnamese(String status) {
    switch (status) {
      case "notDone":
        return "Chưa tiến hành";
      case "assigned":
        return "Đã giao việc";
      case "done":
        return "Đã hoàn thành";
      case "processing":
        return "Đang tiến hành";
      case "waitPayment":
        return "Chờ thanh toán";
      case "cancelled":
        return "Đã huỷ";
      default:
        return "Không xác định";
    }
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('vi_VN', null);
    loadRequestDetailData(widget.request);
  }

  Future<void> loadRequestDetailData(Requests request) async {
    setState(() {
      isLoading = true;
    });

    if (request.scheduleIds.isNotEmpty) {
      setState(() {
        isLoading = false;
      });

      // Load helper information
      for (var data in widget.requestDetail) {
        try {
          var requestHelper =
              widget.helpers.firstWhere((helper) => helper.id == data.helperID);
          requestHelpers.add(requestHelper);
        } catch (e) {
          print('Helper not found for ID: ${data.helperID}');
        }
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  String _formatCurrency(double amount) {
    final NumberFormat formatter = NumberFormat("#,###", "vi_VN");
    double roundedAmount = amount.roundToDouble();
    return "${formatter.format(roundedAmount)} đ";
  }

  String _formatDate(String dateStr) {
    DateTime dateTime = DateTime.parse(dateStr).toLocal();
    return DateFormat("EEEE, dd 'Tháng' MM, yyyy - HH:mm", "vi_VN")
        .format(dateTime);
  }

  String _formatSimpleDate(String dateStr) {
    DateTime dateTime = DateTime.parse(dateStr).toLocal();
    return DateFormat("dd/MM/yyyy", "vi_VN").format(dateTime);
  }

  String _formatTime(String isoTime) {
    try {
      DateTime dateTime =
          DateTime.parse(isoTime).toLocal(); // Chuyển về giờ địa phương
      return DateFormat('HH:mm').format(dateTime); // Định dạng thành HH:mm
    } catch (e) {
      return "N/A"; // Xử lý lỗi
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Chi tiết đơn hàng',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            fontFamily: 'Quicksand',
          ),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.green))
          : SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildOrderStatusCard(),
                      const SizedBox(height: 16),
                      _buildScheduleCardsSection(),
                    ],
                  ),
                ),
              ),
            ),
      bottomNavigationBar: _allStatusDone()
          ? BottomAppBar(
              color: Colors.white,
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: ElevatedButton(
                  onPressed: () {
                    _showConfirmationDialog(context, widget.request);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Thanh toán',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          : null, // Không hiển thị nếu chưa hoàn thành
    );
  }

  Widget _buildOrderStatusCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Mã đơn hàng: ',
                style: TextStyle(
                  color: Colors.black87,
                  fontFamily: 'Quicksand',
                  fontSize: 15,
                ),
              ),
              Text(
                '#${widget.request.id.substring(0, 8)}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Quicksand',
                ),
              )
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                'Đặt lúc: ',
                style: const TextStyle(
                  color: Colors.black87,
                  fontFamily: 'Quicksand',
                  fontSize: 14,
                ),
              ),
              Text(
                _formatDate(widget.request.oderDate),
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Quicksand',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleCardsSection() {
    if (widget.requestDetail.isEmpty) {
      return Center(
        child: Text(
          'Không có lịch làm việc nào',
          style: TextStyle(
            color: Colors.grey.shade700,
            fontFamily: 'Quicksand',
            fontSize: 16,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Lịch làm việc',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            fontFamily: 'Quicksand',
          ),
        ),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.requestDetail.length,
          itemBuilder: (context, index) {
            return _buildScheduleCard(widget.requestDetail[index]);
          },
        ),
      ],
    );
  }

  Widget _buildScheduleCard(RequestDetail detail) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Trạng thái: ${getStatusInVietnamese(detail.status)}',
            style: TextStyle(
              color: _getStatusTextColor(detail.status),
              fontFamily: 'Quicksand',
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          Divider(
            height: 24,
            color: Colors.grey.shade200,
          ),
          Text(
            'Đơn hàng: #${detail.id}',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'Quicksand',
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 18, color: Colors.green),
              const SizedBox(width: 8),
              Text(
                'Ngày làm việc: ${_formatSimpleDate(detail.workingDate)}',
                style: const TextStyle(
                  color: Colors.black87,
                  fontFamily: 'Quicksand',
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.access_time, size: 18, color: Colors.green),
              const SizedBox(width: 8),
              Text(
                'Thời gian: ${_formatTime(widget.request.startTime)} - ${_formatTime(widget.request.endTime)}',
                style: const TextStyle(
                  color: Colors.black87,
                  fontFamily: 'Quicksand',
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (detail.status == 'waitPayment')
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentPage(
                          amount: detail.cost ?? 0,
                          // Tổng chi phí
                          customer: widget.customer,
                          costFactors: widget.costFactors,
                          services: widget.services,
                          requestDetail: detail,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: const Size(160, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Thanh toán',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Quicksand',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(160, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Xem chi tiết',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Quicksand',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              // Kiểm tra điều kiện 'waitPayment' và hiển thị button "Thanh toán"
            ],
          ),
        ],
      ),
    );
  }
}
