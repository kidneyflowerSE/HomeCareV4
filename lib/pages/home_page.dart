import 'package:flutter/material.dart';
import 'package:foodapp/components/service_list_menu.dart';
import 'package:foodapp/components/user_header.dart';
import 'package:foodapp/pages/activity_page.dart';
import 'package:foodapp/pages/choose_location_page.dart';
import 'package:foodapp/pages/notification_page.dart';
import 'package:foodapp/pages/profile_page.dart';
import 'package:foodapp/pages/services_order.dart';
import '../../data/model/customer.dart';
import '../data/model/request.dart';
import '../data/model/service.dart';

class HomePage extends StatefulWidget {
  final dynamic customer;
  final List<Services>? services;
  final List<Requests>? requests;

  const HomePage({super.key, this.customer, this.services, this.requests});

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
        services: widget.services!,
      ),
      ActivityPage(
        customer: widget.customer,
      ),
      const NotificationPage(),
      const ProfilePage(),
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
      body: _pages[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ServicesOrder(
                customer: widget.customer,
                service: widget.services![0],
              ),
            ),
          );
        },
        shape: const CircleBorder(),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 4,
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Colors.green.shade400, Colors.green.shade700],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Icon(Icons.add, size: 30, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 12,
          elevation: 0,
          child: Container(
            height: 65,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                    child: _buildNavButton(
                        0, Icons.dashboard_rounded, "Trang chủ")),
                Flexible(
                    child: _buildNavButton(
                        1, Icons.calendar_month_rounded, "Hoạt động")),
                const SizedBox(width: 48),
                Flexible(
                    child: _buildNavButton(
                        2, Icons.notifications_rounded, "Thông báo")),
                Flexible(
                    child: _buildNavButton(3, Icons.person_rounded, "Cá nhân")),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavButton(int index, IconData icon, String label) {
    final isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () => setState(() => _selectedIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24,
              color: isSelected ? Colors.green : Colors.grey.shade600,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 8,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? Colors.green : Colors.grey.shade600,
                fontFamily: 'Quicksand',
              ),
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

  const HomeContent({
    super.key,
    required this.customer,
    required this.services,
  });

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  bool _isLoading = true;
  dynamic index = 0;

  @override
  void initState() {
    super.initState();
    _isLoading = false;
  }

  List<String> appBanner = [
    'lib/images/banner_1.png',
    'lib/images/banner_2.png',
    'lib/images/banner_3.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Chào buổi tối, ${widget.customer.name}',
          style: const TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 20,
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLocationSection(),
                    const SizedBox(height: 24),
                    _buildWalletCard(),
                    const SizedBox(height: 32),
                    _buildServicesSection(),
                  ],
                ),
              ),
            ),
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
                // Handle view all services
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
          ),
        ),
      ],
    );
  }
}
