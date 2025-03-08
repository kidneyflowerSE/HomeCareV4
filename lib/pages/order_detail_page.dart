import 'package:flutter/material.dart';
import 'package:foodapp/data/model/helper.dart';
import 'package:intl/intl.dart';
import '../data/model/request.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../data/model/requestdetail.dart';
import '../data/repository/repository.dart';

class OrderDetailPage extends StatefulWidget {
  final Requests request;
  final List<Helper> helpers;

  const OrderDetailPage({
    super.key,
    required this.request,
    required this.helpers,
  });

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  late List<RequestDetail>? requestDetailData = [];

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('vi_VN', null);
    loadRequestDetailData(widget.request);
  }

  Future<void> loadRequestDetailData(Requests request) async {
    var repository = DefaultRepository();
    if (request.scheduleIds.isNotEmpty) {
      var data = await repository.loadRequestDetailId(request.scheduleIds);
      setState(() {
        requestDetailData = data ?? [];
      });
    }
  }

  String _formatCurrency(double amount) {
    final NumberFormat formatter = NumberFormat("#,###", "vi_VN");
    double roundedAmount = (amount / 1000).ceil() * 1000;
    return "${formatter.format(roundedAmount)} đ";
  }

  double promotion = 5000;

  String _formatDate(String dateStr) {
    DateTime dateTime = DateTime.parse(dateStr).toLocal();
    return DateFormat("EEEE, dd 'Tháng' MM, yyyy - HH:mm", "vi_VN")
        .format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    print(requestDetailData);
    // Helper helperInfo = widget.helpers.where((helper) => helper.helperId == requestDetailData)
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildStatusCard(),
                const SizedBox(height: 24),
                _buildCustomerInfo(),
                const SizedBox(height: 24),
                _buildServiceDetails(),
                const SizedBox(height: 24),
                _buildPaymentSummary(),
                const SizedBox(height: 24),
                _buildSupportSection(),
                const SizedBox(height: 100), // Bottom padding for content
              ]),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomActions(),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      expandedHeight: 60,
      pinned: true,
      stretch: true,
      backgroundColor: Colors.green,
      foregroundColor: Colors.green,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        title: const Text(
          'Chi tiết đơn hàng',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w800,
            fontFamily: 'Quicksand',
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            color: Colors.green,
          ),
        ),
      ),
    );
  }

  Widget _buildStatusCard() {
    return Container(
      padding: const EdgeInsets.all(20),
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
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_circle, color: Colors.green),
              ),
              const SizedBox(width: 16),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Đã xác nhận',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Quicksand',
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Đơn hàng đang được xử lý',
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Quicksand',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerInfo() {
    return Container(
      padding: const EdgeInsets.all(20),
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
            'Thông tin khách hàng',
            // ${widget.request.helperId},
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Quicksand',
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person_2_outlined,
                  color: Colors.green,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.request.customerInfo.fullName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Quicksand',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.request.customerInfo.phone,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Quicksand',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHelperInfo() {
    return Container(
      padding: const EdgeInsets.all(20),
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
          const Text(
            'Thông tin người giúp việc',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Quicksand',
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person_2_outlined,
                  color: Colors.green,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.request.customerInfo.fullName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Quicksand',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.request.customerInfo.phone,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Quicksand',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceDetails() {
    return Container(
      padding: const EdgeInsets.all(20),
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
          const Text(
            'Chi tiết dịch vụ',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Quicksand',
            ),
          ),
          const SizedBox(height: 16),
          _buildServiceItem(
            icon: Icons.cleaning_services_rounded,
            title: widget.request.service.title,
            subtitle: 'Dọn dẹp nhà cửa, lau nhà, rửa chén',
          ),
          const SizedBox(height: 16),
          _buildServiceItem(
            icon: Icons.location_on_rounded,
            title: widget.request.customerInfo.address,
            subtitle: 'Phường Đa Kao, Quận 1, TP.Hồ Chí Minh',
          ),
          const SizedBox(height: 16),
          _buildServiceItem(
            icon: Icons.calendar_today_rounded,
            title: _formatDate(widget.request.oderDate),
            subtitle: 'Thời gian đặt lịch',
          ),
        ],
      ),
    );
  }

  Widget _buildServiceItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.green, size: 22),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Quicksand',
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                  fontFamily: 'Quicksand',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentSummary() {
    return Container(
      padding: const EdgeInsets.all(20),
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
          const Text(
            'Thanh toán',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Quicksand',
            ),
          ),
          const SizedBox(height: 16),
          _buildPaymentRow(
            'Chi phí dịch vụ',
            _formatCurrency(
              widget.request.totalCost.toDouble(),
            ),
          ),
          const SizedBox(height: 8),
          _buildPaymentRow('Khuyến mãi', _formatCurrency(promotion)),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(
              color: Colors.grey.shade200,
            ),
          ),
          _buildPaymentRow(
            'Tổng thanh toán',
            _formatCurrency(widget.request.totalCost.toDouble() - promotion),
            isTotal: true,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(
              color: Colors.grey.shade200,
            ),
          ),
          _buildPaymentRow(
            'Hình thức thanh toán',
            'Ngân hàng VCB',
            isPaymentMethod: true,
          )
        ],
      ),
    );
  }

  Widget _buildPaymentRow(String label, String value,
      {bool isTotal = false, bool isPaymentMethod = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal || isPaymentMethod ? 16 : 14,
            fontWeight: isTotal || isPaymentMethod
                ? FontWeight.bold
                : FontWeight.normal,
            color: isTotal || isPaymentMethod ? Colors.black : Colors.grey[600],
            fontFamily: 'Quicksand',
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal || isPaymentMethod ? 16 : 14,
            fontWeight: isTotal || isPaymentMethod
                ? FontWeight.bold
                : FontWeight.normal,
            color: isTotal || isPaymentMethod ? Colors.green : Colors.grey[600],
            fontFamily: 'Quicksand',
          ),
        ),
      ],
    );
  }

  Widget _buildSupportSection() {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.support_agent,
                color: Colors.green,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Bạn cần hỗ trợ ?',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Quicksand',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Expanded(
          //   child: ElevatedButton(
          //     onPressed: () {},
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: Colors.grey[100],
          //       foregroundColor: Colors.black87,
          //       padding: const EdgeInsets.symmetric(vertical: 16),
          //       elevation: 0,
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(12),
          //       ),
          //     ),
          //     child: const Text(
          //       'Đặt dài hạn',
          //       style: TextStyle(
          //         fontWeight: FontWeight.w600,
          //         fontFamily: 'Quicksand',
          //       ),
          //     ),
          //   ),
          // ),
          // const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Đặt lại',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontFamily: 'Quicksand',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
