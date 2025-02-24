import 'package:flutter/material.dart';
import '../../data/model/location.dart';

class SelectLocation extends StatefulWidget {
  final List<Location> locations;
  final Function(Location)? onProvinceSelected;
  final Function(String)? onDistrictSelected;
  final Function(String)? onWardSelected; // Chỉ trả về ward.name

  const SelectLocation({
    super.key,
    required this.locations,
    this.onProvinceSelected,
    this.onDistrictSelected,
    this.onWardSelected,
  });

  @override
  State<SelectLocation> createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  Location? selectedLocation;
  District? selectedDistrict;
  String? selectedWardName; // Chỉ lưu ward.name

  List<District> districts = [];
  List<Ward> wards = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Dropdown chọn Tỉnh/Thành phố
        DropdownButtonHideUnderline(
          child: DropdownButton<Location>(
            value: selectedLocation,
            hint: const Text(
              "Chọn một tỉnh/thành",
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
            icon: const Icon(Icons.arrow_drop_down),
            onChanged: (Location? newValue) {
              setState(() {
                selectedLocation = newValue;
                selectedDistrict = null;
                selectedWardName = null;
                wards = [];

                // Cập nhật danh sách quận/huyện
                if (newValue != null) {
                  districts = newValue.districts;
                  widget.onProvinceSelected?.call(newValue);
                }
              });
            },
            items: widget.locations.map((Location location) {
              return DropdownMenuItem<Location>(
                value: location,
                child: Text(location.name),
              );
            }).toList(),
          ),
        ),

        Divider(height: 16, color: Colors.grey[400]),

        // Dropdown chọn Quận/Huyện
        DropdownButtonHideUnderline(
          child: DropdownButton<District>(
            value: selectedDistrict,
            hint: const Text(
              "Chọn một quận/huyện",
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
            icon: const Icon(Icons.arrow_drop_down),
            onChanged: (District? newValue) {
              setState(() {
                selectedDistrict = newValue;
                selectedWardName = null;
                wards = newValue?.wards ?? [];

                widget.onDistrictSelected?.call(newValue!.name);
              });
            },
            items: districts.map((District district) {
              return DropdownMenuItem<District>(
                value: district,
                child: Text(district.name),
              );
            }).toList(),
          ),
        ),

        Divider(height: 16, color: Colors.grey[400]),

        // Dropdown chọn Phường/Xã (Chỉ lấy ward.name)
        DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedWardName,
            hint: const Text(
              "Chọn một phường/xã",
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
            icon: const Icon(Icons.arrow_drop_down),
            onChanged: (String? newValue) {
              setState(() {
                selectedWardName = newValue;
                widget.onWardSelected?.call(newValue!);
              });
            },
            items: wards.map((Ward ward) {
              return DropdownMenuItem<String>(
                value: ward.name,
                child: Text(ward.name),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
