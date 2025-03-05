import 'package:flutter/material.dart';
import 'package:foodapp/components/time_end.dart';
import 'package:foodapp/components/time_start.dart';
import 'calendar.dart';

class TimeSelection extends StatefulWidget {
  final Function(TimeOfDay?, TimeOfDay?)? onTimeChanged;
  final Function(DateTime?, String?)? onDateChanged;
  final Function(bool)? onVisibilityChanged;
  final bool isOnDemand;

  const TimeSelection({
    super.key,
    this.onTimeChanged,
    this.onDateChanged,
    this.onVisibilityChanged,
    required this.isOnDemand,
  });

  @override
  State<TimeSelection> createState() => _TimeSelectionState();
}

class _TimeSelectionState extends State<TimeSelection> {
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  DateTime? _selectedDate;
  bool isVisibilityActive = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          isVisibilityActive = !widget.isOnDemand;
        });
        widget.onVisibilityChanged?.call(isVisibilityActive);
      }
    });
  }

  void _updateStartTime(TimeOfDay startTime) {
    setState(() {
      _startTime = startTime;
      if (_endTime != null && !_isEndTimeValid(_startTime!, _endTime!)) {
        _endTime = null;
      }
    });
    widget.onTimeChanged?.call(_startTime, _endTime);
  }

  void _updateEndTime(TimeOfDay endTime) {
    setState(() {
      _endTime = endTime;
    });
    widget.onTimeChanged?.call(_startTime, _endTime);
  }

  void _updateSelectedDate(DateTime? date, String type) {
    setState(() {
      _selectedDate = date;
      _startTime = null;
      _endTime = null;
    });
    widget.onDateChanged?.call(date, type);
    widget.onTimeChanged?.call(_startTime,_endTime);
  }

  bool _isEndTimeValid(TimeOfDay start, TimeOfDay end) {
    final startMinutes = start.hour * 60 + start.minute;
    final endMinutes = end.hour * 60 + end.minute;
    return endMinutes - startMinutes >= 120;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(
            widget.isOnDemand ? "Thời gian" : "Ngày bắt đầu",
          ),
          const SizedBox(height: 10),
          _buildCalendarSection(),
          if (!widget.isOnDemand) ...[
            const SizedBox(height: 20),
            _buildSectionTitle("Ngày kết thúc"),
            const SizedBox(height: 10),
            _buildEndDateCalendarSection(),
          ],
          const SizedBox(height: 20),
          _buildSectionTitle("Giờ bắt đầu"),
          const SizedBox(height: 10),
          TimeStart(
            initialTime: _startTime,
            onTimeChanged: _updateStartTime,
            date: _selectedDate,
          ),
          const SizedBox(height: 20),
          _buildSectionTitle("Giờ kết thúc"),
          const SizedBox(height: 10),
          TimeEnd(
            startTime: _startTime,
            initialTime: _endTime,
            onTimeChanged: _updateEndTime,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'Quicksand',
        fontWeight: FontWeight.w800,
        fontSize: 16,
        color: Colors.grey,
      ),
    );
  }

  Widget _buildCalendarSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: CalendarDropdown(
        onDateSelected: (date) => _updateSelectedDate(date, "start"),
        initialDate: null,
      ),
    );
  }

  Widget _buildEndDateCalendarSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: CalendarDropdown(
        onDateSelected: (date) => _updateSelectedDate(date, "end"),
        initialDate: DateTime.now(),
      ),
    );
  }
}
