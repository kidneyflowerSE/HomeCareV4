import 'package:flutter/material.dart';
import 'package:foodapp/components/address_type.dart';
import 'package:foodapp/components/time_selection.dart';
import 'package:foodapp/data/model/CostFactor.dart';
import 'package:foodapp/data/model/request.dart';
import 'package:foodapp/pages/long_term_calendar_selection_page.dart';
import 'package:intl/intl.dart';

import '../../data/model/customer.dart';
import '../../data/model/location.dart';
import '../../data/repository/repository.dart';
import '../components/city_selected.dart';
import '../components/my_button.dart';
import '../data/model/service.dart';
import 'helper_list_page.dart';

class ServicesOrder extends StatefulWidget {
  final Customer customer;
  final Services service;
  final List<CostFactor> costFactors;
  final List<Services> services;

  const ServicesOrder(
      {super.key,
      required this.customer,
      required this.service,
      required this.costFactors,
      required this.services});

  @override
  State<ServicesOrder> createState() => _ServicesOrderState();
}

class _ServicesOrderState extends State<ServicesOrder>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Location> locations = [];
  List<Customer> customers = [];
  bool isLoading = true;
  String orderType = 'Ngắn hạn';
  DateTime? selectedDate;
  DateTime? startDate = DateTime.now().hour > 8
      ? DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .add(const Duration(days: 1))
      : DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime? endDate = DateTime.now().hour > 8
      ? DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .add(const Duration(days: 2))
      : DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
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
    print(widget.services);
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
          child: Text(
            'Dịch vụ: ${widget.services[0].title}',
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
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
                  orderType = 'Dài hạn';
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
            var now = DateTime.now();
            if (now.hour > 8) {
              selectedDate ??= now.add(Duration(days: 1));
            } else {
              selectedDate ??= DateTime.now();
            }
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
                requestType: orderType,
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
                request.endTime = DateTime(
                        selectedDate!.year,
                        selectedDate!.month,
                        selectedDate!.day,
                        _endTime!.hour,
                        _endTime!.minute)
                    .toIso8601String();
                print('End Time: ${request.endTime}');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HelperList(
                      customer: widget.customer,
                      request: request,
                      listDate: List.generate(1, (index) => startDate!),
                      isOnDemand: true,
                      costFactors: widget.costFactors,
                      services: widget.services,
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
                      costFactors: widget.costFactors,
                      services: widget.services,
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

// import 'package:flutter/material.dart';
// import 'package:foodapp/components/address_type.dart';
// import 'package:foodapp/components/time_selection.dart';
// import 'package:foodapp/data/model/CostFactor.dart';
// import 'package:foodapp/data/model/request.dart';
// import 'package:foodapp/pages/long_term_calendar_selection_page.dart';
// import 'package:intl/intl.dart';

// import '../../data/model/customer.dart';
// import '../../data/model/location.dart';
// import '../../data/repository/repository.dart';
// import '../components/city_selected.dart';
// import '../components/my_button.dart';
// import '../data/model/service.dart';
// import 'helper_list_page.dart';

// class ServicesOrder extends StatefulWidget {
//   final Customer customer;
//   final Services service;
//   final List<CostFactor> costFactors;
//   final List<Services> services;

//   const ServicesOrder({
//     super.key,
//     required this.customer,
//     required this.service,
//     required this.costFactors,
//     required this.services,
//   });

//   @override
//   State<ServicesOrder> createState() => _ServicesOrderState();
// }

// class _ServicesOrderState extends State<ServicesOrder>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   List<Location> locations = [];
//   List<Customer> customers = [];
//   bool isLoading = true;
//   String orderType = 'Ngắn hạn';
//   DateTime? selectedDate;
//   DateTime? startDate =
//       DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
//   DateTime? endDate =
//       DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
//           .add(const Duration(days: 1));
//   TimeOfDay? _startTime;
//   TimeOfDay? _endTime;
//   Location? selectedProvince;
//   String? selectedDistrict;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     loadData();
//   }

//   Future<void> loadData() async {
//     var repository = DefaultRepository();
//     var dataLocation = await repository.loadLocation();
//     var dataCustomer = await repository.loadCustomer();
//     setState(() {
//       locations = dataLocation ?? [];
//       customers = dataCustomer ?? [];
//       isLoading = false;
//     });
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   void _handleNextStep() {
//     selectedDate ??= DateTime.now();
//     DateTime? selectedEndDate = endDate ?? selectedDate;

//     if (_startTime != null && _endTime != null) {
//       var request = Requests(
//         customerInfo: CustomerInfo(
//           fullName: widget.customer.name,
//           phone: widget.customer.phone,
//           address: widget.customer.addresses[0].detailedAddress,
//           usedPoint: widget.customer.points[0].point,
//         ),
//         service: RequestService(
//           title: widget.service.title,
//           coefficientService: 0.0,
//           coefficientOther: 0.0,
//           cost: widget.service.basicPrice,
//         ),
//         location: selectedProvince != null
//             ? RequestLocation(
//                 province: selectedProvince!.name,
//                 district: selectedDistrict ?? '',
//               )
//             : RequestLocation(province: '', district: ''),
//         id: '',
//         oderDate: DateTime.now().toIso8601String(),
//         scheduleIds: [],
//         startDate: DateFormat('yyyy-MM-dd').format(selectedDate!),
//         startTime: DateTime(
//           selectedDate!.year,
//           selectedDate!.month,
//           selectedDate!.day,
//           _startTime!.hour,
//           _startTime!.minute,
//         ).toIso8601String(),
//         endTime: DateTime(
//           selectedEndDate!.year,
//           selectedEndDate.month,
//           selectedEndDate.day,
//           _endTime!.hour,
//           _endTime!.minute,
//         ).toIso8601String(),
//         requestType: orderType,
//         totalCost: 0,
//         status: 'chưa tiến hành',
//         deleted: false,
//         comment: Comment(review: '', loseThings: false, breakThings: false),
//         profit: 0,
//       );

//       if (_tabController.index == 0) {
//         request.endTime = DateTime(
//           selectedDate!.year,
//           selectedDate!.month,
//           selectedDate!.day,
//           _endTime!.hour,
//           _endTime!.minute,
//         ).toIso8601String();

//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => HelperList(
//               customer: widget.customer,
//               request: request,
//               listDate: List.generate(1, (index) => startDate!),
//               isOnDemand: true,
//               costFactors: widget.costFactors,
//               services: widget.services,
//             ),
//           ),
//         );
//       } else {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => CustomCalendar(
//               initialSelectedDates: List.generate(
//                 endDate!.difference(startDate!).inDays + 1,
//                 (index) => startDate!.add(Duration(days: index)),
//               ),
//               customer: widget.customer,
//               request: request,
//               maxDate: endDate,
//               minDate: startDate,
//               costFactors: widget.costFactors,
//               services: widget.services,
//             ),
//           ),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             expandedHeight: 110,
//             pinned: true,
//             floating: false,
//             backgroundColor: Colors.green,
//             flexibleSpace: FlexibleSpaceBar(
//               background: Container(
//                   decoration: const BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [Colors.green, Colors.lightGreen],
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                     ),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 46),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           // Chỗ này thay 0 theo index là được
//                           'Dịch vụ: ${widget.services[0].title}',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             fontFamily: 'Quicksand',
//                           ),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ],
//                     ),
//                   )),
//             ),
//             bottom: PreferredSize(
//               preferredSize: const Size.fromHeight(48),
//               child: Container(
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//                 ),
//                 child: TabBar(
//                   controller: _tabController,
//                   labelColor: Colors.green,
//                   unselectedLabelColor: Colors.black54,
//                   indicatorSize: TabBarIndicatorSize.tab,
//                   indicator: const UnderlineTabIndicator(
//                     borderSide: BorderSide(color: Colors.green, width: 3),
//                   ),
//                   tabs: const [
//                     Tab(text: 'Theo ngày'),
//                     Tab(text: 'Dài hạn'),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           SliverFillRemaining(
//             child: TabBarView(
//               controller: _tabController,
//               children: [
//                 ServiceOrderTab(
//                   isOnDemand: true,
//                   locations: locations,
//                   customers: customers,
//                   onTimeChanged: (startTime, endTime) {
//                     setState(() {
//                       _startTime = startTime;
//                       if (endTime == null && startTime != null) {
//                         _endTime = TimeOfDay(
//                           hour: _startTime!.hour + 2,
//                           minute: _startTime!.minute,
//                         );
//                       } else {
//                         _endTime = endTime;
//                       }
//                     });
//                   },
//                   onDateChanged: (date, isStartDate) {
//                     setState(() {
//                       if (isStartDate == 'start') {
//                         selectedDate = date;
//                         startDate = date;
//                         endDate = null;
//                       }
//                     });
//                   },
//                   onProvinceSelected: (Location province) {
//                     setState(() {
//                       selectedProvince = province;
//                     });
//                   },
//                   onDistrictSelected: (String district) {
//                     setState(() {
//                       selectedDistrict = district;
//                     });
//                   },
//                 ),
//                 ServiceOrderTab(
//                   isOnDemand: false,
//                   locations: locations,
//                   customers: customers,
//                   onTimeChanged: (startTime, endTime) {
//                     setState(() {
//                       _startTime = startTime;
//                       if (endTime == null && startTime != null) {
//                         _endTime = TimeOfDay(
//                           hour: _startTime!.hour + 2,
//                           minute: _startTime!.minute,
//                         );
//                       } else {
//                         _endTime = endTime;
//                       }
//                     });
//                   },
//                   onDateChanged: (date, isStartDate) {
//                     setState(() {
//                       if (isStartDate == 'start') {
//                         selectedDate = date;
//                         startDate = date;
//                       } else {
//                         endDate = date;
//                         orderType = 'Dài hạn';
//                       }
//                     });
//                   },
//                   onProvinceSelected: (Location province) {
//                     setState(() {
//                       selectedProvince = province;
//                     });
//                   },
//                   onDistrictSelected: (String district) {
//                     setState(() {
//                       selectedDistrict = district;
//                     });
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: ElevatedButton(
//             onPressed: _handleNextStep,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.green,
//               foregroundColor: Colors.white,
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//             child: const Text(
//               'Tiếp theo',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 fontFamily: 'Quicksand',
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ServiceOrderTab extends StatefulWidget {
//   final bool isOnDemand;
//   final List<Location> locations;
//   final List<Customer> customers;
//   final Function(TimeOfDay?, TimeOfDay?)? onTimeChanged;
//   final Function(Location)? onProvinceSelected;
//   final Function(String)? onDistrictSelected;
//   final Function(DateTime?, String?)? onDateChanged;

//   const ServiceOrderTab({
//     super.key,
//     required this.isOnDemand,
//     required this.locations,
//     required this.customers,
//     this.onTimeChanged,
//     this.onProvinceSelected,
//     this.onDistrictSelected,
//     this.onDateChanged,
//   });

//   @override
//   State<ServiceOrderTab> createState() => _ServiceOrderTabState();
// }

// class _ServiceOrderTabState extends State<ServiceOrderTab> {
//   Location? selectedProvince;
//   String? selectedDistrict;

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "Thời gian",
//               style: TextStyle(
//                 fontFamily: 'Quicksand',
//                 fontWeight: FontWeight.w600,
//                 fontSize: 18,
//               ),
//             ),
//             const SizedBox(height: 24),
//             Card(
//               elevation: 2,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: TimeSelection(
//                   onTimeChanged: widget.onTimeChanged,
//                   onDateChanged: widget.onDateChanged,
//                   isOnDemand: widget.isOnDemand,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 24),
//             const Text(
//               "Địa điểm",
//               style: TextStyle(
//                 fontFamily: 'Quicksand',
//                 fontWeight: FontWeight.w600,
//                 fontSize: 18,
//               ),
//             ),
//             const SizedBox(height: 12),
//             Card(
//               elevation: 2,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   children: [
//                     SelectLocation(
//                       locations: widget.locations,
//                       onProvinceSelected: (Location province) {
//                         setState(() {
//                           selectedProvince = province;
//                         });
//                         widget.onProvinceSelected?.call(province);
//                       },
//                       onDistrictSelected: (String district) {
//                         setState(() {
//                           selectedDistrict = district;
//                         });
//                         widget.onDistrictSelected?.call(district);
//                       },
//                     ),
//                     const SizedBox(height: 16),
//                     const AddressType(),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
