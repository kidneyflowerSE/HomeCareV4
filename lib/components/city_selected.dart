import 'package:flutter/material.dart';
import '../../data/model/location.dart';

class CitySelected extends StatefulWidget {
  final List<Location> locations;
  const CitySelected({super.key, required this.locations});

  @override
  State<CitySelected> createState() => _CitySelectedState();
}

class _CitySelectedState extends State<CitySelected> {
  Location? selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green), // Viền của ô chọn
        borderRadius: BorderRadius.circular(8), // Bo góc cho ô chọn
      ),
      child: DropdownButtonHideUnderline(
        // Ẩn underline gốc của DropdownButton
        child: DropdownButton<Location>(
          value: selectedLocation,
          hint: const Text(
            "Tỉnh/thành phố",
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontStyle: FontStyle.italic,
              color: Colors.grey,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          isExpanded: true,
          elevation: 16,
          onChanged: (Location? newValue) {
            setState(() {
              selectedLocation = newValue;
            });
          },
          items: widget.locations
              .map<DropdownMenuItem<Location>>((Location location) {
            return DropdownMenuItem<Location>(
              value: location,
              child: Text(
                location.province,
                style: const TextStyle(fontFamily: 'Quicksand'),
              ), // Hiển thị tên của Location trong dropdown
            );
          }).toList(),
        ),
      ),
    );
  }
}
