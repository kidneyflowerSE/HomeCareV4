import 'package:flutter/material.dart';
import 'package:foodapp/data/model/helper.dart';
import 'package:intl/intl.dart';
import '../data/model/service.dart';

class HelperDetailPage extends StatelessWidget {
  final Helper helper;
  final List<Services> services;

  const HelperDetailPage({
    super.key,
    required this.helper,
    required this.services,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          SliverToBoxAdapter(
            child: _buildProfileCard(context),
          ),
          SliverFillRemaining(
            hasScrollBody: true,
            child: _buildTabbedContent(context),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 50,
      backgroundColor: Colors.green,
      iconTheme: IconThemeData(color: Colors.white),
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          helper.fullName ?? 'No Name',
          style: const TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20,
            // shadows: [
            //   Shadow(
            //     blurRadius: 4.0,
            //     color: Colors.black45,
            //     offset: Offset(0, 2),
            //   ),
            // ],
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.favorite_border),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.share),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    List<Services> helperServices =
        services.where((service) => helper.jobs.contains(service.id)).toList();

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        children: [
          // Profile card with avatar, name, and basic info
          Container(
            margin: const EdgeInsets.only(top: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Hero(
                      tag: 'helper_avatar_${helper.id}',
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.green.shade300,
                            width: 3,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 45,
                          backgroundColor: Colors.grey[200],
                          backgroundImage: helper.avatar?.isNotEmpty == true
                              ? NetworkImage(helper.avatar!)
                              : null,
                          child: helper.avatar?.isNotEmpty != true
                              ? Icon(Icons.person,
                                  size: 45, color: Colors.grey[400])
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
                            helper.fullName ?? 'No Name',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Quicksand',
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.badge_outlined,
                                  size: 16, color: Colors.green.shade700),
                              const SizedBox(width: 4),
                              Text(
                                helper.helperId ?? 'No ID',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontFamily: 'Quicksand',
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.phone_outlined,
                                  size: 16, color: Colors.green.shade700),
                              const SizedBox(width: 4),
                              Text(
                                helper.phone ?? 'Chưa cập nhật',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Quicksand',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildStatsRow(),
                if (helperServices.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: helperServices
                          .map((service) => Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Chip(
                                  label: Text(service.title),
                                  backgroundColor: Colors.green.shade50,
                                  labelStyle: TextStyle(
                                    color: Colors.green.shade800,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    fontFamily: 'Quicksand',
                                  ),
                                  side:
                                      BorderSide(color: Colors.green.shade200),
                                  padding: const EdgeInsets.all(0),
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _buildStatItem(
            '${helper.yearOfExperience}',
            'Năm KN',
            Icons.work_outline,
          ),
          _buildVerticalDivider(),
          _buildStatItem(
            helper.workingArea.province,
            'Khu vực',
            Icons.location_on_outlined,
          ),
          _buildVerticalDivider(),
          _buildStatItem(
            helper.startDate != null
                ? DateFormat('MM/yyyy')
                    .format(DateTime.parse(helper.startDate!))
                : '-',
            'Bắt đầu',
            Icons.calendar_today_outlined,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon) {
    return Flexible(
      fit: FlexFit.loose,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 14,
                color: Colors.green.shade700,
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade800,
                    fontFamily: 'Quicksand',
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontFamily: 'Quicksand',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      height: 30,
      width: 1,
      color: Colors.green.shade200,
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
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TabBar(
              indicator: BoxDecoration(
                color: Colors.green.shade600,
                borderRadius: BorderRadius.circular(12),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.green.shade800,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                fontFamily: 'Quicksand',
              ),

              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: EdgeInsets.zero,

              indicatorColor: Colors.transparent,

              padding: const EdgeInsets.all(4),
              // Define tab style
              tabs: const [
                Tab(
                  text: 'Cơ bản',
                  height: 36,
                ),
                Tab(
                  text: 'Kinh nghiệm',
                  height: 36,
                ),
                Tab(
                  text: 'Chi tiết',
                  height: 36,
                ),
              ],

              dividerColor: Colors.transparent,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
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
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          _buildCardSection(
            'Thông tin cơ bản',
            Icons.person_outline,
            Column(
              children: [
                _buildInfoRow(
                  'Ngày bắt đầu',
                  helper.startDate != null
                      ? DateFormat('dd/MM/yyyy')
                          .format(DateTime.parse(helper.startDate!))
                      : 'Chưa cập nhật',
                  Icons.calendar_today_outlined,
                ),
                _buildInfoRow(
                  'Mã nhân viên',
                  helper.helperId ?? 'Chưa cập nhật',
                  Icons.badge_outlined,
                ),
                _buildInfoRow(
                  'Tỉnh/TP',
                  helper.workingArea.province,
                  Icons.location_city_outlined,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (helper.workingArea.districts.isNotEmpty)
            _buildCardSection(
              'Quận/Huyện',
              Icons.map_outlined,
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: helper.workingArea.districts
                    .map((district) => _buildChip(district))
                    .toList(),
              ),
            ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildExperienceTab() {
    List<Services> helperServices =
        services.where((service) => helper.jobs.contains(service.id)).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          _buildCardSection(
            'Kinh nghiệm',
            Icons.work_outline,
            Column(
              children: [
                _buildInfoRow(
                  'Tổng kinh nghiệm',
                  '${helper.yearOfExperience} năm',
                  Icons.event_note_outlined,
                ),
              ],
            ),
          ),
          if (helper.jobs.isNotEmpty) ...[
            const SizedBox(height: 16),
            _buildCardSection(
              'Kỹ năng',
              Icons.engineering_outlined,
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: helperServices
                    .map((service) => _buildChip(service.title))
                    .toList(),
              ),
            ),
          ],
          if (helper.experienceDescription != null) ...[
            const SizedBox(height: 16),
            _buildCardSection(
              'Mô tả chi tiết',
              Icons.description_outlined,
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  helper.experienceDescription!,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
              ),
            ),
          ],
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildDetailsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          _buildCardSection(
            'Thông tin cá nhân',
            Icons.person_pin_outlined,
            Column(
              children: [
                _buildInfoRow(
                  'Ngày sinh',
                  helper.birthDay != null
                      ? DateFormat('dd/MM/yyyy')
                          .format(DateTime.parse(helper.birthDay!))
                      : 'Chưa cập nhật',
                  Icons.cake_outlined,
                ),
                _buildInfoRow(
                  'Nơi sinh',
                  helper.birthPlace ?? 'Chưa cập nhật',
                  Icons.home_outlined,
                ),
                _buildInfoRow(
                  'Địa chỉ',
                  helper.address ?? 'Chưa cập nhật',
                  Icons.location_on_outlined,
                ),
                _buildInfoRow(
                  'Giới tính',
                  helper.gender ?? 'Chưa cập nhật',
                  Icons.wc_outlined,
                ),
                _buildInfoRow(
                  'Quốc tịch',
                  helper.nationality ?? 'Chưa cập nhật',
                  Icons.flag_outlined,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildCardSection(
            'Sức khỏe',
            Icons.favorite_border,
            Column(
              children: [
                _buildInfoRow(
                  'Chiều cao',
                  '${helper.height} cm',
                  Icons.height_outlined,
                ),
                _buildInfoRow(
                  'Cân nặng',
                  '${helper.weight} kg',
                  Icons.monitor_weight_outlined,
                ),
              ],
            ),
          ),
          if (helper.healthCertificates.isNotEmpty) ...[
            const SizedBox(height: 16),
            _buildCertificateSection(),
          ],
          const SizedBox(height: 16),
          _buildCardSection(
            'Học vấn',
            Icons.school_outlined,
            Column(
              children: [
                _buildInfoRow(
                  'Trình độ',
                  helper.educationLevel ?? 'Chưa cập nhật',
                  Icons.grade_outlined,
                ),
              ],
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildCardSection(String title, IconData icon, Widget content) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 3.0,
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: Colors.green.shade700,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade800,
                  fontFamily: 'Quicksand',
                ),
              ),
            ],
          ),
          Divider(
            height: 24,
            color: Colors.grey.shade300,
          ),
          content,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: Colors.green.shade600,
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
                fontFamily: 'Quicksand',
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[800],
                fontWeight: FontWeight.w500,
                fontFamily: 'Quicksand',
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
        fontSize: 13,
        fontFamily: 'Quicksand',
      ),
      side: BorderSide(color: Colors.green.shade200),
      padding: const EdgeInsets.all(0),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  Widget _buildCertificateSection() {
    return _buildCardSection(
      'Chứng nhận sức khỏe',
      Icons.verified_outlined,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: helper.healthCertificates.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () {
                    // View full image
                  },
                  child: Container(
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 3,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Stack(
                        children: [
                          Image.network(
                            helper.healthCertificates[index],
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            right: 5,
                            bottom: 5,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Icon(
                                Icons.zoom_in,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
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

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.chat_outlined,
                  color: Colors.green.shade700,
                  size: 20,
                ),
                label: const Text(
                  'Chat',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quicksand',
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.green.shade700,
                  elevation: 0,
                  side: BorderSide(color: Colors.green.shade300),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.handshake_outlined,
                  color: Colors.white,
                  size: 20,
                ),
                label: const Text(
                  'Thuê ngay',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quicksand',
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
