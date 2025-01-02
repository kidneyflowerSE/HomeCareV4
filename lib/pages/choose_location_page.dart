import 'package:flutter/material.dart';
import 'package:foodapp/pages/edit_location_page.dart';
import 'package:foodapp/pages/home_page.dart';

import '../data/model/customer.dart';
import '../data/model/location.dart';

class ChooseLocationPage extends StatefulWidget {
  final Customer customer;
  final Location? selectedProvince;
  final String? selectedDistrict;
  final String? detailedAddress;
  // final Requests requests;
  const ChooseLocationPage({super.key, required this.customer, this.selectedProvince, this.selectedDistrict, this.detailedAddress});

  @override
  _ChooseLocationPageState createState() => _ChooseLocationPageState();
}

class _ChooseLocationPageState extends State<ChooseLocationPage> {
  Location? selectedProvince;
  String? selectedDistrict;
  String? detailedAddressChanged;

  void addAddress() {
    setState(() {
      widget.customer.addresses.add(Addresses(province: selectedProvince!.name, district: selectedDistrict!, detailedAddress: detailedAddressChanged!));
    });
  }

  void modifyAddress(int index) {
    setState(() {
      widget.customer.addresses[index] = Addresses(
        province: selectedProvince!.name,
        district: selectedDistrict!,
        detailedAddress: detailedAddressChanged!,
      );
    });
  }

  void _onAddressSelected(BuildContext context, int addressIndex) {
    // Return the selected address when the user confirms their choice
    Navigator.pop(context, addressIndex);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "Địa chỉ của bạn",
          style: TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: [
          // Button thêm địa chỉ
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditLocationPage(
                          customer: widget.customer,
                          onProvinceSelected: (Location province) {
                            setState(() {
                              selectedProvince = province;
                            });
                          },
                          onDistrictSelected: (String district){
                            setState(() {
                              selectedDistrict = district;
                            });
                          },
                          onDetailedAddressChanged: (String detailedAddress){
                            setState(() {
                              detailedAddressChanged = detailedAddress;
                            });
                          }, onAddressUpdated: addAddress,
                        ),
                      ),
                    );
                  },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    border: Border.symmetric(
                      horizontal: BorderSide(
                        width: 1,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.add,
                            size: 20,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Thêm địa chỉ",
                            style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 16,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),
                ),
                const SizedBox(height: 10),

                // Danh sách địa chỉ
                ListView.builder(
                  shrinkWrap: true, // Cho phép ListView.builder nằm trong một ListView khác
                  physics: const NeverScrollableScrollPhysics(), // Không cần cuộn riêng cho danh sách địa chỉ
                  itemCount: widget.customer.addresses.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: GestureDetector(
                              onTap: () { _onAddressSelected(context, index);
                                print('Địa chỉ được chọn: ${widget.customer.addresses[index]}');
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.customer.name ?? 'Tên không có sẵn',
                                    style: const TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    widget.customer.phone ?? 'Số điện thoại không có sẵn',
                                    style: const TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    widget.customer.addresses[index].toString(),
                                    style: const TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditLocationPage(
                                    customer: widget.customer,
                                    onProvinceSelected: (Location province) {
                                      setState(() {
                                        selectedProvince = province;
                                      });
                                    },
                                    onDistrictSelected: (String district){
                                      setState(() {
                                        selectedDistrict = district;
                                      });
                                    },
                                    onDetailedAddressChanged: (String detailedAddress){
                                      setState(() {
                                        detailedAddressChanged = detailedAddress;
                                      });
                                    }, onAddressUpdated: () => modifyAddress(index),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 80,
                              child: const Text(
                                "Chỉnh sửa",
                                style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

