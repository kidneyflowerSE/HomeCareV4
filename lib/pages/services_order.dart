import 'package:flutter/material.dart';
import 'package:foodapp/components/address_type.dart';
import 'package:foodapp/components/delay_animation.dart';
import 'package:foodapp/components/district_selected.dart';
import 'package:foodapp/components/time_end.dart';
import 'package:foodapp/components/time_selection.dart';
import 'package:foodapp/data/model/request.dart';
import 'package:foodapp/pages/long_term_calendar_selection_page.dart';
import 'package:foodapp/pages/review_order_page.dart';
import 'package:intl/intl.dart';

import '../../data/model/customer.dart';
import '../../data/model/location.dart';
import '../../data/repository/repository.dart';
import '../components/calendar.dart';
import '../components/city_selected.dart';
import '../components/my_button.dart';
import '../components/time_start.dart';
import '../data/model/service.dart';
import 'helper_list_page.dart';

class ServicesOrder extends StatefulWidget {
  final Customer customer;
  final Services service;

  const ServicesOrder(
      {super.key, required this.customer, required this.service});

  @override
  State<ServicesOrder> createState() => _ServicesOrderState();
}

class _ServicesOrderState extends State<ServicesOrder>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Location> locations = [];
  List<Customer> customers = [];
  bool isLoading = true;
  DateTime? selectedDate;
  DateTime? startDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime? endDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .add(const Duration(days: 1));
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  Location? selectedProvince;
  String? selectedDistrict;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    loadData();
  }

  Future<void> loadData() async {
    var repository = DefaultRepository();
    var dataLocation = await repository.loadLocation();
    var dataCustomer = await repository.loadCustomer();
    setState(() {
      locations = dataLocation ?? [];
      customers = dataCustomer ?? [];
      isLoading = false;
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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: Colors.white,
        ),
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
          OnDemand(
            locations: locations,
            customers: customers,
            onTimeChanged: (startTime, endTime) {
              setState(() {
                _startTime = startTime;
                if (endTime == null && startTime != null) {
                  _endTime = TimeOfDay(
                      hour: _startTime!.hour + 2, minute: _startTime!.minute);
                } else {
                  _endTime = endTime;
                }
              });
            },
            onDateChanged: (date, isStartDate) {
              // Handle date changes
              setState(() {
                if (isStartDate == 'start') {
                  selectedDate = date;
                  startDate = date;
                  endDate = null;
                }
              });
            },
            onProvinceSelected: (Location province) {
              setState(() {
                selectedProvince = province;
              });
            },
            onDistrictSelected: (String district) {
              setState(() {
                selectedDistrict = district;
              });
            },
          ),
          LongTerm(
            locations: locations,
            customers: customers,
            onTimeChanged: (startTime, endTime) {
              setState(() {
                _startTime = startTime;
                if (endTime == null && startTime != null) {
                  _endTime = TimeOfDay(
                      hour: _startTime!.hour + 2, minute: _startTime!.minute);
                } else {
                  _endTime = endTime;
                }
              });
            },
            onDateChanged: (date, isStartDate) {
              // Handle date changes
              setState(() {
                if (isStartDate == 'start') {
                  selectedDate = date;
                  startDate = date;
                } else {
                  endDate = date;
                }
              });
            },
            onProvinceSelected: (Location province) {
              setState(() {
                selectedProvince = province;
              });
            },
            onDistrictSelected: (String district) {
              setState(() {
                selectedDistrict = district;
              });
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: MyButton(
          text: "Tiếp theo",
          onTap: () {
            selectedDate ??= DateTime.now();
            DateTime? selectedEndDate = endDate ?? selectedDate;
            if (_startTime != null && _endTime != null) {
              // Create a Request object
              var request = Requests(
                customerInfo: CustomerInfo(
                    fullName: widget.customer.name,
                    phone: widget.customer.phone,
                    address: widget.customer.addresses[0].detailedAddress,
                    usedPoint: widget.customer.points[0].point),
                service: RequestService(
                    title: widget.service.title,
                    coefficientService: 0.0,
                    coefficientOther: 0.0,
                    cost: widget.service.basicPrice),
                location: selectedProvince != null
                    ? RequestLocation(
                        province: selectedProvince!.name,
                        district: selectedDistrict ?? '',
                      )
                    : RequestLocation(province: '', district: ''),
                id: '',
                // Generate or provide an ID if required
                oderDate: DateTime.now().toIso8601String(),
                scheduleIds: [],
                // Add any schedule IDs if needed
                startDate: DateFormat('yyyy-MM-dd').format(DateTime(
                    selectedDate!.year,
                    selectedDate!.month,
                    selectedDate!.day)),
                startTime: DateTime(selectedDate!.year, selectedDate!.month,
                        selectedDate!.day, _startTime!.hour, _startTime!.minute)
                    .toIso8601String(),
                endTime: DateTime(selectedEndDate!.year, selectedEndDate.month,
                        selectedEndDate.day, _endTime!.hour, _endTime!.minute)
                    .toIso8601String(),
                requestType: 'ngắn hạn',
                // Set based on your application's logic
                totalCost: 0,
                // Calculate or set the total cost
                status: 'chưa tiến hành',
                // Set the initial status
                deleted: false,
                comment:
                    Comment(review: '', loseThings: false, breakThings: false),
                profit: 0, // Calculate or set profit if applicable
              );
              print('Request Information:');
              print('Customer Name: ${request.customerInfo.fullName}');
              print('Customer Phone: ${request.customerInfo.phone}');
              print('Customer Address: ${request.customerInfo.address}');
              print('Service Title: ${request.service.title}');
              print('Start Date: ${request.startDate}');
              print('Start Time: ${request.startTime}');
              print('End Time: ${request.endTime}');
              print(
                  'Location: ${request.location.province}, ${request.location.district}');
              print('Order Date: ${request.oderDate}');
              print('Request Type: ${request.requestType}');
              print('Total Cost: ${request.totalCost}');
              print('Status: ${request.status}');

              if (_tabController.index == 0) {
                request.endTime= DateTime(selectedDate!.year, selectedDate!.month,
                    selectedDate!.day, _endTime!.hour, _endTime!.minute)
                    .toIso8601String();
                print('End Time: ${request.endTime}');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HelperList(
                      customer: widget.customer,
                      request: request,
                      listDate: List.generate(1, (index) => startDate!), isOnDemand: true,
                    ),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CustomCalendar(
                      initialSelectedDates: List.generate(
                        endDate!.difference(startDate!).inDays + 1,
                        (index) => startDate!.add(Duration(days: index)),
                      ),
                      customer: widget.customer,
                      request: request,
                      maxDate: endDate,
                      minDate: startDate,
                      // minDate: DateTime(2025, 1, 2),
                      // maxDate: DateTime(2025, 1, 15),
                    ),
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }
}

class OnDemand extends StatefulWidget {
  final List<Location> locations;
  final List<Customer> customers;
  final Function(TimeOfDay?, TimeOfDay?)? onTimeChanged;
  final Function(Location)? onProvinceSelected;
  final Function(String)? onDistrictSelected;
  final Function(DateTime?, String?)? onDateChanged;

  const OnDemand(
      {super.key,
      required this.locations,
      required this.customers,
      this.onTimeChanged,
      this.onProvinceSelected,
      this.onDistrictSelected,
      this.onDateChanged});

  @override
  State<OnDemand> createState() => _OnDemandState();
}

class _OnDemandState extends State<OnDemand> {
  Location? selectedProvince;
  String? selectedDistrict;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Text(
            //   "Thời gian",
            //   style: TextStyle(
            //     fontFamily: 'Quicksand',
            //     fontWeight: FontWeight.w600,
            //     // color: Colors.green,
            //     fontSize: 16,
            //   ),
            // ),
            // const SizedBox(height: 5),
            // const SizedBox(height: 20),
            // const Text(
            //   "Giờ bắt đầu",
            //   style: TextStyle(
            //     fontFamily: 'Quicksand',
            //     fontWeight: FontWeight.w600,
            //     fontSize: 16,
            //   ),
            // ),
            TimeSelection(
              onTimeChanged: widget.onTimeChanged,
              onDateChanged: widget.onDateChanged,
              isOnDemand: true,
            ),
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
                      child: SelectLocation(
                        locations: widget.locations,
                        onProvinceSelected: (Location province) {
                          setState(() {
                            selectedProvince = province;
                          });
                          if (widget.onProvinceSelected != null) {
                            widget.onProvinceSelected!(
                                province); // Call callback to notify ServicesOrder
                          }
                        },
                        onDistrictSelected: (String district) {
                          setState(() {
                            selectedDistrict = district;
                            print('Selected District: $selectedDistrict');
                          });
                          if (widget.onDistrictSelected != null) {
                            widget.onDistrictSelected!(district);
                          }
                        },
                      ),
                    ),
                    // const SizedBox(width: 10), // Khoảng cách giữa 2 dropdown
                    // Expanded(
                    //   child: DistrictSelected(locations: widget.locations),
                    // ),
                  ],
                ),
                const SizedBox(height: 10),
                const AddressType(),
                const SizedBox(height: 20),
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
  final List<Customer> customers;
  final Function(TimeOfDay?, TimeOfDay?)? onTimeChanged;
  final Function(Location)? onProvinceSelected;
  final Function(String)? onDistrictSelected;
  final Function(DateTime?, String?)? onDateChanged;

  const LongTerm(
      {super.key,
      required this.locations,
      required this.customers,
      this.onTimeChanged,
      this.onProvinceSelected,
      this.onDistrictSelected,
      this.onDateChanged});

  @override
  State<LongTerm> createState() => _LongTermState();
}

class _LongTermState extends State<LongTerm> {
  Location? selectedProvince;
  String? selectedDistrict;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Text(
            //   "Thời gian",
            //   style: TextStyle(
            //     fontFamily: 'Quicksand',
            //     fontWeight: FontWeight.w600,
            //     // color: Colors.green,
            //     fontSize: 16,
            //   ),
            // ),
            // const SizedBox(height: 5),
            // const SizedBox(height: 20),
            // const Text(
            //   "Giờ bắt đầu",
            //   style: TextStyle(
            //     fontFamily: 'Quicksand',
            //     fontWeight: FontWeight.w600,
            //     fontSize: 16,
            //   ),
            // ),
            TimeSelection(
              onTimeChanged: widget.onTimeChanged,
              onDateChanged: widget.onDateChanged,
              isOnDemand: false,
            ),
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
                      child: SelectLocation(
                        locations: widget.locations,
                        onProvinceSelected: (Location province) {
                          setState(() {
                            selectedProvince = province;
                          });
                          if (widget.onProvinceSelected != null) {
                            widget.onProvinceSelected!(
                                province); // Call callback to notify ServicesOrder
                          }
                        },
                        onDistrictSelected: (String district) {
                          setState(() {
                            selectedDistrict = district;
                            print('Selected District: $selectedDistrict');
                          });
                          if (widget.onDistrictSelected != null) {
                            widget.onDistrictSelected!(district);
                          }
                        },
                      ),
                    ),
                    // const SizedBox(width: 10), // Khoảng cách giữa 2 dropdown
                    // Expanded(
                    //   child: DistrictSelected(locations: widget.locations),
                    // ),
                  ],
                ),
                const SizedBox(height: 10),
                const AddressType(),
                const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
