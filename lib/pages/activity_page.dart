import 'package:flutter/material.dart';
import 'package:foodapp/data/model/request.dart';
import 'package:foodapp/pages/order_detail_page.dart';
import 'package:intl/intl.dart';

class ActivityPage extends StatefulWidget {
  final List<Requests> requests;

  const ActivityPage({super.key, required this.requests});

  @override
  State<ActivityPage> createState() => _ServicesOrderState();
}

class _ServicesOrderState extends State<ActivityPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // final List<Widget> servicesPage = [const OnDemand(), const LongTerm()];

  // int _selectedIndex = 0;

  void _selectedTabIndex(int index) {
    setState(() {
      // _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      _selectedTabIndex(_tabController.index);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 206, 205, 205),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green,
        title: const Text(
          'Hoạt động',
          style: TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.green,
              unselectedLabelColor: Colors.black,
              // indicatorColor: const Color.fromARGB(255, 0, 248, 62),
              // indicatorWeight: 2.0,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(color: Colors.green, width: 2),
              ),
              tabs: const [
                Tab(
                  text: 'Theo ngày',
                ),
                Tab(
                  text: 'Dài hạn',
                ),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          OnDemand(
            requests: widget.requests,
          ),
          LongTerm(),
        ],
      ),
    );
  }
}

class OnDemand extends StatefulWidget {
  final List<Requests> requests;

  const OnDemand({super.key, required this.requests});

  @override
  State<OnDemand> createState() => _OnDemandState();
}

class _OnDemandState extends State<OnDemand> {
  Map<String, List<Requests>> groupedRequests = {};

  @override
  void initState() {
    super.initState();
    // Nhóm các requests theo ngày
    for (var request in widget.requests) {
      String date = DateFormat('dd-MM-yyyy').format(DateTime.parse(request.oderDate));
      if (groupedRequests.containsKey(date)) {
        groupedRequests[date]!.add(request);
      } else {
        groupedRequests[date] = [request];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFf1f2f4),
      child: ListView(
        children: groupedRequests.entries.map((entry) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hiển thị ngày một lần cho mỗi nhóm
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Text(
                  entry.key,
                  style: const TextStyle(
                    fontFamily: 'Quicksand',
                    color: Color(0xFF5b6366),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Hiển thị các requests trong cùng ngày
              ...entry.value.map((request) {
                return Container(
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              DateFormat('HH:mm, dd/MM').format(DateTime.parse(request.oderDate)),
                              style: const TextStyle(
                                fontFamily: 'Quicksand',
                                color: Color(0xFF5b6366),
                                fontSize: 15,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xFFe5fedf),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: Text(
                                  request.status,
                                  style: const TextStyle(
                                    fontFamily: 'Quicksand',
                                    color: Color(0xFF2fa559),
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Hiển thị thông tin chi tiết của request
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'lib/images/services/clean.png',
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.circle,
                                        size: 16,
                                        color: Colors.green,
                                      ),
                                      const SizedBox(width: 5),
                                      Expanded(
                                        child: Text(
                                          request.service.title,
                                          style: const TextStyle(
                                            fontFamily: 'Quicksand',
                                            fontSize: 16,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on_rounded,
                                        size: 18,
                                        color: Colors.red,
                                      ),
                                      const SizedBox(width: 5),
                                      Expanded(
                                        child: Text(
                                          request.customerInfo.address,
                                          style: const TextStyle(
                                            fontFamily: 'Quicksand',
                                            fontSize: 16,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                request.totalCost.toString(),
                                style: const TextStyle(
                                  fontFamily: 'Quicksand',
                                  fontSize: 16,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (context, animation, secondaryAnimation) =>
                                    OrderDetailPage(request: request,),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      const begin = Offset(1.0, 0.0);
                                      const end = Offset.zero;
                                      const curve = Curves.easeInOut;

                                      var tween = Tween(begin: begin, end: end)
                                          .chain(CurveTween(curve: curve));
                                      var offsetAnimation = animation.drive(tween);

                                      return SlideTransition(
                                        position: offsetAnimation,
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              },
                              child: const Row(
                                children: [
                                  Text(
                                    "Chi tiết",
                                    style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFe7e7e7),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 6),
                                    child: Text(
                                      "Đặt dài hạn",
                                      style: TextStyle(
                                        fontFamily: 'Quicksand',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 6),
                                    child: Text(
                                      "Đặt lại",
                                      style: TextStyle(
                                        fontFamily: 'Quicksand',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }).toList(),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class LongTerm extends StatefulWidget {
  const LongTerm({super.key});

  @override
  State<LongTerm> createState() => _LongTermState();
}

class _LongTermState extends State<LongTerm> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Dài hạn"),
    );
  }
}
