import 'package:flutter/material.dart';
import 'package:foodapp/components/city_selected.dart';
import 'package:foodapp/components/my_button.dart';
import 'package:foodapp/data/model/location.dart';
import 'package:foodapp/data/repository/repository.dart';
import 'package:foodapp/pages/choose_location_page.dart';
import '../components/loading_animation.dart';
import '../data/model/customer.dart';
import '../data/model/request.dart'; // Import for LoadingIndicator

class EditLocationPage extends StatefulWidget {
  final Customer customer;
  final Function(Location)? onProvinceSelected;
  final Function(String)? onDistrictSelected;
  final Function(String)? onDetailedAddressChanged;
  final Function onAddressUpdated;

  EditLocationPage({
    super.key,
    required this.customer,
    this.onProvinceSelected,
    this.onDistrictSelected,
    this.onDetailedAddressChanged,
    required this.onAddressUpdated,
  });

  final TextEditingController locationController = TextEditingController();

  @override
  State<EditLocationPage> createState() => _EditLocationPage();
}

class _EditLocationPage extends State<EditLocationPage> {
  late List<Location> locations = [];
  Location? selectedProvince;
  String? selectedDistrict;
  String? detailedAddress;
  bool isLoading = true;
  Duration loadingDuration = const Duration(seconds: 3);
  double progress = 0.0;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    setState(() {
      isLoading = true;
    });

    var repository = DefaultRepository();
    var data = await repository.loadLocation();
    setState(() {
      locations = data ?? [];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Chỉnh sửa thông tin",
          style: TextStyle(
            fontFamily: 'Quicksand',
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey.shade300,
        child: MyButton(
          text: "Lưu",
          onTap: () {
            detailedAddress = widget.locationController.text;
            if (widget.onDetailedAddressChanged != null) {
              widget.onDetailedAddressChanged!(detailedAddress!);
            }
            widget.onAddressUpdated();
            Navigator.pop(
              context,
              MaterialPageRoute(
                builder: (context) => ChooseLocationPage(
                  customer: widget.customer,
                  selectedProvince: selectedProvince,
                  selectedDistrict: selectedDistrict,
                  detailedAddress: detailedAddress,
                ),
              ),
            );
          },
        ),
      ),
      body: isLoading
          ? Center(
              child: LoadingIndicator(
                progress: progress,
                loadingDuration: loadingDuration,
              ),
            )
          : SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                color: Colors.grey.shade300,
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'Thông tin địa chỉ',
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          SelectLocation(
                            locations: locations,
                            onProvinceSelected: (Location province) {
                              setState(() {
                                selectedProvince = province;
                              });
                              if (widget.onProvinceSelected != null) {
                                widget.onProvinceSelected!(province);
                              }
                            },
                            onDistrictSelected: (String district) {
                              setState(() {
                                selectedDistrict = district;
                              });
                              if (widget.onDistrictSelected != null) {
                                widget.onDistrictSelected!(district);
                              }
                            },
                          ),
                          const Divider(
                            height: 16,
                            color: Colors.grey,
                          ),
                          TextField(
                            controller: widget.locationController,
                            decoration: InputDecoration(
                              hintText: "Địa chỉ cụ thể",
                              hintStyle: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                                fontFamily: 'Quicksand',
                              ),
                              border: InputBorder.none,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
