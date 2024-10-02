// import 'package:flutter/material.dart';
// import 'package:foodapp/components/calendar.dart';
// import 'package:foodapp/components/dropbox.dart';
// import 'package:foodapp/components/my_button.dart';
// import 'package:foodapp/components/time.dart';
// import 'package:foodapp/data/model/customer.dart';
// import 'package:foodapp/data/model/location.dart';
// import 'package:foodapp/data/repository/repository.dart';

// class OnDemand extends StatefulWidget {
//   final List<Location> locations;
//   const OnDemand({super.key, required this.locations});

//   @override
//   State<OnDemand> createState() => _OnDemandState();
// }

// class _OnDemandState extends State<OnDemand> {
//   List<Customer> customers = [];
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     loadCustomers();
//   }

//   Future<void> loadCustomers() async {
//     var repository = DefaultRepository();
//     var data = await repository.loadCustomer();
//     setState(() {
//       customers = data ?? [];
//       _isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_isLoading) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text("Chọn thời gian"),
//           const CalendarDropdown(),
//           const SizedBox(height: 20),
//           const Text("Chọn giờ bắt đầu"),
//           const TimeDropDown(),
//           const SizedBox(height: 20),
//           const Text("Chọn giờ kết thúc"),
//           const TimeDropDown(),
//           const SizedBox(height: 20),
//           const Text("Chọn địa điểm"),
//           DropBox(locations: widget.locations),
//           const SizedBox(height: 20),
//           const MyButton(text: 'Tiếp theo', onTap: null),
//         ],
//       ),
//     );
//   }
// }

// class LongTerm extends StatefulWidget {
//   final List<Location> locations;
//   const LongTerm({super.key, required this.locations});

//   @override
//   State<LongTerm> createState() => _LongTermState();
// }

// class _LongTermState extends State<LongTerm> {
//   List<Customer> customers = [];
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     loadCustomers();
//   }

//   Future<void> loadCustomers() async {
//     var repository = DefaultRepository();
//     var data = await repository.loadCustomer();
//     setState(() {
//       customers = data ?? [];
//       _isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_isLoading) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text("Chọn thời gian"),
//           const CalendarDropdown(),
//           const SizedBox(height: 20),
//           const Text("Chọn giờ bắt đầu"),
//           const TimeDropDown(),
//           const SizedBox(height: 20),
//           const Text("Chọn giờ kết thúc"),
//           const TimeDropDown(),
//           const SizedBox(height: 20),
//           const Text("Chọn địa điểm"),
//           DropBox(locations: widget.locations),
//           const SizedBox(height: 20),
//           const MyButton(text: 'Tiếp theo', onTap: null),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:foodapp/components/address_type.dart';
import 'package:foodapp/components/district_selected.dart';
import 'package:foodapp/components/time_end.dart';
import 'package:foodapp/pages/chosen_helper.dart';
import 'package:foodapp/pages/review_order_page.dart';

import '../../data/model/customer.dart';
import '../../data/model/location.dart';
import '../../data/repository/repository.dart';
import '../components/calendar.dart';
import '../components/city_selected.dart';
import '../components/my_button.dart';
import '../components/time_start.dart';

class ServicesOrder extends StatefulWidget {
  const ServicesOrder({super.key});

  @override
  State<ServicesOrder> createState() => _ServicesOrderState();
}

class _ServicesOrderState extends State<ServicesOrder>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Location> locations = []; // Khởi tạo danh sách địa điểm

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    loadLocations(); // Tải dữ liệu locations khi khởi tạo
  }

  Future<void> loadLocations() async {
    var repository = DefaultRepository();
    var dataLocation = await repository.loadLocation();
    setState(() {
      locations = dataLocation ?? []; // Gán danh sách địa điểm tải được
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Đặt người giúp việc',
                style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  height: 28,
                  width: 80,
                  alignment: Alignment.center,
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Lịch sử",
                        style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.history_toggle_off_rounded,
                        size: 14,
                      ),
                    ],
                  )),
            ],
          ),
        ),
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
          OnDemand(locations: locations),
          LongTerm(locations: locations),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: MyButton(
          text: "Tiếp theo",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ReviewOrderPage()),
            );
          },
        ),
      ),
    );
  }
}

class OnDemand extends StatefulWidget {
  final List<Location> locations;
  const OnDemand({super.key, required this.locations});

  @override
  State<OnDemand> createState() => _OnDemandState();
}

class _OnDemandState extends State<OnDemand> {
  List<Customer> customers = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadCustomers();
  }

  Future<void> loadCustomers() async {
    var repository = DefaultRepository();
    var data = await repository.loadCustomer();
    setState(() {
      customers = data ?? [];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Thời gian",
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w600,
                // color: Colors.green,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 5),
            const CalendarDropdown(),
            const SizedBox(height: 20),
            const Text(
              "Giờ bắt đầu",
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 5),
            const TimeStart(),
            const SizedBox(height: 20),
            const Text(
              "Giờ kết thúc",
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w600,
                fontSize: 16,
                // color: Colors.green,
              ),
            ),
            const SizedBox(height: 5),
            const TimeEnd(),
            const SizedBox(height: 20),
            const Text(
              "Địa điểm",
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w600,
                // color: Colors.green,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 5),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CitySelected(locations: widget.locations),
                    ),
                    const SizedBox(width: 10), // Khoảng cách giữa 2 dropdown
                    Expanded(
                      child: DistrictSelected(locations: widget.locations),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const AddressType(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LongTerm extends StatefulWidget {
  final List<Location> locations;
  const LongTerm({super.key, required this.locations});

  @override
  State<LongTerm> createState() => _LongTermState();
}

class _LongTermState extends State<LongTerm> {
  List<Customer> customers = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadCustomers();
  }

  Future<void> loadCustomers() async {
    var repository = DefaultRepository();
    var data = await repository.loadCustomer();
    setState(() {
      customers = data ?? [];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Chọn thời gian"),
            const CalendarDropdown(),
            const SizedBox(height: 20),
            const Text("Chọn giờ bắt đầu"),
            const TimeStart(),
            const SizedBox(height: 20),
            const Text("Chọn giờ kết thúc"),
            const TimeEnd(),
            const SizedBox(height: 20),
            const Text("Chọn địa điểm"),
            CitySelected(locations: widget.locations),
            DistrictSelected(locations: widget.locations),
            const SizedBox(height: 20),
            const Text("Chọn người giúp việc"),
            const ChosenHelper(),
            const SizedBox(height: 20),
            const MyButton(text: 'Tiếp theo', onTap: null),
          ],
        ),
      ),
    );
  }
}
