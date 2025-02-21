import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarDropdown extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  final DateTime? initialDate;

  const CalendarDropdown({
    super.key,
    required this.onDateSelected,
    this.initialDate,
  });

  @override
  _CalendarDropdownState createState() => _CalendarDropdownState();
}

class _CalendarDropdownState extends State<CalendarDropdown> {
  DateTime? _selectedDate;

  DateTime _getDefaultDate() {
    return widget.initialDate ?? DateTime.now();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime initialDate = _selectedDate ?? _getDefaultDate();

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now(), // ⬅️ Không cho phép chọn ngày trước hôm nay
      lastDate: DateTime(2100),
      helpText: "Chọn ngày", // Tiêu đề hộp thoại
      cancelText: "Hủy", // Nút Hủy
      confirmText: "Xác nhận", // Nút Xác nhận
      fieldHintText: "dd/MM/yyyy", // Gợi ý nhập ngày
      fieldLabelText: "Nhập ngày", // Nhãn ô nhập ngày
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.green, // Màu tiêu đề
            colorScheme: ColorScheme.light(
              primary: Colors.green, // Màu chính của lịch
              onPrimary: Colors.white, // Màu chữ trên tiêu đề
              surface: Colors.white, // Màu nền hộp thoại
              onSurface: Colors.black, // Màu chữ chính
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.green, // Màu của nút Hủy & OK
              ),
            ),
            textTheme: const TextTheme(
              titleLarge: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              bodyLarge: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 16,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
      widget.onDateSelected(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _selectedDate != null
                  ? DateFormat('dd/MM/yyyy').format(_selectedDate!)
                  : "Chọn ngày",
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black87,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w600,
              ),
            ),
            const Icon(Icons.calendar_month_rounded, color: Colors.green),
          ],
        ),
      ),
    );
  }
}
