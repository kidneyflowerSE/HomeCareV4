import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarDropdown extends StatefulWidget {
  const CalendarDropdown({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CalendarDropdownState createState() => _CalendarDropdownState();
}

class _CalendarDropdownState extends State<CalendarDropdown> {
  DateTime? _selectedDate;

  // Hàm để xác định ngày mặc định
  DateTime _getDefaultDate() {
    final now = DateTime.now();
    if (now.hour >= 20 || (now.hour < 6 && now.minute == 0)) {
      // Nếu sau 8h tối hoặc chưa đến 6h sáng
      return now.add(const Duration(days: 1)); // Ngày mai
    } else {
      return now; // Ngày hôm nay
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    // Sử dụng ngày mặc định
    final DateTime initialDate = _selectedDate ?? _getDefaultDate();

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: _selectedDate ?? _getDefaultDate(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            _selectDate(context);
          },
          child: Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedDate != null
                      ? DateFormat('dd/MM/yyyy')
                      .format(_selectedDate!) // Format ngày
                      : DateFormat('dd/MM/yyyy').format(_getDefaultDate()), // Ngày mặc định
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
        ),
      ],
    );
  }
}
