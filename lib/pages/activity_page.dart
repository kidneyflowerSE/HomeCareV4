import 'package:flutter/material.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ServicesOrderState();
}

class _ServicesOrderState extends State<ActivityPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Widget> servicesPage = [const OnDemand(), const LongTerm()];

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
        children: const [
          OnDemand(),
          LongTerm(),
        ],
      ),
    );
  }
}

class OnDemand extends StatefulWidget {
  const OnDemand({super.key});

  @override
  State<OnDemand> createState() => _OnDemandState();
}

class _OnDemandState extends State<OnDemand> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Dài hạn"),
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
