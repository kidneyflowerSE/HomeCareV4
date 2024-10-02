import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeStart extends StatefulWidget {
  const TimeStart({super.key});

  @override
  State<TimeStart> createState() => _TimeStartState();
}

class _TimeStartState extends State<TimeStart> {
  TimeOfDay? _selectedTime;
  bool _isValidTime = true;

  String formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final format = DateFormat('HH:mm');
    return format.format(dt);
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedTime) {
      final now = TimeOfDay.now();

      setState(() {
        _selectedTime = picked;

        _isValidTime = (picked.hour > now.hour) ||
            (picked.hour == now.hour && picked.minute > now.minute);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    int addHour = now.minute >= 30 ? 4 : 3;
    DateTime newTime =
        DateTime(now.year, now.month, now.day, now.hour + addHour, 0);
    String formattedNewTime = DateFormat('HH:mm').format(newTime);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
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
                      : formattedNewTime,
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
        const SizedBox(height: 5),
        if (!_isValidTime) ...[
          const Text(
            "Giờ bắt đầu phải trước 1h từ lúc đặt đơn!",
            style: TextStyle(
              fontFamily: 'Quicksand',
              color: Colors.red,
            ),
          ),
        ],
      ],
    );
  }
}
