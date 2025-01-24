import 'package:flutter/material.dart';
import 'package:foodapp/components/my_employee_detail.dart';
import 'package:foodapp/data/model/CostFactor.dart';
import 'package:foodapp/data/model/TimeOff.dart';
import 'package:foodapp/data/model/customer.dart';
import 'package:foodapp/data/model/helper.dart';
import 'package:foodapp/data/model/request.dart';
import 'package:foodapp/data/repository/repository.dart';
import 'package:foodapp/pages/review_order_page.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class HelperList extends StatefulWidget {
  final Customer customer;
  final Requests request;
  final List<CostFactor> costFactors;
  final List<DateTime> listDate;
  final bool isOnDemand;

  const HelperList({
    super.key,
    required this.customer,
    required this.request,
    required this.listDate,
    required this.isOnDemand,
    required this.costFactors,
  });

  @override
  State<HelperList> createState() => _HelperListState();
}

class _HelperListState extends State<HelperList> {
  late List<Helper> helpers = [];
  late List<TimeOff> timeOffList = [];
  bool _isLoading = true;

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
    if (data == null) {
      timeOffList = [];
    } else {
      timeOffList = data;
    }
  }

  @override
  Widget build(BuildContext context) {
    final helperList = helpers.where((helper) {
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

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green,
        title: const Text(
          'Danh sách người giúp việc',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Quicksand',
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : helperList.isEmpty
              ? _buildEmptyState()
              : _buildHelperList(helperList),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_off, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'Không tìm thấy người giúp việc',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
              fontFamily: 'Quicksand',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHelperList(List<Helper> helperList) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: helperList.length,
      itemBuilder: (context, index) {
        final helper = helperList[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
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
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAvatar(helper.avatar),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  helper.fullName ?? '',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Quicksand',
                                  ),
                                ),
                              ),
                              _buildRating(4.5), // Add helper's rating here
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            helper.experienceDescription ?? '',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                              fontFamily: 'Quicksand',
                            ),
                          ),
                          const SizedBox(height: 12),
                          _buildTags(helper),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const MyEmployeeDetail(),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.info_outline, size: 20),
                                label: const Text('Xem chi tiết'),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.green,
                                  textStyle: const TextStyle(
                                    fontFamily: 'Quicksand',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.bookmark_border),
                                onPressed: () {
                                  // Add bookmark functionality
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAvatar(String? avatarUrl) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: FadeInImage.assetNetwork(
          placeholder: 'lib/images/avt.png',
          image: avatarUrl ?? '',
          fit: BoxFit.cover,
          imageErrorBuilder: (context, error, stackTrace) {
            return Image.asset(
              'lib/images/avt.png',
              fit: BoxFit.cover,
            );
          },
          fadeInDuration: const Duration(milliseconds: 300),
        ),
      ),
    );
  }

  Widget _buildRating(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.star, color: Colors.amber, size: 18),
        const SizedBox(width: 4),
        Text(
          rating.toString(),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'Quicksand',
          ),
        ),
      ],
    );
  }

  Widget _buildTags(Helper helper) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _buildTag('5 năm kinh nghiệm', Icons.work),
        _buildTag('Đã xác thực', Icons.verified_user),
        _buildTag('Chuyên nghiệp', Icons.star),
      ],
    );
  }

  Widget _buildTag(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.grey[600]),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontFamily: 'Quicksand',
            ),
          ),
        ],
      ),
    );
  }
}
