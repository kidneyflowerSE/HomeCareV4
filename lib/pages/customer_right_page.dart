import 'package:flutter/material.dart';
import 'package:foodapp/components/my_button.dart';

class CustomerRight extends StatefulWidget {
  @override
  State<CustomerRight> createState() => _CustomerRightState();
}

class _CustomerRightState extends State<CustomerRight> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Quyền lợi khách hàng",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Quicksand',
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.green,
      ),
      // bottomNavigationBar: Column(
      //   mainAxisSize: MainAxisSize.min,
      //   children: [
      //     Container(
      //         padding: const EdgeInsets.all(16),
      //         child: MyButton(
      //             text: 'Quay lại', onTap: () => Navigator.pop(context))),
      //   ],
      // ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   "QUYỀN LỢI KHÁCH HÀNG",
              //   style: TextStyle(
              //     fontSize: 24,
              //     fontWeight: FontWeight.bold,
              //     color: Colors.green,
              //   ),
              // ),
              // SizedBox(height: 16),
              _buildSection("1. Chất lượng dịch vụ tối ưu", [
                "Tuyển chọn người giúp việc kỹ lưỡng, đào tạo bài bản.",
                "Cung cấp người giúp việc có kinh nghiệm, đáp ứng nhu cầu đa dạng.",
                "Kiểm tra và đánh giá hiệu quả làm việc thường xuyên.",
              ]),
              _buildSection("2. Chính sách giá cạnh tranh", [
                "Cam kết giá thành hợp lý, minh bạch.",
                "Chính sách đổi người giúp việc miễn phí nếu khách hàng không hài lòng.",
                "Hỗ trợ khách hàng linh hoạt về thời gian và hình thức thanh toán.",
              ]),
              _buildSection("3. An toàn và bảo mật", [
                "Kiểm duyệt lý lịch người giúp việc.",
                "Ký hợp đồng rõ ràng, đảm bảo quyền lợi của khách hàng.",
                "Cam kết bảo vệ thông tin cá nhân khách hàng.",
              ]),
              _buildSection("4. Hỗ trợ 24/7", [
                "Dịch vụ tư vấn và hỗ trợ khách hàng 24/7.",
                "Giải quyết nhanh chóng mọi rắc rối, khiếu nại.",
                "Đội ngũ nhân viên tận tâm, chu đáo.",
              ]),
              SizedBox(height: 20),
              // Center(
              //   child: ElevatedButton(
              //     onPressed: () => Navigator.pop(context),
              //     child: Text("Quay lại"),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<String> points) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              fontFamily: 'Quicksand',
            ),
          ),
          SizedBox(height: 8),
          ...points.map((point) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.check_circle, color: Colors.green, size: 20),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        point,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontFamily: 'Quicksand',
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
