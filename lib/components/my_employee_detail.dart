import 'package:flutter/material.dart';
import 'package:foodapp/data/model/helper.dart';

class MyEmployeeDetail extends StatelessWidget {
  final Helper helper;

  const MyEmployeeDetail({super.key, required this.helper});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chi tiết nhân viên",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Quicksand',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            _buildEmployeeId(helper.helperId ?? ''),
            const SizedBox(height: 16),
            _buildProfileSection(helper),
            const SizedBox(height: 20),
            _buildStatistics(helper),
            const SizedBox(height: 20),
            _buildSkillsSection(helper.jobs),
            const SizedBox(height: 20),
            _buildAboutSection(helper.experienceDescription ?? ''),
            const SizedBox(height: 20),
            _buildAdditionalInfo(helper),
            const SizedBox(height: 20),
            _buildWorkingAreaSection(helper.workingArea),
            const SizedBox(height: 20),
            _buildHealthCertificates(helper.healthCertificates),
          ],
        ),
      ),
    );
  }

  Widget _buildEmployeeId(String employeeId) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.green[50],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.green.shade200),
        ),
        child: Text(
          "Mã nhân viên: $employeeId",
          style: const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.w600,
            fontFamily: 'Quicksand',
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection(Helper helper) {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(helper.avatar ?? ''),
            onBackgroundImageError: (error, stackTrace) =>
                const Icon(Icons.person, size: 60),
          ),
          const SizedBox(height: 16),
          Text(
            helper.fullName ?? 'Không có tên',
            style: const TextStyle(
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
                helper.address ?? 'Không có địa chỉ',
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

  Widget _buildStatistics(Helper helper) {
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
          _buildStatItem(
              helper.yearOfExperience.toString(), "Năm KN", Icons.work),
          _buildStatItem(
              helper.height.toString(), "Chiều cao (cm)", Icons.height),
          _buildStatItem(
              helper.weight.toString(), "Cân nặng (kg)", Icons.line_weight),
          _buildStatItem(
              helper.gender ?? 'Không rõ', "Giới tính", Icons.person),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: Colors.grey[600]),
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

  Widget _buildSkillsSection(List<String> skills) {
    return Column(
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
          children: skills
              .map((skill) => _buildSkillChip(skill, Icons.cleaning_services))
              .toList(),
        ),
      ],
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

  Widget _buildAboutSection(String about) {
    return Column(
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
          about,
          style: TextStyle(
            color: Colors.grey[600],
            height: 1.5,
            fontFamily: 'Quicksand',
          ),
        ),
      ],
    );
  }

  Widget _buildAdditionalInfo(Helper helper) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Thông tin bổ sung",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Quicksand',
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "Quốc tịch: ${helper.nationality ?? 'Không rõ'}",
          style: TextStyle(
            color: Colors.grey[600],
            fontFamily: 'Quicksand',
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Trình độ học vấn: ${helper.educationLevel ?? 'Không rõ'}",
          style: TextStyle(
            color: Colors.grey[600],
            fontFamily: 'Quicksand',
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Ngày bắt đầu làm việc: ${helper.startDate ?? 'Không rõ'}",
          style: TextStyle(
            color: Colors.grey[600],
            fontFamily: 'Quicksand',
          ),
        ),
      ],
    );
  }

  Widget _buildWorkingAreaSection(WorkingArea workingArea) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Khu vực làm việc",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Quicksand',
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "Tỉnh: ${workingArea.province}",
          style: TextStyle(
            color: Colors.grey[600],
            height: 1.5,
            fontFamily: 'Quicksand',
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Quận: ${workingArea.districts.join(', ')}",
          style: TextStyle(
            color: Colors.grey[600],
            height: 1.5,
            fontFamily: 'Quicksand',
          ),
        ),
      ],
    );
  }

  Widget _buildHealthCertificates(List<String> certificates) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Chứng chỉ sức khỏe",
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
          children:
              certificates.map((cert) => _buildCertificate(cert)).toList(),
        ),
      ],
    );
  }

  Widget _buildCertificate(String certificateUrl) {
    return Container(
      width: 160,
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          certificateUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[200],
              child: const Icon(
                Icons.image_not_supported,
                color: Colors.grey,
              ),
            );
          },
        ),
      ),
    );
  }
}
