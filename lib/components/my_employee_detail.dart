import 'package:flutter/material.dart';
import 'package:foodapp/components/my_button.dart';

class MyEmployeeDetail extends StatelessWidget {
  const MyEmployeeDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: Column(
                children: [
                  _buildEmployeeId(),
                  _buildProfileSection(),
                  _buildStatistics(),
                  _buildSkillsSection(),
                  _buildAboutSection(),
                  _buildReviewsSection(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
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
        padding: const EdgeInsets.all(16),
        child: MyButton(
          text: "Đặt lịch với nhân viên này",
          onTap: () {
            // Thêm logic xử lý khi bấm nút
          },
        ),
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height * 0.25,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'lib/images/staff/anhhuy.jpg',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(color: Colors.grey); // Placeholder nếu ảnh lỗi
              },
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        onPressed: () {
          Navigator.pop(context); // Quay lại màn hình trước
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.favorite_border, color: Colors.white),
          onPressed: () {
            // Thêm logic yêu thích
          },
        ),
        IconButton(
          icon: const Icon(Icons.share, color: Colors.white),
          onPressed: () {
            // Thêm logic chia sẻ
          },
        ),
      ],
    );
  }

  Widget _buildEmployeeId() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: const Text(
        "Mã nhân viên: #49549",
        style: TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.w600,
          fontFamily: 'Quicksand',
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            "Phạm Nguyễn Quốc Huy",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Quicksand',
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_on, color: Colors.grey, size: 16),
              const SizedBox(width: 4),
              Text(
                "Quận Thủ Đức, TP.Hồ Chí Minh",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontFamily: 'Quicksand',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatistics() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem("20", "Tuổi", Icons.cake),
          _buildStatItem("5.0", "Đánh giá", Icons.star,
              iconColor: Colors.amber),
          _buildStatItem("582", "Giờ làm", Icons.access_time),
          _buildStatItem("239", "Lượt thuê", Icons.people),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon,
      {Color? iconColor}) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: iconColor ?? Colors.grey[600]),
            const SizedBox(width: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Quicksand',
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
            fontFamily: 'Quicksand',
          ),
        ),
      ],
    );
  }

  Widget _buildSkillsSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Kỹ năng",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Quicksand',
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildSkillChip("Quét nhà", Icons.cleaning_services),
              _buildSkillChip("Rửa chén", Icons.wash),
              _buildSkillChip("Nấu cơm", Icons.restaurant),
              _buildSkillChip("Giặt đồ", Icons.local_laundry_service),
              _buildSkillChip("Lau nhà", Icons.moped),
              _buildSkillChip("Dọn phòng", Icons.bedroom_parent),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkillChip(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.green),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: Colors.green.shade700,
              fontFamily: 'Quicksand',
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Giới thiệu",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Quicksand',
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Tôi có 3 năm kinh nghiệm làm việc nhà. Tôi luôn đảm bảo công việc được hoàn thành đúng giờ và chất lượng. Tôi thích sự gọn gàng và ngăn nắp.",
            style: TextStyle(
              color: Colors.grey[600],
              height: 1.5,
              fontFamily: 'Quicksand',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Đánh giá gần đây",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Quicksand',
                ),
              ),
              TextButton(
                onPressed: () {
                  // Logic khi xem tất cả đánh giá
                },
                child: const Text("Xem tất cả"),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildReviewItem(),
          _buildReviewItem(),
        ],
      ),
    );
  }

  Widget _buildReviewItem() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey[200],
                child: const Icon(Icons.person),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Nguyễn Văn A",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Quicksand',
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, size: 16, color: Colors.amber[400]),
                        Icon(Icons.star, size: 16, color: Colors.amber[400]),
                        Icon(Icons.star, size: 16, color: Colors.amber[400]),
                        Icon(Icons.star, size: 16, color: Colors.amber[400]),
                        Icon(Icons.star, size: 16, color: Colors.amber[400]),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                "2 ngày trước",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                  fontFamily: 'Quicksand',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "Nhân viên làm việc rất tốt và chuyên nghiệp. Sẽ thuê lại lần sau.",
            style: TextStyle(
              color: Colors.grey[600],
              height: 1.5,
              fontFamily: 'Quicksand',
            ),
          ),
        ],
      ),
    );
  }
}
