import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:foodapp/pages/helper_detail_page.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:foodapp/data/model/helper.dart';
import 'package:foodapp/data/model/customer.dart';
import 'package:foodapp/data/model/request.dart';
import 'package:foodapp/data/model/service.dart';
import 'package:foodapp/data/model/CostFactor.dart';
import 'package:foodapp/data/model/TimeOff.dart';
import 'package:foodapp/pages/review_order_page.dart';
import 'package:foodapp/components/my_employee_detail.dart';
import 'package:foodapp/data/repository/repository.dart';

class HelperList extends StatefulWidget {
  final Customer customer;
  final Requests request;
  final List<CostFactor> costFactors;
  final List<DateTime> listDate;
  final bool isOnDemand;
  final List<Services> services;

  const HelperList({
    super.key,
    required this.customer,
    required this.request,
    required this.listDate,
    required this.isOnDemand,
    required this.costFactors,
    required this.services,
  });

  @override
  State<HelperList> createState() => _HelperListState();
}

class _HelperListState extends State<HelperList> {
  late List<Helper> helpers = [];
  late List<TimeOff> timeOffList = [];
  bool _isLoading = true;
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Experience', 'Rating', 'Distance'];

  @override
  void initState() {
    super.initState();
    loadHelperData();
    loadTimeOffData();
  }

  Future<void> loadHelperData() async {
    var repository = DefaultRepository();
    var data = await repository.loadCleanerData();
    if (data == null) {
      helpers = [];
    } else {
      helpers = data;
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> loadTimeOffData() async {
    var repository = DefaultRepository();
    var data = await repository.loadTimeOff();
    timeOffList = data ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final filteredHelpers = _filterHelpers();

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          if (_isLoading)
            const SliverFillRemaining(child: LoadingView())
          else if (filteredHelpers.isEmpty)
            const SliverFillRemaining(child: EmptyStateView())
          else
            SliverToBoxAdapter(
              child: Column(
                children: [
                  _buildFilterSection(),
                  _buildHelperGrid(filteredHelpers),
                ],
              ),
            ),
        ],
      ),
    );
  }

  List<Helper> _filterHelpers() {
    final availableHelpers = helpers.where((helper) {
      final isHelperInTimeOff =
          timeOffList.any((timeOff) => timeOff.helperId == helper.id);
      if (!isHelperInTimeOff) return true;

      final isDateOffWithinRange = timeOffList.any((timeOff) {
        if (timeOff.helperId != helper.id) return false;
        final timeOffDate = DateTime.parse(timeOff.dateOff);
        return widget.listDate
            .any((startDate) => isSameDay(timeOffDate, startDate));
      });
      return !isDateOffWithinRange;
    }).toList();

    switch (_selectedFilter) {
      case 'Experience':
        availableHelpers
            .sort((a, b) => b.yearOfExperience.compareTo(a.yearOfExperience));
        break;
      case 'Rating':
        // Implement rating sort when available
        break;
      case 'Distance':
        // Implement distance sort when available
        break;
    }

    return availableHelpers;
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 60,
      floating: true,
      // pinned: true,
      backgroundColor: Colors.green,
      elevation: 0,
      leading: IconButton(
        icon: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_back_ios_new_outlined,
              color: Colors.black),
        ),
        onPressed: () => Navigator.pop(context),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: Colors.green,
          padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
          child: const Text(
            'Chọn người giúp việc',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Quicksand',
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _filters.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final filter = _filters[index];
          final isSelected = _selectedFilter == filter;
          return FilterChip(
            label: Text(filter),
            selected: isSelected,
            onSelected: (selected) {
              setState(() => _selectedFilter = filter);
            },
            backgroundColor: isSelected ? Colors.blue : Colors.grey[100],
            labelStyle: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          );
        },
      ),
    );
  }

  Widget _buildHelperGrid(List<Helper> helpers) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(20),
      itemCount: helpers.length,
      itemBuilder: (context, index) {
        return Padding(
          padding:
              const EdgeInsets.only(bottom: 16), // Khoảng cách giữa các item
          child: HelperCard(
            helper: helpers[index],
            onTap: () => _navigateToReviewOrder(helpers[index]),
            allServices: [],
          ),
        );
      },
    );
  }

  void _navigateToReviewOrder(Helper helper) {
    widget.request.helperId = helper.helperId;
    widget.request.startDate = widget.listDate
        .map((date) => DateFormat('yyyy-MM-dd').format(date))
        .join(',');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReviewOrderPage(
          customer: widget.customer,
          helper: helper,
          request: widget.request,
          costFactors: widget.costFactors,
          services: widget.services,
        ),
      ),
    );
  }
}

