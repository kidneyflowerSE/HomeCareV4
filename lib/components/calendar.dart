import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarDropdown extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  final DateTime? initialDate;
  final bool isStartDate; // Thêm tham số để phân biệt ngày bắt đầu/kết thúc

  const CalendarDropdown({
    super.key,
    required this.onDateSelected,
    this.initialDate,
    required this.isStartDate,
  });

  @override
  _CalendarDropdownState createState() => _CalendarDropdownState();
}

class _CalendarDropdownState extends State<CalendarDropdown> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? _getDefaultDate();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onDateSelected(_selectedDate!);
    });
  }

  DateTime _getDefaultDate() {
    final now = DateTime.now();

    if (widget.isStartDate) { // Nếu là ngày bắt đầu
      if (now.hour >= 15) {
        return now.add(const Duration(days: 1)); // Ngày mai nếu sau 15h
      } else {
        return now;
      }
    } else { // Nếu là ngày kết thúc
      if (now.hour >= 15) {
        return now.add(const Duration(days: 2)); // Ngày kia nếu sau 15h
      } else {
        return now.add(const Duration(days: 1)); // Mặc định là ngày mai
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime initialDate = _selectedDate ?? _getDefaultDate();

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: _getDefaultDate(),
      lastDate: DateTime(2100),
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
              DateFormat('dd/MM/yyyy').format(_selectedDate!),
              style: const TextStyle(
                fontSize: 15,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w600,
              ),
            ),
            const Icon(
              Icons.calendar_month_rounded,
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
