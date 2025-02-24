import 'package:flutter/material.dart';
import 'package:foodapp/data/model/helper.dart';
import 'package:intl/intl.dart';

class HelperDetailPage extends StatelessWidget {
  final Helper helper;

  const HelperDetailPage({
    super.key,
    required this.helper,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBasicInfo(),
                  const SizedBox(height: 24),
                  _buildWorkExperience(),
                  const SizedBox(height: 24),
                  _buildPersonalInfo(),
                  const SizedBox(height: 24),
                  _buildWorkingArea(),
                  const SizedBox(height: 24),
                  _buildHealthInfo(),
                  const SizedBox(height: 24),
                  _buildEducationInfo(),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300,
      backgroundColor: Colors.green,
      pinned: true,
      title: Text(
        helper.fullName ?? 'No Name',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Hero(
              tag: 'helper_avatar_${helper.id}',
              child: helper.avatar != null && helper.avatar!.isNotEmpty
                  ? Image.network(
                      helper.avatar!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          _buildAvatarPlaceholder(),
                    )
                  : _buildAvatarPlaceholder(),
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
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    helper.fullName ?? 'No Name',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        '4.8',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      leading: IconButton(
        icon: const CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black),
        ),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildAvatarPlaceholder() {
    return Container(
      color: Colors.grey[200],
      child: Icon(
        Icons.person,
        size: 80,
        color: Colors.grey[400],
      ),
    );
  }

  Widget _buildBasicInfo() {
    return _buildSection(
      title: 'Thông tin cơ bản',
      child: Column(
        children: [
          _buildInfoRow(
            icon: Icons.phone,
            title: 'Số điện thoại',
            value: helper.phone ?? 'Chưa cập nhật',
          ),
          _buildInfoRow(
            icon: Icons.calendar_today,
            title: 'Ngày bắt đầu làm việc',
            value: helper.startDate != null
                ? DateFormat('dd/MM/yyyy')
                    .format(DateTime.parse(helper.startDate!))
                : 'Chưa cập nhật',
          ),
          _buildInfoRow(
            icon: Icons.work,
            title: 'Mã nhân viên',
            value: helper.helperId ?? 'Chưa cập nhật',
          ),
        ],
      ),
    );
  }

  Widget _buildWorkExperience() {
    return _buildSection(
      title: 'Kinh nghiệm làm việc',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(
            icon: Icons.timer,
            title: 'Số năm kinh nghiệm',
            value: '${helper.yearOfExperience} năm',
          ),
          const SizedBox(height: 12),
          Text(
            'Các công việc có thể làm:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: helper.jobs.map((job) => _buildJobChip(job)).toList(),
          ),
          if (helper.experienceDescription != null) ...[
            const SizedBox(height: 12),
            Text(
              'Mô tả kinh nghiệm:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              helper.experienceDescription!,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPersonalInfo() {
    return _buildSection(
      title: 'Thông tin cá nhân',
      child: Column(
        children: [
          _buildInfoRow(
            icon: Icons.cake,
            title: 'Ngày sinh',
            value: helper.birthDay != null
                ? DateFormat('dd/MM/yyyy')
                    .format(DateTime.parse(helper.birthDay!))
                : 'Chưa cập nhật',
          ),
          _buildInfoRow(
            icon: Icons.location_city,
            title: 'Nơi sinh',
            value: helper.birthPlace ?? 'Chưa cập nhật',
          ),
          _buildInfoRow(
            icon: Icons.home,
            title: 'Địa chỉ',
            value: helper.address ?? 'Chưa cập nhật',
          ),
          _buildInfoRow(
            icon: Icons.person,
            title: 'Giới tính',
            value: helper.gender ?? 'Chưa cập nhật',
          ),
          _buildInfoRow(
            icon: Icons.flag,
            title: 'Quốc tịch',
            value: helper.nationality ?? 'Chưa cập nhật',
          ),
        ],
      ),
    );
  }

  Widget _buildWorkingArea() {
    return _buildSection(
      title: 'Khu vực làm việc',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(
            icon: Icons.location_on,
            title: 'Tỉnh/Thành phố',
            value: helper.workingArea.province,
          ),
          const SizedBox(height: 12),
          Text(
            'Quận/Huyện:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: helper.workingArea.districts
                .map((district) => _buildDistrictChip(district))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthInfo() {
    return _buildSection(
      title: 'Thông tin sức khỏe',
      child: Column(
        children: [
          _buildInfoRow(
            icon: Icons.height,
            title: 'Chiều cao',
            value: '${helper.height} cm',
          ),
          _buildInfoRow(
            icon: Icons.monitor_weight,
            title: 'Cân nặng',
            value: '${helper.weight} kg',
          ),
          const SizedBox(height: 12),
          if (helper.healthCertificates.isNotEmpty) ...[
            Text(
              'Giấy khám sức khỏe:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: helper.healthCertificates.length,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    helper.healthCertificates[index],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey[200],
                      child: Icon(Icons.image_not_supported),
                    ),
                  ),
                );
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildEducationInfo() {
    return _buildSection(
      title: 'Trình độ học vấn',
      child: _buildInfoRow(
        icon: Icons.school,
        title: 'Trình độ',
        value: helper.educationLevel ?? 'Chưa cập nhật',
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        child,
      ],
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.blue),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobChip(String job) {
    return Chip(
      label: Text(
        job,
        style: const TextStyle(fontSize: 12),
      ),
      backgroundColor: Colors.blue.shade50,
      side: BorderSide(color: Colors.blue.shade100),
    );
  }

  Widget _buildDistrictChip(String district) {
    return Chip(
      label: Text(
        district,
        style: const TextStyle(fontSize: 12),
      ),
      backgroundColor: Colors.green.shade50,
      side: BorderSide(color: Colors.green.shade100),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {
                // Handle message action
              },
              icon: const Icon(Icons.message),
              label: const Text('Nhắn tin'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // Handle hire action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text('Thuê ngay'),
            ),
          ),
        ],
      ),
    );
  }
}