class HelperCard extends StatelessWidget {
  final Helper helper;
  final VoidCallback onTap;
  final List<Service> allServices;

  const HelperCard({
    Key? key,
    required this.helper,
    required this.onTap,
    required this.allServices,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                _buildAvatar(), // Ảnh đại diện
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildNameAndRating(), // Tên và đánh giá
                      const SizedBox(height: 4),
                      _buildExperience(), // Kinh nghiệm
                      const SizedBox(height: 4),
                      _buildLocation(), // Khu vực làm việc
                      // const SizedBox(height: 6),
                      // _buildJobTags(), // Các công việc có thể làm
                      // const SizedBox(height: 6),
                      // _buildActionButton(), // Nút hành động
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildJobTags(),
              ],
            ),
            Row(
              children: [
                _buildActionButton(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Ảnh đại diện
  Widget _buildAvatar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: helper.avatar != null && helper.avatar!.isNotEmpty
          ? Image.network(
              helper.avatar!,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return _buildPlaceholderImage();
              },
            )
          : _buildPlaceholderImage(),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      width: 80,
      height: 80,
      color: Colors.grey[200],
      child: const Icon(Icons.person, size: 40, color: Colors.grey),
    );
  }

  /// Tên và đánh giá
  Widget _buildNameAndRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            helper.fullName ?? 'No Name',
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Row(
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 16),
            const SizedBox(width: 4),
            Text(
              '4.8', // Thay thế bằng dữ liệu đánh giá
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Kinh nghiệm
  Widget _buildExperience() {
    return Text(
      '${helper.yearOfExperience} năm kinh nghiệm',
      style: TextStyle(
        fontSize: 14,
        color: Colors.grey[700],
        fontFamily: 'Quicksand',
      ),
    );
  }

  /// Khu vực làm việc
  Widget _buildLocation() {
    return Text(
      helper.workingArea.province,
      style: TextStyle(
        fontSize: 14,
        fontFamily: 'Quicksand',
        color: Colors.grey[700],
      ),
    );
  }

  /// Các công việc có thể làm
  Widget _buildJobTags() {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // Cho phép cuộn ngang
        child: Row(
          children: helper.jobs.take(3).map((job) => _buildTag(job)).toList(),
        ),
      ),
    );
  }

  Widget _buildTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          fontFamily: 'Quicksand',
        ),
      ),
    );
  }

  /// Nút hành động (Chi tiết)
  Widget _buildActionButton(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HelperDetailPage(helper: helper),
                ),
              );
            },
            child: const Text(
              'Chi tiết',
              style: TextStyle(
                color: Colors.blue,
                fontFamily: 'Quicksand',
              ),
            ),
          ),
          TextButton(
            onPressed: onTap,
            child: const Text(
              'Chọn người giúp việc',
              style: TextStyle(
                color: Colors.blue,
                fontFamily: 'Quicksand',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'lib/images/loading.json',
        width: 200,
        height: 200,
        repeat: true,
      ),
    );
  }
}

class EmptyStateView extends StatelessWidget {
  const EmptyStateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off_rounded, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            'No Helpers Available',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your filters or try again later',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
