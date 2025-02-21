import 'dart:async';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/components/feature_helper_list.dart';
import 'package:foodapp/components/service_list_menu.dart';
import 'package:foodapp/data/model/CostFactor.dart';
import 'package:foodapp/pages/activity_page.dart';
import 'package:foodapp/pages/all_reward_page.dart';
import 'package:foodapp/pages/all_service_page.dart';
import 'package:foodapp/pages/choose_location_page.dart';
import 'package:foodapp/pages/notification_page.dart';
import 'package:foodapp/pages/profile_page.dart';
import 'package:foodapp/pages/services_order.dart';
import '../../data/model/customer.dart';
import '../data/model/request.dart';
import '../data/model/service.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomePage extends StatefulWidget {
  final dynamic customer;
  final List<Services> services;
  final List<Requests>? requests;
  final List<Map<String, String>> featuredStaff;
  final List<CostFactor> costFactor;

  const HomePage({
    super.key,
    this.customer,
    required this.services,
    this.requests,
    required this.featuredStaff,
    required this.costFactor,
  });

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      HomeContent(
        customer: widget.customer,
        services: widget.services,
        featuredStaff: widget.featuredStaff,
        costFactors: widget.costFactor,
      ),
      ActivityPage(
        customer: widget.customer,
      ),
      NotificationPage(),
      ProfilePage(customer: widget.customer),
    ]);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex.clamp(0, _pages.length - 1)],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SalomonBottomBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          curve: Curves.easeInOut,
          items: [
            SalomonBottomBarItem(
              icon: const Icon(Icons.dashboard_rounded),
              title: const Text("Trang chủ"),
              selectedColor: Colors.green,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.calendar_month_rounded),
              title: const Text("Hoạt động"),
              selectedColor: Colors.blue,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.notifications_rounded),
              title: const Text("Thông báo"),
              selectedColor: Colors.orange,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.person_rounded),
              title: const Text("Cá nhân"),
              selectedColor: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  final Customer customer;
  final List<Services> services;
  final List<CostFactor> costFactors;
  final List<Map<String, String>> featuredStaff;

  const HomeContent({
    super.key,
    required this.customer,
    required this.services,
    required this.featuredStaff,
    required this.costFactors,
  });

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  bool _isLoading = true;
  dynamic index = 0;
  final PageController _bannerController = PageController();
  Timer? _bannerTimer;
  int _currentBannerPage = 0;

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    _startBannerTimer();
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    _bannerController.dispose();
    super.dispose();
  }

  List<String> bannerImages = [
    'lib/images/banner_1.png',
    'lib/images/banner_2.png',
    'lib/images/banner_3.png',
  ];

  void _startBannerTimer() {
    _bannerTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentBannerPage < bannerImages.length - 1) {
        _currentBannerPage++;
      } else {
        _currentBannerPage = 0;
      }

      if (_bannerController.hasClients) {
        _bannerController.animateToPage(
          _currentBannerPage,
          duration: const Duration(seconds: 1),
          curve: Curves.easeIn,
        );
      }
    });
  }

  String getGreetingMessage() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Chào buổi sáng,';
    } else if (hour < 18) {
      return 'Chào buổi chiều,';
    } else {
      return 'Chào buổi tối,';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green.shade500, Colors.green.shade700],
              begin: Alignment.topCenter,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        toolbarHeight: 60,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              getGreetingMessage(),
              style: const TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.customer.name,
              style: const TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const SizedBox(height: 20),
                    // _buildLocationSection(),
                    const SizedBox(height: 16),
                    _buildWalletCard(),
                    const SizedBox(height: 16),
                    _buildBannerSection(),
                    // FeaturedStaffList(staff: widget.featuredStaff),
                    // const SizedBox(height: 16),
                    _buildServicesSection(),
                    const SizedBox(height: 16),
                    _buildRewardSection(context),
                    const SizedBox(height: 16),
                    _buildPromotionSection(context),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildRewardSection(BuildContext context) {
    final List<Map<String, String>> rewards = [
      {
        'image': 'lib/images/logo.png',
        'title': 'Voucher giảm 50K',
        'points': '1,000 điểm',
      },
      {
        'image': 'lib/images/logo.png',
        'title': 'Tặng 1 ly trà sữa',
        'points': '800 điểm',
      },
      {
        'image': 'lib/images/logo.png',
        'title': 'Mã giảm giá 20%',
        'points': '1,500 điểm',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'hCRewards',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                fontFamily: 'Quicksand',
              ),
            ),
            TextButton(
              onPressed: () {
                // Xử lý khi nhấn vào xem tất cả
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllRewardsPage(),
                  ),
                );
              },
              child: Text(
                'Xem tất cả',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.green.shade700,
                  fontFamily: 'Quicksand',
                ),
              ),
            ),
          ],
        ),
        CarouselSlider(
          options: CarouselOptions(
            height: 180,
            autoPlay: true,
            enlargeCenterPage: false,
            aspectRatio: 16 / 9,
            viewportFraction: 0.8,
            padEnds: false,
          ),
          items: rewards.map((reward) {
            return Builder(
              builder: (BuildContext context) {
                return InkWell(
                  onTap: () {
                    // Xử lý khi nhấn vào đổi thưởng
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey.shade200,
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
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
                            reward['image']!,
                            width: double.infinity,
                            height: 100,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            reward['title']!,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                              fontFamily: 'Quicksand',
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            reward['points']!,
                            style: const TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPromotionSection(BuildContext context) {
    final List<Map<String, String>> promotions = [
      {
        'image': 'lib/images/logo.png',
        'title': '800K discount with VPBank Credit',
        'brand': 'VNPay',
        'cta': 'Open now',
      },
      {
        'image': 'lib/images/logo.png',
        'title': 'Discount upto 50K',
        'brand': 'hCarePay Later',
        'cta': 'Explore now',
      },
      {
        'image': 'lib/images/logo.png',
        'title': 'Discount up to 75K',
        'brand': 'hCareClean',
        'cta': 'Explore now',
      },
      {
        'image': 'lib/images/logo.png',
        'title': 'Sun Life give beVoucher 300K',
        'brand': 'Sun Life',
        'cta': 'Book now',
      },
      {
        'image': 'lib/images/logo.png',
        'title': 'Flight tickets discount up to 100K',
        'brand': 'Service',
        'cta': 'Book now',
      },
      {
        'image': 'lib/images/logo.png',
        'title': 'Long-distance trip discount 50K',
        'brand': 'hCare',
        'cta': 'Book now',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
          child: Text(
            'Khám phá ưu đãi mới',
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Hiển thị 2 thẻ trên mỗi hàng
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.8,
          ),
          itemCount: promotions.length,
          itemBuilder: (context, index) {
            final promo = promotions[index];
            return _buildPromotionCard(promo);
          },
        ),
      ],
    );
  }

  Widget _buildPromotionCard(Map<String, String> promo) {
    return InkWell(
      onTap: () {
        // Xử lý khi nhấn vào thẻ khuyến mãi
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
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
                promo['image']!,
                width: double.infinity,
                height: 100,
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                promo['title']!,
                style: const TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                promo['brand']!,
                style: const TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBannerSection() {
    return Column(
      children: [
        Container(
          height: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: PageView.builder(
            controller: _bannerController,
            onPageChanged: (index) {
              setState(() {
                _currentBannerPage = index;
              });
            },
            itemCount: bannerImages.length,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    Image.asset(
                      bannerImages[index],
                      width: double.infinity,
                      height: 160,
                      fit: BoxFit.cover,
                    ),
                    // Gradient overlay để làm rõ dot indicators
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.3),
                          ],
                          stops: const [0.7, 1.0],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        // Dot indicators - Đặt bên ngoài ảnh
        const SizedBox(height: 8), // Khoảng cách giữa ảnh và dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            bannerImages.length,
            (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentBannerPage == index
                    ? const Color.fromARGB(255, 92, 205, 27)
                    : const Color.fromARGB(255, 3, 106, 34).withOpacity(0.5),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLocationSection() {
    return GestureDetector(
      onTap: () async {
        final selectedIndex = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChooseLocationPage(customer: widget.customer),
          ),
        );
        if (selectedIndex != null) {
          setState(() => index = selectedIndex);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(Icons.location_on_rounded, color: Colors.green),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                widget.customer.addresses[index].toString(),
                style: const TextStyle(
                  fontFamily: 'Quicksand',
                  color: Colors.green,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(Icons.keyboard_arrow_right_rounded, color: Colors.green),
          ],
        ),
      ),
    );
  }

  Widget _buildWalletCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [Colors.green.shade500, Colors.green.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            child: const Text(
              'HomeCare - Cho cuộc sống tiện lợi hơn!',
              style: TextStyle(
                fontFamily: 'Quicksand',
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: _buildWalletItem(
                    icon: Icons.account_balance_wallet_rounded,
                    value: '500.000 đ',
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.white.withOpacity(0.3),
                ),
                Expanded(
                  child: _buildWalletItem(
                    icon: Icons.stars_rounded,
                    value: '5.000 hcPoints',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWalletItem({required IconData icon, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(width: 8),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Quicksand',
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildServicesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Dịch vụ",
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllServicesPage(
                      services: widget.services,
                      costFactors: widget.costFactors,
                      customer: widget.customer,
                    ),
                  ),
                );
              },
              child: Text(
                "Xem tất cả",
                style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.green.shade700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 300,
          child: ServiceListMenu(
            customer: widget.customer,
            services: widget.services,
            costFactors: widget.costFactors,
          ),
        ),
      ],
    );
  }
}
