import 'package:flutter/material.dart';
import 'calendar.dart';
import 'time_start.dart';
import 'time_end.dart';

class TimeSelection extends StatefulWidget {
  final Function(TimeOfDay?, TimeOfDay?)? onTimeChanged;
  final Function(DateTime?, String?)? onDateChanged;
  final bool isOnDemand;

  const TimeSelection({
    super.key,
    this.onTimeChanged,
    this.onDateChanged,
    required this.isOnDemand,
  });

  @override
  State<TimeSelection> createState() => _TimeSelectionState();
}

class _TimeSelectionState extends State<TimeSelection> {
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  DateTime? _selectedDate;

  void _updateStartTime(TimeOfDay startTime) {
    setState(() {
      _startTime = startTime;
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
    });
    widget.onDateChanged?.call(date, type);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.isOnDemand ? "Chọn thời gian" : "Ngày bắt đầu",
          style: const TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        CalendarDropdown(
          onDateSelected: (date) => _updateSelectedDate(date, "start"),
          initialDate: _selectedDate,
        ),
        if (!widget.isOnDemand) ...[
          const SizedBox(height: 16),
          const Text(
            "Ngày kết thúc",
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          CalendarDropdown(
            onDateSelected: (date) => _updateSelectedDate(date, "end"),
            initialDate: _selectedDate,
          ),
        ],
        const SizedBox(height: 16),
        const Text(
          "Giờ bắt đầu",
          style: TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        TimeStart(
          initialTime: _startTime,
          onTimeChanged: _updateStartTime,
          date: _selectedDate,
        ),
        const SizedBox(height: 16),
        const Text(
          "Giờ kết thúc",
          style: TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        TimeEnd(
          startTime: _startTime,
          initialTime: _endTime,
          onTimeChanged: _updateEndTime,
        ),
      ],
    );
  }
}
