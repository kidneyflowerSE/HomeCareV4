import 'package:flutter/material.dart';
import 'package:foodapp/data/model/request.dart';
import '../../data/model/location.dart';

class SelectLocation extends StatefulWidget {
  final List<Location> locations;
  final Function(Location)? onProvinceSelected;
  final Function(String)? onDistrictSelected;


  const SelectLocation({super.key, required this.locations, this.onProvinceSelected, this.onDistrictSelected});

  @override
  State<SelectLocation> createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  Location? selectedLocation;
  String? selectedDistrict;
  List<String> districts = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // Canh trái các phần tử trong cột
      children: [
        // Dropdown cho Tỉnh/Thành phố
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

                // Cập nhật danh sách quận/huyện khi chọn tỉnh/thành phố
                if (newValue != null) {
                  districts = newValue.districts
                      .map<String>((district) => district.districtName)
                      .toList();
                  selectedDistrict = null; // Reset quận/huyện đã chọn
                  if (widget.onProvinceSelected != null) {
                    widget.onProvinceSelected!(newValue);
                  }
                }
              });
            },
            items: widget.locations
                .map<DropdownMenuItem<Location>>((Location location) {
              return DropdownMenuItem<Location>(
                value: location,
                child: Text(location.province), // Hiển thị tên tỉnh/thành phố
              );
            }).toList(),
          ),
        ),

        Divider(
          height: 16,
          color: Colors.grey[400],
        ),

        // Dropdown cho Quận/Huyện
        DropdownButtonHideUnderline(
          child: DropdownButton<String>(
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
            onChanged: (String? newValue) {
              setState(() {
                selectedDistrict = newValue;
                if (newValue != null && widget.onDistrictSelected != null) {
                  widget.onDistrictSelected!(newValue);
                }
              });
            },
            items: districts.map<DropdownMenuItem<String>>((String district) {
              return DropdownMenuItem<String>(
                value: district,
                child: Text(district), // Hiển thị tên quận/huyện
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
