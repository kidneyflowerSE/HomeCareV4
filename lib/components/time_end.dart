import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeEnd extends StatefulWidget {
  final TimeOfDay? initialTime;
  final ValueChanged<TimeOfDay> onTimeChanged;
  final TimeOfDay? startTime;

  const TimeEnd({
    super.key,
    this.initialTime,
    required this.onTimeChanged,
    this.startTime,
  });

  @override
  State<TimeEnd> createState() => _TimeEndState();
}

class _TimeEndState extends State<TimeEnd> {
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    _updateInitialTime();
  }

  @override
  void didUpdateWidget(covariant TimeEnd oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.startTime != oldWidget.startTime) {
      _updateInitialTime();
    }
  }

  void _updateInitialTime() {
    final startTime = widget.startTime;

    if (startTime != null) {
      _selectedTime = widget.initialTime ??
          TimeOfDay(
            hour: startTime.hour + 2,
            minute: startTime.minute,
          );
    } else {
      _selectedTime = null;
    }
  }

  String formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final format = DateFormat('HH:mm');
    return format.format(dt);
  }

  Future<void> _selectTime(BuildContext context) async {
    if (widget.startTime == null) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Chọn thời gian bắt đầu trước')),
      // );
      showPopUpWarning('Chọn thời gian bắt đầu trước');
      return;
    }

    final startTime = widget.startTime!;
    final initialTime = TimeOfDay(
      hour: (startTime.hour + 2).clamp(6, 20),
      minute: startTime.minute,
    );

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
      if (_isEndTimeValid(startTime, picked) && _isTimeInValidRange(picked)) {
        setState(() {
          _selectedTime = picked;
          widget.onTimeChanged(_selectedTime!);
        });
      } else {
        _isEndTimeValid(startTime, picked)
            ? showPopUpWarning(
                'Thời gian kết thúc phải trong khoảng từ 6h sáng đến 8h tối')
            : showPopUpWarning(
                'Thời gian kết thúc phải sau thời gian bắt đầu ít nhất 2 tiếng');
      }
    }
  }

  bool _isTimeInValidRange(TimeOfDay time) {
    final now = DateTime.now();
    final selectedTime =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final startOfValidRange =
        DateTime(now.year, now.month, now.day, 6, 0); // 6h sáng
    final endOfValidRange =
        DateTime(now.year, now.month, now.day, 20, 1); // 8h tối

    return selectedTime.isAfter(startOfValidRange) &&
        selectedTime.isBefore(endOfValidRange);
  }

  bool _isEndTimeValid(TimeOfDay start, TimeOfDay end) {
    final startMinutes = start.hour * 60 + start.minute;
    final endMinutes = end.hour * 60 + end.minute;
    return endMinutes - startMinutes >= 120; // ít nhất 2 giờ (120 phút)
  }

  void showPopUpWarning(String warning) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.topSlide,
      showCloseIcon: true,
      title: 'Warning',
      desc: warning,
      btnCancelOnPress: () {},
      btnOkOnPress: () {},
    ).show();
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
              color: Colors.white,
              border: Border.all(
                color: Colors.grey.shade200,
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0.0, 1.0),
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 4.0,
                  spreadRadius: 0.0,
                )
              ],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedTime != null
                      ? formatTimeOfDay(_selectedTime!)
                      : 'Chọn thời gian bắt đầu',
                  style: _selectedTime != null
                      ? TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        )
                      : TextStyle(
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade400,
                        ),
                ),
                Icon(
                  Icons.timelapse_rounded,
                  color: Colors.green.shade400,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
