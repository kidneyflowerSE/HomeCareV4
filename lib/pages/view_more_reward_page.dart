import 'package:flutter/material.dart';

class ViewMoreRewardsPage extends StatelessWidget {
  final List<Map<String, dynamic>> allRewards = [
    {
      'image': 'lib/images/logo.png',
      'title': 'Voucher 20% cho đơn 250.000đ tại Julyhouse',
      'brand': 'Julyhouse',
      'points': 60,
    },
    {
      'image': 'lib/images/logo.png',
      'title': 'Giảm 30,000VND khi đặt lịch Vệ sinh Sofa, Đệm',
      'brand': 'bTaskee',
      'points': 150,
    },
    {
      'image': 'lib/images/logo.png',
      'title': 'Ưu đãi 30K khi đặt dịch vụ Vệ sinh máy giặt',
      'brand': 'bTaskee',
      'points': 150,
    },
    {
      'image': 'lib/images/logo.png',
      'title': 'Ưu đãi 30K khi đặt dịch vụ Vệ sinh máy lạnh',
      'brand': 'bTaskee',
      'points': 150,
    },
    {
      'image': 'lib/images/logo.png',
      'title': 'Giảm giá 100,000 VND cho tất cả dịch vụ',
      'brand': 'bTaskee',
      'points': 550,
    },
    {
      'image': 'lib/images/logo.png',
      'title': 'Giảm giá 50,000 VND cho tất cả dịch vụ',
      'brand': 'bTaskee',
      'points': 270,
    },
    {
      'image': 'lib/images/logo.png',
      'title': 'Giảm giá 30,000 VND cho dịch vụ vệ sinh nhà',
      'brand': 'bTaskee',
      'points': 150,
    },
  ];

  final String pageTitle;

  ViewMoreRewardsPage({this.pageTitle = 'Đề xuất cho bạn'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          pageTitle,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Quicksand',
          ),
        ),
        backgroundColor: Colors.green,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: allRewards.length,
        separatorBuilder: (context, index) =>
            const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
        itemBuilder: (context, index) {
          final reward = allRewards[index];
          return _buildRewardListItem(reward);
        },
      ),
    );
  }

  Widget _buildRewardListItem(Map<String, dynamic> reward) {
    return Container(
      color: Colors.white,
      child: InkWell(
        onTap: () {},
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 140,
              height: 140,
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(reward['image']),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          reward['title'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          reward['brand'],
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 36),
                    Row(
                      children: [
                        Icon(
                          Icons.stars,
                          color: Colors.amber[400],
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${reward['points']}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
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
      ),
    );
  }
}

// Modifier extension for the main page
// extension RewardsPageExtension on RewardsPage {
//   void navigateToViewMorePage(BuildContext context, String title) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => ViewMoreRewardsPage(pageTitle: title),
//       ),
//     );
//   }
// }

// Add this method to the previous RewardsPage class
// This should be added to the RewardsPage class from the previous implementation
/*
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
                  color: Colors.black87,
                ),
              ),
              GestureDetector(
                onTap: () => navigateToViewMorePage(context, title),
                child: Text(
                  viewMoreText,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.green[400],
                  ),
                ),
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
*/
