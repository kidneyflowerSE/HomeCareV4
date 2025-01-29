import 'package:flutter/material.dart';
import 'package:foodapp/data/model/CostFactor.dart';
import 'package:foodapp/data/model/request.dart';
import '../data/model/customer.dart';
import 'package:foodapp/pages/helper_list_page.dart';

import '../data/model/service.dart';

class CustomCalendar extends StatefulWidget {
  final List<DateTime> initialSelectedDates;
  final DateTime? minDate;
  final DateTime? maxDate;
  final Customer customer;
  final Requests request;
  final List<CostFactor> costFactors;
  final List<Services> services;

  CustomCalendar({
    Key? key,
    this.initialSelectedDates = const [],
    this.minDate,
    this.maxDate,
    required this.customer,
    required this.request,
    required this.costFactors, required this.services,
  }) : super(key: key);

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  DateTime _focusedDate = DateTime.now();
  late List<DateTime> _selectedDates;
  late int _selectedMonth;
  late int _selectedYear;
  late PageController _pageController;
  bool _isWeekView = false;

  @override
  void initState() {
    super.initState();
    _selectedDates = widget.initialSelectedDates;

    if (_selectedDates.isNotEmpty) {
      _focusedDate = _selectedDates.first;
    }

    _selectedMonth = _focusedDate.month;
    _selectedYear = _focusedDate.year;
    _pageController =
        PageController(initialPage: _calculatePageIndex(_focusedDate));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int _calculatePageIndex(DateTime date) {
    return (date.year * 12 + date.month) -
        (DateTime(2000, 1).year * 12 + DateTime(2000, 1).month);
  }

  DateTime _calculateDateFromPageIndex(int pageIndex) {
    final baseDate = DateTime(2000, 1);
    return DateTime(baseDate.year + pageIndex ~/ 12, pageIndex % 12 + 1);
  }

  List<DateTime?> _generateDaysInMonth(DateTime date) {
    final firstDayOfMonth = DateTime(date.year, date.month, 1);
    final lastDayOfMonth = DateTime(date.year, date.month + 1, 0);

    int leadingDays = (firstDayOfMonth.weekday - 1) % 7;

    List<DateTime?> days = List.generate(
      lastDayOfMonth.day,
          (index) => DateTime(date.year, date.month, index + 1),
    );

    for (int i = 0; i < leadingDays; i++) {
      days.insert(0, null);
    }

    return days;
  }

  bool _isDateInRange(DateTime date) {
    final minDate = widget.minDate;
    final maxDate = widget.maxDate;

    if (minDate != null && date.isBefore(minDate)) return false;
    if (maxDate != null && date.isAfter(maxDate)) return false;
    if (date.isBefore(DateTime.now().subtract(const Duration(days: 1))))
      return false;

    return true;
  }

  void _toggleDateSelection(DateTime date) {
    if (!_isDateInRange(date)) return;

    setState(() {
      if (_selectedDates.length <= 2 && _selectedDates.contains(date)) {
        return;
      }

      if (_selectedDates.contains(date)) {
        _selectedDates.remove(date);
      } else {
        _selectedDates.add(date);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Lịch chọn nhiều ngày'),
        actions: [
          IconButton(
            icon: Icon(_isWeekView ? Icons.calendar_today : Icons.view_week),
            onPressed: () {
              setState(() {
                _isWeekView = !_isWeekView;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton<int>(
                  value: _selectedMonth,
                  items: List.generate(
                    12,
                        (index) => DropdownMenuItem(
                      value: index + 1,
                      child: Text("${index + 1}",
                          style: const TextStyle(fontSize: 16)),
                    ),
                  ),
                  onChanged: (newMonth) {
                    if (newMonth != null) {
                      final newDate = DateTime(_selectedYear, newMonth, 1);
                      final newPageIndex = _calculatePageIndex(newDate);
                      _pageController.jumpToPage(newPageIndex);
                    }
                  },
                ),
                const SizedBox(width: 10),
                DropdownButton<int>(
                  value: _selectedYear,
                  items: List.generate(
                    30,
                        (index) => DropdownMenuItem(
                      value: DateTime.now().year - 15 + index,
                      child: Text("${DateTime.now().year - 15 + index}"),
                    ),
                  ),
                  onChanged: (newYear) {
                    if (newYear != null) {
                      final newDate = DateTime(newYear, _selectedMonth, 1);
                      final newPageIndex = _calculatePageIndex(newDate);
                      _pageController.jumpToPage(newPageIndex);
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (pageIndex) {
                final newDate = _calculateDateFromPageIndex(pageIndex);
                setState(() {
                  _focusedDate = newDate;
                  _selectedMonth = newDate.month;
                  _selectedYear = newDate.year;
                });
              },
              itemBuilder: (context, pageIndex) {
                final date = _calculateDateFromPageIndex(pageIndex);
                final days = _generateDaysInMonth(date);

                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: weekdays.map((day) {
                        return Expanded(
                          child: Center(
                            child: Text(
                              day,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 7,
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 4.0,
                        ),
                        itemCount: days.length,
                        itemBuilder: (context, index) {
                          final day = days[index];

                          if (day == null) {
                            return Container();
                          }

                          final isSelected = _selectedDates.contains(day);
                          final isInRange = _isDateInRange(day);

                          return GestureDetector(
                            onTap: () => _toggleDateSelection(day),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              decoration: BoxDecoration(
                                color: isSelected ? Colors.blue : Colors.white,
                                border: isSelected
                                    ? Border.all(
                                    color: Colors.blueAccent, width: 2)
                                    : null,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                day.day.toString(),
                                style: TextStyle(
                                  color: isInRange
                                      ? (isSelected
                                      ? Colors.white
                                      : Colors.black)
                                      : Colors.grey,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                print("Selected Dates: $_selectedDates");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HelperList(
                      customer: widget.customer,
                      request: widget.request,
                      listDate: _selectedDates,
                      isOnDemand: false,
                      costFactors: widget.costFactors, services: widget.services,
                    ),
                  ),
                );
              },
              child: const Text('Xác nhận'),
            ),
          ),
        ],
      ),
    );
  }
}
