import 'package:flutter/material.dart';
import 'package:foodapp/data/model/customer.dart';
import 'package:foodapp/data/model/location.dart';
import 'package:foodapp/pages/edit_location_page.dart';

// Assume we have access to the Address class
// If your Address class is different, adjust accordingly
class Address {
  final String fullAddress;

  Address(this.fullAddress);

  @override
  String toString() => fullAddress;
}

class EditInformationPage extends StatefulWidget {
  final Customer customer;

  const EditInformationPage({Key? key, required this.customer})
      : super(key: key);

  @override
  State<EditInformationPage> createState() => _EditInformationPageState();
}

class _EditInformationPageState extends State<EditInformationPage> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late Location? selectedProvince;
  late String? selectedDistrict;
  late String? detailedAddress;
  int selectedAddressIndex = 0;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.customer.name);
    phoneController = TextEditingController(text: widget.customer.phone);
    selectedAddressIndex = 0; // Default to first address
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void updateLocation() {
    // This method needs to create an Address object instead of a string
    if (selectedProvince != null &&
        selectedDistrict != null &&
        detailedAddress != null) {
      final fullAddress =
          "$detailedAddress, $selectedDistrict, ${selectedProvince!.name}";

      setState(() {
        // Create a new Address object
        final newAddress = createAddressFromString(fullAddress);

        if (selectedAddressIndex < widget.customer.addresses.length) {
          // Replace existing address
          widget.customer.addresses[selectedAddressIndex] = newAddress;
        } else {
          // Add new address
          widget.customer.addresses.add(newAddress);
        }
      });
    }
  }

  // Helper method to create an Address object from a string
  // Adjust this based on your actual Address class implementation
  dynamic createAddressFromString(String addressStr) {
    // Since we don't know the exact Address class structure,
    // this is a placeholder. Replace with actual implementation.

    // Option 1: If Address is a simple class with a constructor that takes a string
    return Address(addressStr);

    // Option 2: If your app uses a different Address structure, replace with the appropriate code
    // Example if Address has specific fields:
    // return Address(
    //   street: addressParts[0],
    //   district: addressParts[1],
    //   province: addressParts[2],
    // );
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
          "Chỉnh sửa thông tin cá nhân",
          style: TextStyle(
            fontFamily: 'Quicksand',
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      // bottomNavigationBar: SafeArea(
      //   child: BottomAppBar(
      //     color: Colors.white,
      //     child: Padding(
      //       padding: const EdgeInsets.all(16),
      //       child: SizedBox(
      //         width: double.infinity,
      //         height: 56, // Đảm bảo chiều cao đầy đủ
      //         child: ElevatedButton(
      //           onPressed: () {
      //             _showConfirmationDialog(context);
      //           },
      //           style: ElevatedButton.styleFrom(
      //             backgroundColor: Colors.green,
      //             padding: const EdgeInsets.symmetric(vertical: 16),
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(15),
      //             ),
      //             elevation: 2,
      //           ),
      //           child:  Text(
      //             "Lưu thông tin",
      //             style: TextStyle(
      //               fontFamily: 'Quicksand',
      //               fontSize: 16,
      //               fontWeight: FontWeight.w600,
      //               color: Colors.white,
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context)
                .size
                .height, // Đảm bảo layout không bị mất
          ),
          child: Container(
            color: Colors.grey.shade100,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Photo Section
                const Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child:
                            Icon(Icons.person, size: 50, color: Colors.green),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.green,
                          radius: 18,
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Name Section
                _buildSectionTitle("Họ và tên"),
                _buildTextField(
                  controller: nameController,
                  hint: "Nhập họ và tên",
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 16),

                // Phone Section
                _buildSectionTitle("Số điện thoại"),
                _buildTextField(
                  controller: phoneController,
                  hint: "Nhập số điện thoại",
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),

                // Address Section
                _buildSectionTitle("Địa chỉ"),
                _buildAddressCard(),
                const SizedBox(height: 24),
                TextButton(
                  child: Text(
                    "Lưu thông tin",
                    style: const TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    _showConfirmationDialog(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Quicksand',
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
            fontStyle: FontStyle.italic,
            fontFamily: 'Quicksand',
          ),
          prefixIcon: Icon(icon, color: Colors.green),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  Widget _buildAddressCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Current address display
          ListTile(
            leading:
                const Icon(Icons.location_on_outlined, color: Colors.green),
            title: Text(
              widget.customer.addresses.isNotEmpty
                  ? widget.customer.addresses[selectedAddressIndex].toString()
                  : "Chưa có địa chỉ",
              style: const TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 14,
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios,
                size: 16, color: Colors.grey),
            onTap: () {
              _navigateToEditLocation();
            },
          ),

          // Address selector if multiple addresses
          if (widget.customer.addresses.length > 1)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  const Text(
                    "Chọn địa chỉ: ",
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 14,
                    ),
                  ),
                  Expanded(
                    child: DropdownButton<int>(
                      isExpanded: true,
                      value: selectedAddressIndex,
                      onChanged: (int? newValue) {
                        if (newValue != null) {
                          setState(() {
                            selectedAddressIndex = newValue;
                          });
                        }
                      },
                      items: List.generate(
                        widget.customer.addresses.length,
                        (index) => DropdownMenuItem<int>(
                          value: index,
                          child: Text(
                            "Địa chỉ ${index + 1}",
                            style: const TextStyle(fontFamily: 'Quicksand'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  void _navigateToEditLocation() async {
    final TextEditingController locationController = TextEditingController();

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditLocationPage(
          customer: widget.customer,
          onProvinceSelected: (province) {
            selectedProvince = province;
          },
          onDistrictSelected: (district) {
            selectedDistrict = district;
          },
          onDetailedAddressChanged: (address) {
            detailedAddress = address;
          },
          onAddressUpdated: updateLocation,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        // If we have a returned index, update the selected address
        selectedAddressIndex = 0; // Default to first address if none selected
      });
    }
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Xác nhận thay đổi",
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            "Bạn có chắc chắn muốn cập nhật thông tin cá nhân?",
            style: TextStyle(fontFamily: 'Quicksand'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Hủy",
                style: TextStyle(
                  fontFamily: 'Quicksand',
                  color: Colors.grey,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Update customer information
                widget.customer.name = nameController.text;
                widget.customer.phone = phoneController.text;

                // Return updated customer
                Navigator.pop(context); // Close dialog
                Navigator.pop(
                    context, widget.customer); // Return to profile page
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text(
                "Xác nhận",
                style: TextStyle(
                  fontFamily: 'Quicksand',
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
