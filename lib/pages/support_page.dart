import 'package:flutter/material.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({super.key});

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  final TextEditingController _issueController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;
  String? _selectedCategory;

  final List<String> _categories = [
    'Vấn đề về thanh toán',
    'Thông tin người giúp việc',
    'Đặt lịch hẹn',
    'Vấn đề kỹ thuật',
    'Đánh giá và phản hồi',
    'Khác',
  ];

  final List<Map<String, dynamic>> _faqs = [
    {
      'question': 'Làm thế nào để đặt lịch với người giúp việc?',
      'answer':
          'Bạn có thể đặt lịch bằng cách nhấn vào nút "Thuê ngay" trên trang thông tin của người giúp việc, sau đó chọn ngày và thời gian phù hợp.'
    },
    {
      'question': 'Tôi có thể hủy lịch đã đặt không?',
      'answer':
          'Có, bạn có thể hủy lịch đã đặt trước 24 giờ mà không bị mất phí. Nếu hủy trong vòng 24 giờ, bạn có thể bị tính một khoản phí nhỏ.'
    },
    {
      'question': 'Làm thế nào để thanh toán dịch vụ?',
      'answer':
          'Ứng dụng hỗ trợ nhiều phương thức thanh toán như thẻ tín dụng, ví điện tử, và thanh toán khi sử dụng dịch vụ (COD).'
    },
    {
      'question': 'Người giúp việc có được đảm bảo về chất lượng không?',
      'answer':
          'Tất cả người giúp việc đều được kiểm tra lý lịch và đánh giá kỹ năng trước khi được chấp nhận vào hệ thống của chúng tôi. Bạn cũng có thể xem đánh giá từ những người dùng khác.'
    },
    {
      'question': 'Tôi không hài lòng với dịch vụ, tôi nên làm gì?',
      'answer':
          'Nếu bạn không hài lòng, vui lòng để lại đánh giá chân thực và liên hệ với đội ngũ hỗ trợ của chúng tôi. Chúng tôi sẽ giải quyết vấn đề của bạn trong thời gian sớm nhất.'
    },
  ];

  @override
  void dispose() {
    _issueController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submitRequest() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });

      // Simulate network request
      await Future.delayed(const Duration(seconds: 1));

      // Create support ticket data
      final ticketData = {
        'category': _selectedCategory,
        'subject': _issueController.text,
        'description': _descriptionController.text,
        'timestamp': DateTime.now().toIso8601String(),
      };

      // TODO: Send the support ticket data to your backend
      print('Support ticket submitted: $ticketData');

      setState(() {
        _isSubmitting = false;
      });

      // Show success dialog
      if (mounted) {
        _showSuccessDialog();
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green.shade600,
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Yêu cầu đã được gửi',
                style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Chúng tôi đã nhận được yêu cầu hỗ trợ của bạn và sẽ liên hệ trong vòng 24 giờ.',
              style: TextStyle(
                fontFamily: 'Quicksand',
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Mã yêu cầu: #${DateTime.now().millisecondsSinceEpoch.toString().substring(5, 13)}',
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Clear form and reset state
              _issueController.clear();
              _descriptionController.clear();
              setState(() {
                _selectedCategory = null;
              });
            },
            child: Text(
              'Đóng',
              style: TextStyle(
                fontFamily: 'Quicksand',
                color: Colors.green.shade700,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hỗ trợ',
          style: TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              color: Colors.green,
              child: const TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white70,
                indicatorColor: Colors.white,
                indicatorWeight: 3,
                tabs: [
                  Tab(
                    text: 'Yêu cầu hỗ trợ',
                    icon: Icon(Icons.headset_mic),
                  ),
                  Tab(
                    text: 'Câu hỏi thường gặp',
                    icon: Icon(Icons.question_answer),
                  ),
                ],
                labelStyle: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildSupportRequestForm(),
                  _buildFAQList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportRequestForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoCard(),
            const SizedBox(height: 24),
            const Text(
              'Tạo yêu cầu hỗ trợ mới',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Quicksand',
              ),
            ),
            const SizedBox(height: 16),
            _buildDropdown(),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _issueController,
              label: 'Tiêu đề',
              hint: 'Nhập tiêu đề ngắn gọn cho vấn đề của bạn',
              maxLines: 1,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập tiêu đề';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _descriptionController,
              label: 'Mô tả chi tiết',
              hint: 'Mô tả chi tiết vấn đề bạn đang gặp phải...',
              maxLines: 5,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập mô tả chi tiết';
                }
                if (value.length < 10) {
                  return 'Mô tả quá ngắn, vui lòng cung cấp thêm thông tin';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submitRequest,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: _isSubmitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'Gửi yêu cầu',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Quicksand',
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            color: Colors.blue.shade700,
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Thời gian phản hồi',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: 'Quicksand',
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Chúng tôi sẽ phản hồi yêu cầu của bạn trong vòng 24 giờ. Đối với các vấn đề khẩn cấp, vui lòng gọi hotline: 1900 1234.',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Quicksand',
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Danh mục',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Quicksand',
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButtonFormField<String>(
            value: _selectedCategory,
            hint: const Text('Chọn danh mục'),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: InputBorder.none,
              hintStyle: TextStyle(
                color: Colors.grey[400],
                fontFamily: 'Quicksand',
              ),
            ),
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 16,
              fontFamily: 'Quicksand',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vui lòng chọn danh mục';
              }
              return null;
            },
            items: _categories.map((category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(category),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedCategory = value;
              });
            },
            icon: Icon(Icons.arrow_drop_down, color: Colors.green.shade600),
            isExpanded: true,
            dropdownColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required int maxLines,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'Quicksand',
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.grey[400],
              fontFamily: 'Quicksand',
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.green.shade300, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.red.shade300),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.red.shade300, width: 2),
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
          style: TextStyle(
            color: Colors.grey[800],
            fontSize: 16,
            fontFamily: 'Quicksand',
          ),
          validator: validator,
        ),
      ],
    );
  }

  Widget _buildFAQList() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(
            'Câu hỏi thường gặp',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Quicksand',
              color: Colors.green.shade800,
            ),
          ),
        ),
        ..._faqs.map((faq) => _buildFAQItem(faq)).toList(),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.green.shade100),
          ),
          child: Row(
            children: [
              Icon(
                Icons.lightbulb_outline,
                color: Colors.green.shade700,
                size: 24,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Không tìm thấy câu trả lời?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'Quicksand',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Nếu bạn không tìm thấy câu trả lời trong FAQ, vui lòng tạo yêu cầu hỗ trợ để đội ngũ của chúng tôi có thể giúp đỡ bạn.',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Quicksand',
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton(
                      onPressed: () {
                        // Safely switch to first tab using a Builder to ensure we have the correct context
                        Builder(
                          builder: (BuildContext context) {
                            final tabController =
                                DefaultTabController.of(context);
                            if (tabController != null) {
                              tabController.animateTo(0);
                            }
                            return const SizedBox.shrink();
                          },
                        );
                        // As a fallback, also use this technique
                        final tabController = DefaultTabController.of(context);
                        if (tabController != null) {
                          tabController.animateTo(0);
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.green.shade700,
                        side: BorderSide(color: Colors.green.shade300),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Tạo yêu cầu hỗ trợ',
                        style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFAQItem(Map<String, dynamic> faq) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ExpansionTile(
        title: Text(
          faq['question'],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            fontFamily: 'Quicksand',
          ),
        ),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        iconColor: Colors.green.shade600,
        collapsedIconColor: Colors.green.shade600,
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          Text(
            faq['answer'],
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Colors.grey[700],
              fontFamily: 'Quicksand',
            ),
          ),
        ],
      ),
    );
  }
}
