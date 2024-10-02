import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeStart extends StatefulWidget {
  final TimeOfDay? initialTime;
  final ValueChanged<TimeOfDay> onTimeChanged;

  const TimeStart({
    super.key,
    this.initialTime,
    required this.onTimeChanged,
  });

  @override
  State<TimeStart> createState() => _TimeStartState();
}

class _TimeStartState extends State<TimeStart> {
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();

    if (now.hour >= 6 && now.hour < 14) {
      int additionalHours = now.minute > 30 ? 4 : 3;
      _selectedTime = TimeOfDay(
        hour: now.hour + additionalHours,
        minute: 0,
      );
    } else {
      _selectedTime = widget.initialTime ??
          (now.hour >= 20 || now.hour < 6
              ? const TimeOfDay(hour: 6, minute: 0)
              : TimeOfDay.now());
    }

    // Sử dụng addPostFrameCallback để gọi onTimeChanged sau khi widget đã được xây dựng
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_selectedTime != null) {
        widget.onTimeChanged(_selectedTime!);
      }
    });
  }

  String formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final format = DateFormat('HH:mm');
    return format.format(dt);
  }

  Future<void> _selectTime(BuildContext context) async {
    final now = DateTime.now();
    DateTime modifiedNow;
    if (now.hour >= 20 || (now.hour < 6 && now.day == DateTime.now().day)) {
      // Nếu đúng, đặt modifiedNow thành 6h sáng hôm sau
      modifiedNow = now.add(const Duration(days: 1)).copyWith(hour: 6, minute: 0);
    } else {
      // Ngược lại, sử dụng thời gian hiện tại
      modifiedNow = now;
    }

    final initialTime = (now.hour >= 20 || now.hour < 6)
        ? const TimeOfDay(hour: 6, minute: 0)
        : TimeOfDay.now();

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final selectedTime = modifiedNow.copyWith(
        hour: picked.hour,
        minute: picked.minute,
      );

      final startTime = modifiedNow.copyWith(hour: 5, minute: 59);
      final endTime = modifiedNow.copyWith(hour: 20, minute: 0);

      if (selectedTime.isBefore(modifiedNow)) {
        // && !selectedTime.isAtSameMomentAs(startTime)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Thời gian không hợp lệ')),
        );
      } else if (selectedTime.isBefore(startTime) ||
          selectedTime.isAfter(endTime)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Thời gian phải từ 06:00 đến 20:00')),
        );
      } else {
        setState(() {
          _selectedTime = picked;
          widget.onTimeChanged(_selectedTime!);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            _selectTime(context);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedTime != null
                      ? formatTimeOfDay(_selectedTime!)
                      : 'Chọn thời gian bắt đầu',
                  style: const TextStyle(
                    fontSize: 15,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Icon(
                  Icons.timelapse_rounded,
                  color: Colors.green,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
