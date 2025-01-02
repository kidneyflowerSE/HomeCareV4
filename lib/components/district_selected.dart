import 'package:flutter/material.dart';
import '../../data/model/location.dart';

class DistrictSelected extends StatefulWidget {
  final List<Location> locations;
  const DistrictSelected({super.key, required this.locations});

  @override
  State<DistrictSelected> createState() => _DistrictSelectedState();
}

class _DistrictSelectedState extends State<DistrictSelected> {
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
            "Quận/huyện",
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontStyle: FontStyle.italic,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
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
                location.name,
                style: const TextStyle(fontFamily: 'Quicksand'),
              ), // Hiển thị tên của Location trong dropdown
            );
          }).toList(),
        ),
      ),
    );
  }
}
