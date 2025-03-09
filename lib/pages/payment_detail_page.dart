import 'package:flutter/material.dart';
import 'package:foodapp/pages/feedback_complaint_page.dart';

class PaymentDetailPage extends StatefulWidget {
  final Map<String, dynamic>? paymentData;

  const PaymentDetailPage({
    super.key,
    this.paymentData,
  });

  @override
  State<PaymentDetailPage> createState() => _PaymentDetailPageState();
}

class _PaymentDetailPageState extends State<PaymentDetailPage> {
  bool _isLoading = true;
  late Map<String, dynamic> _paymentDetails;

  @override
  void initState() {
    super.initState();
    _loadPaymentData();
  }

  Future<void> _loadPaymentData() async {
    // If payment data was passed, use it
    if (widget.paymentData != null) {
      setState(() {
        _paymentDetails = widget.paymentData!;
        _isLoading = false;
      });
      return;
    }

    // Otherwise simulate fetching from API
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _paymentDetails = {
        'id':
            'PAY-${DateTime.now().millisecondsSinceEpoch.toString().substring(5, 13)}',
        'date': DateTime.now(),
        'status': 'Thất bại',
        'method': 'Thẻ tín dụng',
        'cardInfo': '**** **** **** 2839',
        'items': [
          {
            'name': 'Dọn dẹp nhà cửa',
            'hours': 3,
            'price': 200000,
          },
          {
            'name': 'Phí dịch vụ',
            'hours': null,
            'price': 50000,
          }
        ],
        'helper': {
          'name': 'Phạm Nguyễn Quốc Huy',
          'rating': 5,
          'avatar': 'lib/images/staff/anhhuy.jpg',
        }
      };
      _isLoading = false;
    });
  }

  Future<void> _downloadInvoice() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Đang tải xuống hóa đơn...'),
        duration: Duration(seconds: 2),
      ),
    );

    // Simulate download delay
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              const SizedBox(width: 12),
              const Text('Đã tải xuống hóa đơn thành công'),
            ],
          ),
          backgroundColor: Colors.green.shade600,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _reportIssue() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'Báo cáo vấn đề',
          style: TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          'Bạn có chắc chắn muốn báo cáo vấn đề với giao dịch này không?',
          style: TextStyle(
            fontFamily: 'Quicksand',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'Hủy',
              style: TextStyle(
                fontFamily: 'Quicksand',
                color: Colors.grey.shade700,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade500,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Báo cáo',
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );

    if (result == true && mounted) {
      // Navigate to support page or show form
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => FeedbackComplaintsPage(),
        ),
      );
    }
  }

  String _formatCurrency(int amount) {
    return '$amount đ';
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          'Chi tiết thanh toán',
          style: TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              // Show help info
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (context) => _buildHelpSheet(),
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.green.shade600,
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStatusCard(),
                  const SizedBox(height: 16),
                  _buildPaymentDetailsCard(),
                  const SizedBox(height: 16),
                  _buildItemsCard(),
                  const SizedBox(height: 16),
                  _buildHelperCard(),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _downloadInvoice,
                          icon: const Icon(
                            Icons.download,
                            color: Colors.green,
                          ),
                          label: const Text('Tải hóa đơn'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.green.shade700,
                            side: BorderSide(color: Colors.green.shade300),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _reportIssue,
                          icon: const Icon(
                            Icons.report_problem_outlined,
                            color: Colors.red,
                          ),
                          label: const Text('Báo cáo vấn đề'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red.shade700,
                            side: BorderSide(color: Colors.red.shade300),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildStatusCard() {
    Color statusColor;
    IconData statusIcon;

    // Set color and icon based on status
    switch (_paymentDetails['status']) {
      case 'Đã thanh toán':
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        break;
      case 'Đang xử lý':
        statusColor = Colors.orange;
        statusIcon = Icons.pending;
        break;
      case 'Thất bại':
        statusColor = Colors.red;
        statusIcon = Icons.error;
        break;
      default:
        statusColor = Colors.grey;
        statusIcon = Icons.help;
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                statusIcon,
                color: statusColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _paymentDetails['status'],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                      fontFamily: 'Quicksand',
                    ),
                  ),
                  Text(
                    'Mã giao dịch: ${_paymentDetails['id']}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      fontFamily: 'Quicksand',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentDetailsCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Thông tin thanh toán',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Quicksand',
              ),
            ),
            const SizedBox(height: 16),
            _buildDetailRow('Phương thức', _paymentDetails['method']),
            if (_paymentDetails['cardInfo'] != null)
              _buildDetailRow('Thông tin thẻ', _paymentDetails['cardInfo']),
            _buildDetailRow(
                'Ngày giao dịch', _formatDate(_paymentDetails['date'])),
            _buildDetailRow('Trạng thái', _paymentDetails['status']),
          ],
        ),
      ),
    );
  }

  Widget _buildItemsCard() {
    final items = _paymentDetails['items'] as List;
    int subtotal = 0;

    // Calculate subtotal
    for (var item in items) {
      subtotal += item['price'] as int;
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
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
            ...items.map((item) => _buildItemRow(item)),
            Divider(height: 24, color: Colors.grey.shade300),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Tổng cộng',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: 'Quicksand',
                  ),
                ),
                Text(
                  _formatCurrency(subtotal),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: 'Quicksand',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHelperCard() {
    final helper = _paymentDetails['helper'];

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
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
                CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.grey.shade200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.asset(helper['avatar']),
                    )),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        helper['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: 'Quicksand',
                        ),
                      ),
                      Row(
                        children: [
                          // const SizedBox(width: 4),
                          Text(
                            helper['rating'].toString(),
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontFamily: 'Quicksand',
                            ),
                          ),
                          Icon(
                            Icons.star,
                            size: 16,
                            color: Colors.amber.shade600,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.green.shade700,
                    side: BorderSide(color: Colors.green.shade300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  child: const Text(
                    'Xem hồ sơ',
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[700],
              fontFamily: 'Quicksand',
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: 'Quicksand',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemRow(Map<String, dynamic> item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Quicksand',
                  ),
                ),
                if (item['hours'] != null)
                  Text(
                    '${item['hours']} giờ',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                      fontFamily: 'Quicksand',
                    ),
                  ),
              ],
            ),
          ),
          Text(
            _formatCurrency(item['price']),
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: 'Quicksand',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpSheet() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: Colors.green.shade700,
              ),
              const SizedBox(width: 12),
              const Text(
                'Thông tin thanh toán',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Quicksand',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildHelpItem(
            'Vấn đề về thanh toán',
            'Nếu bạn gặp vấn đề về thanh toán, vui lòng liên hệ với bộ phận hỗ trợ trong vòng 7 ngày kể từ ngày thanh toán.',
          ),
          _buildHelpItem(
            'Hoàn tiền',
            'Chính sách hoàn tiền của chúng tôi cho phép bạn yêu cầu hoàn tiền trong vòng 24 giờ sau khi dịch vụ kết thúc nếu bạn không hài lòng.',
          ),
          _buildHelpItem(
            'Hóa đơn',
            'Bạn có thể tải xuống hóa đơn điện tử cho mỗi giao dịch từ trang chi tiết thanh toán.',
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade600,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Đã hiểu',
                style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              fontFamily: 'Quicksand',
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
              color: Colors.grey[700],
              fontFamily: 'Quicksand',
            ),
          ),
        ],
      ),
    );
  }
}
