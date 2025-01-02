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
        requests: widget.requests,
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

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.75,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Đặt người giúp việc ngay',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Quicksand',
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                  'This is a pop-up message. You can add more content here.'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Đóng hộp thoại
                },
                child: const Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
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
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(child: _buildNavButton(0, Icons.dashboard, "Trang chủ")),
              Flexible(
                  child: _buildNavButton(1, Icons.calendar_month, "Hoạt động")),
              const SizedBox(width: 48),
              Flexible(
                  child: _buildNavButton(2, Icons.notifications, "Thông báo")),
              Flexible(child: _buildNavButton(3, Icons.person, "Cá nhân")),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavButton(int index, IconData icon, String label) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: _selectedIndex == index ? Colors.green : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              color: _selectedIndex == index ? Colors.green : Colors.grey,
            ),
          ),
        ],
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
        title: Text(
          'Chào buổi tối, ${widget.customer.name}',
          style: const TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 18,
            color: Colors.green,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final selectedIndex = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChooseLocationPage(
                                      customer: widget.customer)),
                            );
                            if (selectedIndex != null) {
                              setState(() {
                                index = selectedIndex;
                              });
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  widget.customer.addresses[index].toString(),
                                  style: const TextStyle(
                                    fontFamily: 'Quicksand',
                                    color: Colors.green,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const Icon(
                                Icons.location_on,
                                color: Colors.green,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 102,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.white,
                                border: Border.all(
                                  width: 1,
                                  color:
                                      const Color.fromARGB(255, 203, 203, 203),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: 50,
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(16),
                                          topRight: Radius.circular(16)),
                                      border: Border(
                                        bottom: BorderSide(
                                          width: 1,
                                          color: Color.fromARGB(
                                              255, 203, 203, 203),
                                        ),
                                      ),
                                    ),
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(10),
                                      child: const Text(
                                        'HomeCare - Cho cuộc sống tiện lợi hơn!',
                                        style: TextStyle(
                                          fontFamily: 'Quicksand',
                                          color: Colors.green,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(9)),
                                              border: Border(
                                                right: BorderSide(
                                                  width: 1,
                                                  color: Color.fromARGB(
                                                      255, 203, 203, 203),
                                                ),
                                              ),
                                            ),
                                            padding: const EdgeInsets.all(10),
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Icon(Icons.money_rounded),
                                                Text(
                                                  '500.000 đ',
                                                  style: TextStyle(
                                                    fontFamily: 'Quicksand',
                                                  ),
                                                ),
                                                Icon(Icons
                                                    .arrow_forward_ios_rounded),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Icon(Icons.money_rounded),
                                                Text(
                                                  '5.000 hcPoints',
                                                  style: TextStyle(
                                                    fontFamily: 'Quicksand',
                                                  ),
                                                ),
                                                Icon(Icons
                                                    .arrow_forward_ios_rounded),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Dịch vụ",
                                  style: TextStyle(
                                    fontFamily: 'Quicksand',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "Xem tất cả",
                                  style: TextStyle(
                                    fontFamily: 'Quicksand',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 300,
                              child: ServiceListMenu(
                                customer: widget.customer,
                                services: widget.services,
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

// class _MyPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
//   final Customer customer;

//   _MyPersistentHeaderDelegate(this.customer);

//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return UserHeader(customer: customer);
//   }

//   @override
//   double get maxExtent => 100.0; // Chiều cao tối đa của header

//   @override
//   double get minExtent => 100.0; // Chiều cao tối thiểu của header

//   @override
//   bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
//     return false;
//   }
// }
