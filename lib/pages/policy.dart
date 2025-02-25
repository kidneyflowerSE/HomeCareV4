import 'package:flutter/material.dart';

class TermsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Điều khoản dịch vụ"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("1. Quyền và nghĩa vụ của Khách hàng"),
            _buildBulletPoint("Đảm bảo môi trường làm việc tốt, an toàn và lành mạnh cho nhân viên Công ty."),
            _buildBulletPoint("Tự bảo quản và chịu trách nhiệm trong việc quản lý tài sản của mình."),
            _buildBulletPoint("Hủy buổi làm việc sẽ được Công ty sắp xếp làm bù trong vòng 1 tuần."),
            _buildBulletPoint("Thông báo trước 24h nếu muốn thay đổi lịch làm việc."),
            _buildBulletPoint("Không nhận nhân viên Công ty vào làm việc trực tiếp trong 3 tháng."),
            _buildBulletPoint("Kịp thời thông báo nếu phát hiện hành vi tiêu cực từ nhân viên."),

            _buildSectionTitle("2. Quyền và nghĩa vụ của Công ty"),
            _buildBulletPoint("Cung cấp nhân viên giúp việc có lý lịch rõ ràng, đã qua đào tạo."),
            _buildBulletPoint("Tiếp nhận phản hồi của khách hàng và đảm bảo chất lượng dịch vụ."),

            _buildSectionTitle("3. Giải quyết tranh chấp và khiếu nại"),
            _buildBulletPoint("Ưu tiên thương lượng, hòa giải, nếu không sẽ giải quyết tại Tòa án Nhân dân."),

            _buildSectionTitle("4. Thanh toán phí dịch vụ"),
            _buildBulletPoint("Thanh toán theo từng tháng hoặc ngay khi kết thúc hợp đồng."),
            _buildBulletPoint("Thanh toán bằng tiền mặt cho nhân viên được chỉ định."),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return ListTile(
      leading: Icon(Icons.check_circle, color: Colors.green),
      title: Text(
        text,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
