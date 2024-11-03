import 'package:flutter/material.dart';
import 'package:foodapp/components/time_end.dart';
import 'package:foodapp/components/time_start.dart';
import 'calendar.dart';

class TimeSelection extends StatefulWidget {
  final Function(TimeOfDay?, TimeOfDay?)? onTimeChanged;
  final Function(DateTime?)? onDateChanged;
  final Function(DateTime?)? onDateSelect;

  const TimeSelection({super.key, this.onTimeChanged, this.onDateChanged, this.onDateSelect});

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

      if (_endTime != null && !_isEndTimeValid(_startTime!, _endTime!)) {
        _endTime = null; // Reset end time if it's invalid
      }
    });
    // Notify parent about the time change if necessary
    if (widget.onTimeChanged != null) {
      widget.onTimeChanged!(_startTime, _endTime);
    }
  }

  void _updateEndTime(TimeOfDay endTime) {
    setState(() {
      _endTime = endTime;
    });
    // Notify parent about the time change if necessary
    if (widget.onTimeChanged != null) {
      widget.onTimeChanged!(_startTime, _endTime);
    }
  }

  void _updateSelectedDate(DateTime? date) {
    setState(() {
      _selectedDate = date; // Update selected date
      _startTime = null; // Reset start time
      _endTime = null; // Reset end time
    });
    // Notify parent about the date change
    if (widget.onDateChanged != null) {
      widget.onDateChanged!(_selectedDate);
    }

  }

  bool _isEndTimeValid(TimeOfDay start, TimeOfDay end) {
    final startMinutes = start.hour * 60 + start.minute;
    final endMinutes = end.hour * 60 + end.minute;
    return endMinutes - startMinutes >= 120; // Minimum 2 hours difference
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Thời gian",
          style: TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 5),
        CalendarDropdown(onDateSelected: _updateSelectedDate),
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
        TimeStart(
          initialTime: _startTime,
          onTimeChanged: _updateStartTime,
          date: _selectedDate,
        ),
        const SizedBox(height: 20),
        const Text(
          "Giờ kết thúc",
          style: TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 5),
        TimeEnd(
          startTime: _startTime,
          initialTime: _endTime,
          onTimeChanged: _updateEndTime,
        ),
      ],
    );
  }
}
