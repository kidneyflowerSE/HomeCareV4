import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarDropdown extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  const CalendarDropdown({super.key, required this.onDateSelected});

  @override
  _CalendarDropdownState createState() => _CalendarDropdownState();
}

class _CalendarDropdownState extends State<CalendarDropdown> {
  DateTime? _selectedDate;

  DateTime _getDefaultDate() {
    final now = DateTime.now();
    // if (now.hour >= 20 || (now.hour < 6 && now.minute == 0)) {
    //   return now.add(const Duration(days: 1)); // Next day
    // } else {
    //   return now; // Today
    // }
    return now;
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
              _selectedDate != null
                  ? DateFormat('dd/MM/yyyy').format(_selectedDate!)
                  : DateFormat('dd/MM/yyyy').format(_getDefaultDate()),
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
