import 'package:flutter/material.dart';
import 'package:foodapp/pages/reward_detail_page.dart';
import 'package:foodapp/pages/view_more_reward_page.dart';

class AllRewardsPage extends StatefulWidget {
  AllRewardsPage({super.key});

  @override
  State<AllRewardsPage> createState() => _AllRewardsPageState();
}

class _AllRewardsPageState extends State<AllRewardsPage> {
  final List<Map<String, dynamic>> suggestedRewards = [
    {
      'image': 'lib/images/logo.png',
      'title': 'Voucher 20% cho đơn 250.000đ tại Julyhouse',
      'brand': 'Julyhouse',
      'points': 60,
    },
    {
      'image': 'lib/images/logo.png',
      'title': 'Giảm 30% cho dịch vụ vệ sinh',
      'brand': 'bTaskee',
      'points': 150,
    },
  ];

  final List<Map<String, dynamic>> exclusiveRewards = [
    {
      'image': 'lib/images/logo.png',
      'title': 'Voucher 100.000đ mua nội thất tại Make My Home',
      'brand': 'Make My Home',
      'points': 100,
    },
    {
      'image': 'lib/images/logo.png',
      'title': 'Voucher 20% cho đơn 250.000đ tại Julyhouse',
      'brand': 'Julyhouse',
      'points': 60,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'hCRewards',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Member card
            Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                // color: Colors.white,
                gradient: LinearGradient(
                  colors: [Colors.green.shade600, Colors.green.shade800],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
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
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    child: const Text(
                      'Thành viên hạng kim cương',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Quicksand',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Divider(height: 1, color: Colors.grey[200]),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50)),
                                child: Icon(
                                  Icons.stars,
                                  color: Colors.amber[400],
                                  size: 26,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Điểm của bạn',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Quicksand',
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '0',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      fontFamily: 'Quicksand',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 80,
                        color: Colors.grey[200],
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50)),
                                child: Icon(
                                  Icons.card_giftcard,
                                  color: Colors.amber[400],
                                  size: 26,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Ưu đãi của tôi',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Quicksand',
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '0',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      fontFamily: 'Quicksand',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Category buttons
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal, // Lướt ngang
                child: Row(
                  children: [
                    _buildCategoryButton(
                      icon: Icons.grid_view,
                      label: 'Tất cả',
                    ),
                    const SizedBox(width: 12),
                    _buildCategoryButton(
                      icon: Icons.checkroom,
                      label: 'Thời trang',
                    ),
                    const SizedBox(width: 12),
                    _buildCategoryButton(
                      icon: Icons.spa,
                      label: 'Làm đẹp',
                    ),
                    const SizedBox(width: 12),
                    _buildCategoryButton(
                      icon: Icons.fastfood,
                      label: 'Ăn uống',
                    ),
                    const SizedBox(width: 12),
                    _buildCategoryButton(
                      icon: Icons.home_work_outlined,
                      label: 'Nhà cửa',
                    ),
                    const SizedBox(width: 12),
                    _buildCategoryButton(
                      icon: Icons.local_hospital,
                      label: 'Sức khỏe',
                    ),
                    const SizedBox(width: 12),
                  ],
                ),
              ),
            ),

            // Suggested rewards
            _buildRewardSection(
              title: 'Đề xuất cho bạn',
              viewMoreText: 'Xem thêm',
              rewards: suggestedRewards,
            ),

            // Exclusive rewards
            _buildRewardSection(
              title: 'Ưu đãi độc quyền',
              viewMoreText: 'Xem thêm',
              rewards: exclusiveRewards,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButton({required IconData icon, required String label}) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey[300]!),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18, color: Colors.grey[700]),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[800],
              fontWeight: FontWeight.w500,
              fontFamily: 'Quicksand',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardSection({
    required String title,
    required String viewMoreText,
    required List<Map<String, dynamic>> rewards,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quicksand',
                    color: Colors.black87,
                  ),
                ),
                TextButton(
                  child: Text(
                    viewMoreText,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Quicksand',
                      color: Colors.green[400],
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewMoreRewardsPage(
                          pageTitle: title,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 280,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: rewards.length,
              itemBuilder: (context, index) {
                return _buildRewardCard(rewards[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardCard(Map<String, dynamic> reward) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RewardDetailPage(),
          ),
        );
      },
      child: Container(
        width: 280,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.asset(
                reward['image'],
                width: double.infinity,
                height: 160,
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reward['title'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    reward['brand'],
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Quicksand',
                      color: Colors.green[500],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.stars,
                        color: Colors.amber[400],
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${reward['points']}',
                        style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[500],
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
    );
  }
}
