import 'package:flutter/material.dart';
import 'package:foodapp/components/time_end.dart';
import 'package:foodapp/components/time_start.dart';
import 'calendar.dart';

class TimeSelection extends StatefulWidget {
  final Function(TimeOfDay?, TimeOfDay?)? onTimeChanged;
  final Function(DateTime?, String?)? onDateChanged;
  final Function(bool)? onVisibilityChanged; // Callback theo dõi visibility
  final bool isOnDemand;

  const TimeSelection({
    super.key,
    this.onTimeChanged,
    this.onDateChanged,
    this.onVisibilityChanged, // Nhận callback
    required this.isOnDemand,
  });

  @override
  State<TimeSelection> createState() => _TimeSelectionState();
}

class _TimeSelectionState extends State<TimeSelection> {
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  DateTime? _selectedDate;
  bool isVisibilityActive = false; // Trạng thái của Visibility

  @override
  void initState() {
    super.initState();

    // Đảm bảo setState() chỉ chạy sau khi build hoàn tất
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
  }

  bool _isEndTimeValid(TimeOfDay start, TimeOfDay end) {
    final startMinutes = start.hour * 60 + start.minute;
    final endMinutes = end.hour * 60 + end.minute;
    return endMinutes - startMinutes >= 120; // Tối thiểu 2 tiếng
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.isOnDemand ? "Thời gian" : "Ngày bắt đầu",
          style: const TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 5),
        CalendarDropdown(
          onDateSelected: (date) => _updateSelectedDate(date, "start"),
          initialDate: null,
        ),
        Visibility(
          visible: !widget.isOnDemand,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Ngày kết thúc",
                style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 5),
              CalendarDropdown(
                onDateSelected: (date) => _updateSelectedDate(date, "end"),
                initialDate: DateTime.now(),
              ),
            ],
          ),
        ),
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
