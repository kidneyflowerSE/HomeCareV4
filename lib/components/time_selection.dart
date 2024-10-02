import 'package:flutter/material.dart';
import 'package:foodapp/components/time_end.dart';
import 'package:foodapp/components/time_start.dart';

class TimeSelection extends StatefulWidget {
  const TimeSelection({super.key});

  @override
  State<TimeSelection> createState() => _TimeSelectionState();
}

class _TimeSelectionState extends State<TimeSelection> {
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  void _updateStartTime(TimeOfDay startTime) {
    setState(() {
      _startTime = startTime;

      if (_endTime != null && !_isEndTimeValid(_startTime!, _endTime!)) {
        _endTime = null;
      }
    });
  }

  void _updateEndTime(TimeOfDay endTime) {
    setState(() {
      _endTime = endTime;
    });
  }

  bool _isEndTimeValid(TimeOfDay start, TimeOfDay end) {
    final startMinutes = start.hour * 60 + start.minute;
    final endMinutes = end.hour * 60 + end.minute;
    return endMinutes - startMinutes >= 120;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        TimeStart(
          initialTime: _startTime,
          onTimeChanged: _updateStartTime,
        ),
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
        TimeEnd(
          startTime: _startTime,
          initialTime: _endTime,
          onTimeChanged: _updateEndTime,
        ),
      ],
    );
  }
}
