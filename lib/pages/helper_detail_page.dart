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
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          _buildProfileHeader(context),
          Expanded(
            child: _buildTabbedContent(context),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        helper.fullName ?? 'No Name',
        style: const TextStyle(
          fontFamily: 'Quicksand',
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      backgroundColor: Colors.green.shade600,
      foregroundColor: Colors.white,
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(Icons.share),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.green.shade100.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Hero(
            tag: 'helper_avatar_${helper.id}',
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.green.shade200, width: 3),
              ),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[200],
                backgroundImage: helper.avatar?.isNotEmpty == true
                    ? NetworkImage(helper.avatar!)
                    : null,
                child: helper.avatar?.isNotEmpty != true
                    ? Icon(Icons.person, size: 50, color: Colors.grey[400])
                    : null,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  helper.helperId ?? 'No ID',
                  style: TextStyle(
                    color: Colors.green.shade700,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  helper.phone ?? 'Chưa cập nhật',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabbedContent(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TabBar(
              indicator: BoxDecoration(
                color: Colors.green.shade600,
                borderRadius: BorderRadius.circular(10),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.green.shade800,
              tabs: const [
                Tab(text: 'Cơ bản'),
                Tab(text: 'Kinh nghiệm'),
                Tab(text: 'Chi tiết'),
              ],
            ),
          ),
          SizedBox(
            height: 500, // Adjust as needed
            child: TabBarView(
              children: [
                _buildBasicTab(),
                _buildExperienceTab(),
                _buildDetailsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoSection('Thông tin cơ bản', [
            _buildInfoTile(
              'Ngày bắt đầu',
              helper.startDate != null
                  ? DateFormat('dd/MM/yyyy')
                      .format(DateTime.parse(helper.startDate!))
                  : 'Chưa cập nhật',
            ),
            _buildInfoTile('Mã nhân viên', helper.helperId ?? 'Chưa cập nhật'),
            _buildInfoTile('Tỉnh/TP', helper.workingArea.province),
          ]),
          if (helper.workingArea.districts.isNotEmpty) ...[
            const SizedBox(height: 16),
            _buildChipSection(
                'Quận/Huyện',
                helper.workingArea.districts
                    .map((district) => _buildChip(district))
                    .toList()),
          ],
        ],
      ),
    );
  }

  Widget _buildExperienceTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoSection('Kinh nghiệm', [
            _buildInfoTile(
                'Tổng kinh nghiệm', '${helper.yearOfExperience} năm'),
          ]),
          if (helper.jobs.isNotEmpty) ...[
            const SizedBox(height: 16),
            _buildChipSection(
                'Kỹ năng', helper.jobs.map((job) => _buildChip(job)).toList()),
          ],
          if (helper.experienceDescription != null) ...[
            const SizedBox(height: 16),
            _buildInfoSection('Mô tả chi tiết', [
              Text(
                helper.experienceDescription!,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            ]),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoSection('Thông tin cá nhân', [
            _buildInfoTile(
              'Ngày sinh',
              helper.birthDay != null
                  ? DateFormat('dd/MM/yyyy')
                      .format(DateTime.parse(helper.birthDay!))
                  : 'Chưa cập nhật',
            ),
            _buildInfoTile('Nơi sinh', helper.birthPlace ?? 'Chưa cập nhật'),
            _buildInfoTile('Địa chỉ', helper.address ?? 'Chưa cập nhật'),
            _buildInfoTile('Giới tính', helper.gender ?? 'Chưa cập nhật'),
            _buildInfoTile('Quốc tịch', helper.nationality ?? 'Chưa cập nhật'),
          ]),
          const SizedBox(height: 16),
          _buildInfoSection('Sức khỏe', [
            _buildInfoTile('Chiều cao', '${helper.height} cm'),
            _buildInfoTile('Cân nặng', '${helper.weight} kg'),
          ]),
          if (helper.healthCertificates.isNotEmpty) ...[
            const SizedBox(height: 16),
            _buildCertificateSection(),
          ],
          const SizedBox(height: 16),
          _buildInfoSection('Học vấn', [
            _buildInfoTile(
                'Trình độ', helper.educationLevel ?? 'Chưa cập nhật'),
          ]),
        ],
      ),
    );
  }

  Widget _buildInfoSection(String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.green.shade100.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green.shade800,
            ),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _buildChipSection(String title, List<Widget> chips) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.green.shade100.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green.shade800,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: chips,
          ),
        ],
      ),
    );
  }

  Widget _buildCertificateSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.green.shade100.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Chứng nhận sức khỏe',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green.shade800,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: helper.healthCertificates.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      helper.healthCertificates[index],
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.green.shade700,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[800],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String label) {
    return Chip(
      label: Text(label),
      backgroundColor: Colors.green.shade50,
      labelStyle: TextStyle(
        color: Colors.green.shade800,
        fontWeight: FontWeight.w500,
      ),
      side: BorderSide(color: Colors.green.shade200),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.message,
                color: Colors.green.shade600,
              ),
              label: Text(
                'Chat',
                style: TextStyle(color: Colors.green.shade600),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade50,
                elevation: 0,
                side: BorderSide(color: Colors.green.shade200),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.person_add, color: Colors.white),
              label: const Text('Thuê'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade600,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
