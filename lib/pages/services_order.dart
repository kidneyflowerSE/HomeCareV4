import 'package:flutter/material.dart';
import 'package:foodapp/components/address_type.dart';
import 'package:foodapp/components/time_selection.dart';
import 'package:foodapp/data/model/CostFactor.dart';
import 'package:foodapp/data/model/request.dart';
import 'package:foodapp/pages/long_term_calendar_selection_page.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../data/model/customer.dart';
import '../../data/model/location.dart';
import '../../data/repository/repository.dart';
import '../components/city_selected.dart';
import '../components/my_button.dart';
import '../data/model/service.dart';
import 'helper_list_page.dart';

// services_order.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  final RequestBuilder _requestBuilder = RequestBuilder();
  bool isLoading = true;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
    _loadData();
  }

  Future<void> _loadData() async {
    final repository = DefaultRepository();
    final locations = await repository.loadLocation();
    final customers = await repository.loadCustomer();

    setState(() {
      _requestBuilder.setLocations(locations ?? []);
      _requestBuilder.setCustomers(customers ?? []);
      isLoading = false;
    });
  }

  void _handleSubmit(BuildContext context) {
    final request = _requestBuilder.buildRequest(
        customer: widget.customer,
        service: widget.service,
        isOnDemand: _tabController.index == 0);

    if (request != null) {
      if (_tabController.index == 0) {
        _navigateToHelperList(context, request);
      } else {
        _navigateToCalendar(context, request);
      }
    }
  }

  void _navigateToHelperList(BuildContext context, Requests request) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HelperList(
          customer: widget.customer,
          request: request,
          listDate: [_requestBuilder.startDate!],
          isOnDemand: true,
          costFactors: widget.costFactors,
          services: widget.services,
        ),
      ),
    );
  }

  void _navigateToCalendar(BuildContext context, Requests request) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CustomCalendar(
          initialSelectedDates: _requestBuilder.getDateRange(),
          customer: widget.customer,
          request: request,
          maxDate: _requestBuilder.endDate,
          minDate: _requestBuilder.startDate,
          costFactors: widget.costFactors,
          services: widget.services,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _isLoading
          ? Container(
              color: Colors.white,
              child: Center(
                child: Lottie.asset(
                  'lib/images/loading.json',
                  width: 200,
                  height: 200,
                  repeat: true,
                ),
              ),
            )
          : TabBarView(
              controller: _tabController,
              children: [
                ServiceForm(
                  isOnDemand: true,
                  requestBuilder: _requestBuilder,
                  onFormChanged: () => setState(() {}),
                ),
                ServiceForm(
                  isOnDemand: false,
                  requestBuilder: _requestBuilder,
                  onFormChanged: () => setState(() {}),
                ),
              ],
            ),
      bottomNavigationBar: _buildBottomButton(context),
    );
  }

  PreferredSizeWidget _buildAppBar() => AppBar(
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
      );

  Widget _buildBottomButton(BuildContext context) => BottomAppBar(
        child: MyButton(
          text: "Tiếp theo",
          onTap: () => _handleSubmit(context),
        ),
      );

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

// models/request_builder.dart
class RequestBuilder {
  List<Location> _locations = [];
  List<Customer> _customers = [];
  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  Location? selectedProvince;
  String? selectedDistrict;

  void setLocations(List<Location> locations) => _locations = locations;
  void setCustomers(List<Customer> customers) => _customers = customers;
  List<Location> get locations => _locations;
  List<Customer> get customers => _customers;

  List<DateTime> getDateRange() {
    if (startDate == null || endDate == null) return [];
    return List.generate(
      endDate!.difference(startDate!).inDays + 1,
      (index) => startDate!.add(Duration(days: index)),
    );
  }

  Requests? buildRequest({
    required Customer customer,
    required Services service,
    required bool isOnDemand,
  }) {
    if (startTime == null || endTime == null) return null;

    final now = DateTime.now();
    startDate ??= now.hour > 8 ? now.add(const Duration(days: 1)) : now;

    final selectedEndDate = endDate ?? startDate;

    return Requests(
      customerInfo: CustomerInfo(
          fullName: customer.name,
          phone: customer.phone,
          address: customer.addresses[0].detailedAddress,
          usedPoint: customer.points[0].point),
      service: RequestService(
          title: service.title,
          coefficientService: 0.0,
          coefficientOther: 0.0,
          cost: service.basicPrice),
      location: selectedProvince != null
          ? RequestLocation(
              province: selectedProvince!.name,
              district: selectedDistrict ?? '',
            )
          : RequestLocation(province: '', district: ''),
      id: '',
      oderDate: DateTime.now().toIso8601String(),
      scheduleIds: [],
      startDate: DateFormat('yyyy-MM-dd').format(startDate!),
      startTime: _formatDateTime(startDate!, startTime!),
      endTime: _formatDateTime(selectedEndDate!, endTime!),
      requestType: isOnDemand ? 'Ngắn hạn' : 'Dài hạn',
      totalCost: 0,
      status: 'chưa tiến hành',
      deleted: false,
      comment: Comment(review: '', loseThings: false, breakThings: false),
      profit: 0,
    );
  }

  String _formatDateTime(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute)
        .toIso8601String();
  }
}

// widgets/service_form.dart
class ServiceForm extends StatelessWidget {
  final bool isOnDemand;
  final RequestBuilder requestBuilder;
  final VoidCallback onFormChanged;

  const ServiceForm({
    super.key,
    required this.isOnDemand,
    required this.requestBuilder,
    required this.onFormChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TimeSelection(
              onTimeChanged: _handleTimeChanged,
              onDateChanged: _handleDateChanged,
              isOnDemand: isOnDemand,
            ),
            const SizedBox(height: 20),
            _buildLocationSection(),
          ],
        ),
      ),
    );
  }

  void _handleTimeChanged(TimeOfDay? startTime, TimeOfDay? endTime) {
    requestBuilder.startTime = startTime;
    if (endTime == null && startTime != null) {
      requestBuilder.endTime =
          TimeOfDay(hour: startTime.hour + 2, minute: startTime.minute);
    } else {
      requestBuilder.endTime = endTime;
    }
    onFormChanged();
  }

  void _handleDateChanged(DateTime? date, String? isStartDate) {
    if (isStartDate == 'start') {
      requestBuilder.startDate = date;
      if (isOnDemand) {
        requestBuilder.endDate = null;
      }
    } else {
      requestBuilder.endDate = date;
    }
    onFormChanged();
  }

  Widget _buildLocationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Địa điểm",
          style: TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Expanded(
              child: SelectLocation(
                locations: requestBuilder.locations,
                onProvinceSelected: (province) {
                  requestBuilder.selectedProvince = province;
                  onFormChanged();
                },
                onDistrictSelected: (district) {
                  requestBuilder.selectedDistrict = district;
                  onFormChanged();
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const AddressType(),
        const SizedBox(height: 20),
      ],
    );
  }
}
