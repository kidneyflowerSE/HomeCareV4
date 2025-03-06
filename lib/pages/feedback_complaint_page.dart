import 'package:flutter/material.dart';

class FeedbackComplaintsPage extends StatefulWidget {
  @override
  _FeedbackComplaintsPageState createState() => _FeedbackComplaintsPageState();
}

class _FeedbackComplaintsPageState extends State<FeedbackComplaintsPage> {
  final _formKey = GlobalKey<FormState>();
  String _selectedFeedbackType = 'Phản hồi dịch vụ';
  int _rating = 0;
  bool _isUrgent = false;

  // Controller for text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();

  final List<String> _feedbackTypes = [
    'Phản hồi dịch vụ',
    'Khiếu nại về nhân viên',
    'Vấn đề thanh toán',
    'Đề xuất cải thiện',
    'Vấn đề khác',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Phản hồi & khiếu nại",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Quicksand',
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.indigo.shade50, Colors.white],
          ),
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Feedback Type Selection
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.category, color: Colors.green),
                            SizedBox(width: 8),
                            Text(
                              "Loại phản hồi",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade800,
                                fontFamily: 'Quicksand',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: _selectedFeedbackType,
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 24,
                              elevation: 16,
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              style: TextStyle(
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                fontFamily: 'Quicksand',
                              ),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    _selectedFeedbackType = newValue;
                                  });
                                }
                              },
                              items: _feedbackTypes
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        if (_selectedFeedbackType == 'Phản hồi dịch vụ')
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Đánh giá dịch vụ",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade800,
                                  fontFamily: 'Quicksand',
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: List.generate(5, (index) {
                                  return IconButton(
                                    icon: Icon(
                                      index < _rating
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: index < _rating
                                          ? Colors.amber
                                          : Colors.grey,
                                      size: 32,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _rating = index + 1;
                                      });
                                    },
                                  );
                                }),
                              ),
                            ],
                          ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Checkbox(
                              value: _isUrgent,
                              activeColor: Colors.red,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isUrgent = value ?? false;
                                });
                              },
                            ),
                            Text(
                              "Vấn đề cần giải quyết khẩn cấp",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: _isUrgent
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                fontFamily: 'Quicksand',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),

                // Contact Information
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.person, color: Colors.green),
                            SizedBox(width: 8),
                            Text(
                              "Thông tin liên hệ",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade800,
                                fontFamily: 'Quicksand',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          cursorColor: Colors.green,
                          controller: _nameController,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade800,
                            fontFamily: 'Quicksand',
                          ),
                          decoration: InputDecoration(
                            labelText: "Họ và tên",
                            labelStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade400,
                              fontFamily: 'Quicksand',
                            ),
                            floatingLabelStyle: TextStyle(
                              color: Colors.grey.shade800,
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.w600,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            // Border khi focus
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            prefixIcon: Icon(
                              Icons.person_rounded,
                              color: Colors.grey.shade400,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập họ tên';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 12),
                        TextFormField(
                          cursorColor: Colors.green,
                          controller: _phoneController,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade800,
                            fontFamily: 'Quicksand',
                          ),
                          decoration: InputDecoration(
                            labelText: "Số điện thoại",
                            labelStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade400,
                              fontFamily: 'Quicksand',
                            ),
                            floatingLabelStyle: TextStyle(
                              color: Colors.grey.shade800,
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.w600,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            // Border khi focus
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            prefixIcon: Icon(
                              Icons.phone_android,
                              color: Colors.grey.shade400,
                            ),
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập số điện thoại';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 12),
                        TextFormField(
                          cursorColor: Colors.green,
                          controller: _emailController,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade800,
                            fontFamily: 'Quicksand',
                          ),
                          decoration: InputDecoration(
                            labelText: "Email",
                            labelStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade400,
                              fontFamily: 'Quicksand',
                            ),
                            floatingLabelStyle: TextStyle(
                              color: Colors.grey.shade800,
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.w600,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            // Border khi focus
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: Colors.grey.shade400,
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),

                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.description, color: Colors.green),
                            SizedBox(width: 8),
                            Text(
                              "Chi tiết phản hồi",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade800,
                                fontFamily: 'Quicksand',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: _detailsController,
                          maxLines: 5,
                          cursorColor: Colors.green,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade800,
                            fontFamily: 'Quicksand',
                          ),
                          decoration: InputDecoration(
                            hintText: "Mô tả chi tiết phản hồi của bạn...",
                            hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey.shade800,
                              fontFamily: 'Quicksand',
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            // Border khi focus
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập nội dung phản hồi';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 12),
                        ElevatedButton.icon(
                          icon: Icon(
                            Icons.attach_file,
                          ),
                          label: Text(
                            "Đính kèm hình ảnh/tài liệu",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600,
                              fontFamily: 'Quicksand',
                            ),
                          ),
                          onPressed: () {
                            // Handle file attachment
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade100,
                            foregroundColor: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24),

                // Submit button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Process feedback submission
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Phản hồi đã được gửi thành công!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: Text(
                      "Gửi phản hồi",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Quicksand',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),

                // Privacy note
                Center(
                  child: Text(
                    "Thông tin của bạn sẽ được bảo mật theo chính sách bảo mật.",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
