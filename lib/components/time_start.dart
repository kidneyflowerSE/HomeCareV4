import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeStart extends StatefulWidget {
  final DateTime? date;
  final TimeOfDay? initialTime;
  final ValueChanged<TimeOfDay> onTimeChanged;

  const TimeStart({
    super.key,
    this.initialTime,
    required this.onTimeChanged,
    this.date,
  });

  @override
  State<TimeStart> createState() => _TimeStartState();
}

class _TimeStartState extends State<TimeStart> {
  TimeOfDay? _selectedTime;
  DateTime referenceDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    referenceDate = widget.date ?? now;

    // Khởi tạo thời gian nếu có thời gian khởi tạo
    if (widget.initialTime != null) {
      _selectedTime = widget.initialTime;
    } else {
    if (referenceDate.hour > 15 && referenceDate.day == now.day) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showPopUpWarning(
            'Thời gian hiện tại đã qua 15:00. Vui lòng chọn ngày khác');
      });
    } else if (referenceDate.hour >= 6 && referenceDate.hour < 14) {
      int additionalHours = referenceDate.minute > 30 ? 4 : 3;
      _selectedTime = TimeOfDay(
        hour: referenceDate.hour + additionalHours,
        minute: 0,
      );
    } else {
      _selectedTime =
          null; // Giữ _selectedTime là null nếu không có điều kiện nào được thỏa mãn
    }
    }

    // Gọi onTimeChanged ngay khi khởi tạo
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_selectedTime != null) {
        widget.onTimeChanged(_selectedTime!);
      }
    });
  }

  @override
  void didUpdateWidget(TimeStart oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Kiểm tra xem ngày đã thay đổi chưa
    if (widget.date != oldWidget.date) {
      // Cập nhật lại referenceDate và _selectedTime khi date thay đổi
      referenceDate = widget.date ?? DateTime.now();
      if (referenceDate.hour >= 6 && referenceDate.hour < 14) {
        int additionalHours = referenceDate.minute > 30 ? 4 : 3;
        _selectedTime = TimeOfDay(
          hour: referenceDate.hour + additionalHours,
          minute: 0,
        );
      } else {
        _selectedTime = widget.initialTime;
      }
      // Gọi lại onTimeChanged để thông báo sự thay đổi
      if (_selectedTime != null) {
        widget.onTimeChanged(_selectedTime!);
      }
    }
  }

  String formatTimeOfDay(TimeOfDay time) {
    referenceDate = widget.date ?? DateTime.now();
    final dt = DateTime(
      referenceDate.year,
      referenceDate.month,
      referenceDate.day,
      time.hour,
      time.minute,
    );
    final format = DateFormat('HH:mm');
    return format.format(dt);
  }

  Future<void> _selectTime(BuildContext context) async {
    final now = DateTime.now();

    bool isSameDay = referenceDate.year == now.year &&
        referenceDate.month == now.month &&
        referenceDate.day == now.day;

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (picked != null) {
      DateTime selectedDateTime = referenceDate.copyWith(
        hour: picked.hour,
        minute: picked.minute,
      );

      // Ràng buộc thời gian cho ngày hôm nay
      if (isSameDay) {
        final DateTime startTime = referenceDate.copyWith(hour: 6, minute: 0);
        final DateTime endTime = referenceDate.copyWith(hour: 15, minute: 0);

        // Nếu thời gian hiện tại đã qua 15:00 (3 giờ chiều), thông báo lỗi
        if (now.hour >= 15) {
          showPopUpWarning(
              'Thời gian hiện tại đã qua 15:00. Vui lòng chọn ngày khác');
          return;
        } else if (selectedDateTime.isBefore(now)) {
          showPopUpWarning(
              'Thời gian không được chọn trước thời gian hiện tại');
          return;
        } else if (selectedDateTime.isBefore(startTime) ||
            selectedDateTime.isAfter(endTime)) {
          showPopUpWarning('Thời gian phải từ 6:00 đến 15:00 hôm nay');
          return;
        }
      } else {
        // Ràng buộc thời gian từ 06:00 đến 18:00 cho ngày khác
        final DateTime startTime = referenceDate.copyWith(hour: 6, minute: 0);
        final DateTime endTime =
            referenceDate.copyWith(hour: 18, minute: 0); // 18:00 cho ngày khác

        if (selectedDateTime.isBefore(startTime) ||
            selectedDateTime.isAfter(endTime)) {
          showPopUpWarning('Thời gian phải từ 6:00 đến 18:00 cho ngày khác');
          return;
        }
      }

      // Nếu thời gian hợp lệ, cập nhật và thông báo
      setState(() {
        _selectedTime = picked;
        widget.onTimeChanged(_selectedTime!);
      });
    }
  }

  void showPopUpWarning(String warning) {
    AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.warning,
      desc: warning,
      btnOkOnPress: () {},
      btnCancelOnPress: () {},
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
