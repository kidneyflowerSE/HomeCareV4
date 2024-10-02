import 'package:flutter/material.dart';
import 'package:foodapp/components/city_selected.dart';
import 'package:foodapp/components/my_button.dart';
import 'package:foodapp/data/model/location.dart';
import 'package:foodapp/data/repository/repository.dart';
import 'package:foodapp/pages/choose_location_page.dart';

import '../data/model/customer.dart';

class EditLocationPage extends StatefulWidget {
  final Customer customer;

  EditLocationPage({super.key, required this.customer});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  State<EditLocationPage> createState() => _EditLocationPage();
}
class _EditLocationPage extends State<EditLocationPage> {
  late List<Location> locations = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData () async{
    var repository = DefaultRepository();
    var data = await repository.loadLocation();
    if(data == null){
      locations = [];
    } else {
      locations = data;
    }
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChooseLocationPage(customer: widget.customer),
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.grey.shade300,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // const Text(
              //   'Thông tin liên hệ',
              //   style: TextStyle(
              //     fontFamily: 'Quicksand',
              //   ),
              // ),
              // const SizedBox(height: 10),
              // Container(
              //   padding: const EdgeInsets.all(10),
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   child: Column(
              //     children: [
              //       TextField(
              //         controller: nameController,
              //         decoration: InputDecoration(
              //           hintText: "Tên của bạn",
              //           hintStyle: TextStyle(
              //             color: Colors.grey[600],
              //             fontSize: 16,
              //             fontStyle: FontStyle.italic,
              //             fontFamily: 'Quicksand',
              //           ),
              //           border: InputBorder.none,
              //           contentPadding:
              //               const EdgeInsets.symmetric(horizontal: 10),
              //         ),
              //       ),
              //       Divider(
              //         height: 0,
              //         color: Colors.grey[400],
              //       ),
              //       TextField(
              //         controller: phoneNumberController,
              //         decoration: InputDecoration(
              //           hintText: "Số điện thoại",
              //           hintStyle: TextStyle(
              //             color: Colors.grey[600],
              //             fontSize: 16,
              //             fontStyle: FontStyle.italic,
              //             fontFamily: 'Quicksand',
              //           ),
              //           border: InputBorder.none,
              //           contentPadding:
              //               const EdgeInsets.symmetric(horizontal: 10),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(height: 20),
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
                    // _buildDropdown("TP. Hồ Chí Minh"),
                    // Divider(
                    //   height: 16,
                    //   color: Colors.grey[400],
                    // ),
                    // _buildDropdown("TP. Thủ Đức"),
                    // Divider(
                    //   height: 16,
                    //   color: Colors.grey[400],
                    // ),
                    SelectLocation(locations: locations),
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
                    Divider(
                      height: 0,
                      color: Colors.grey[400],
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Nhập các chi tiết khác (không bắt buộc)",
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

  Widget _buildDropdown(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        const Icon(
          Icons.keyboard_arrow_down_rounded,
          size: 30,
        ),
      ],
    );
  }
}







// import 'package:flutter/material.dart';
// import 'package:foodapp/components/my_button.dart';
// import 'package:foodapp/components/my_textfield.dart';
// import 'package:foodapp/pages/choose_location_page.dart';

// class EditLocationPage extends StatelessWidget {
//   EditLocationPage({super.key});
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController locationController = TextEditingController();
//   final TextEditingController phoneNumberController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.green,
//           leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: const Icon(
//               Icons.arrow_back_ios_new_rounded,
//               color: Colors.white,
//             ),
//           ),
//           title: const Text(
//             "Chỉnh sửa thông tin",
//             style: TextStyle(
//               fontFamily: 'Quicksand',
//               color: Colors.white,
//               fontSize: 18,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           centerTitle: true,
//           automaticallyImplyLeading: false,
//         ),
//         bottomNavigationBar: BottomAppBar(
//           child: MyButton(
//               text: "Lưu",
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const ChooseLocationPage()));
//               }),
//         ),
//         body: Container(
//           color: Colors.grey.shade200,
//           padding: const EdgeInsets.all(10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // MyTextField(
//               //   controller: phoneNumberController,
//               //   hintText: "Địa chỉ",
//               //   obscureText: false,
//               // ),
//               const Text('Thông tin liên hệ'),
//               const SizedBox(height: 10),
//               Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Column(
//                   children: [
//                     TextField(
//                       decoration: InputDecoration(
//                         hintStyle: TextStyle(
//                           color: Colors.grey[600],
//                           fontSize: 16,
//                           fontStyle: FontStyle.italic,
//                           fontFamily: 'Quicksand',
//                         ),
//                         border: InputBorder.none,
//                         contentPadding:
//                             const EdgeInsets.symmetric(horizontal: 10),
//                       ),
//                     ),
//                     Divider(
//                       height: 0,
//                       indent: 10,
//                       endIndent: 10,
//                       color: Colors.grey.shade300,
//                     ),
//                     TextField(
//                       decoration: InputDecoration(
//                         hintStyle: TextStyle(
//                           color: Colors.grey[600],
//                           fontSize: 16,
//                           fontStyle: FontStyle.italic,
//                           fontFamily: 'Quicksand',
//                         ),
//                         border: InputBorder.none,
//                         contentPadding:
//                             const EdgeInsets.symmetric(horizontal: 10),
//                       ),
//                     ),
//                     Divider(
//                       height: 0,
//                       indent: 10,
//                       endIndent: 10,
//                       color: Colors.grey.shade300,
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//               const Text('Thông tin địa chỉ'),
//               const SizedBox(height: 10),
//               Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Column(
//                   children: [
//                     Container(
//                       margin: const EdgeInsets.symmetric(horizontal: 10),
//                       child: const Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "TP. Hồ Chí Minh",
//                             style: TextStyle(
//                               fontSize: 16,
//                             ),
//                           ),
//                           Icon(
//                             Icons.keyboard_arrow_down_rounded,
//                             size: 30,
//                           )
//                         ],
//                       ),
//                     ),
//                     Divider(
//                       height: 16,
//                       indent: 10,
//                       endIndent: 10,
//                       color: Colors.grey.shade300,
//                     ),
//                     Container(
//                       margin: const EdgeInsets.symmetric(horizontal: 10),
//                       child: const Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "TP. Thủ Đức",
//                             style: TextStyle(
//                               fontSize: 16,
//                             ),
//                           ),
//                           Icon(
//                             Icons.keyboard_arrow_down_rounded,
//                             size: 30,
//                           )
//                         ],
//                       ),
//                     ),
//                     Divider(
//                       height: 16,
//                       indent: 10,
//                       endIndent: 10,
//                       color: Colors.grey.shade300,
//                     ),
//                     TextField(
//                       decoration: InputDecoration(
//                         hintStyle: TextStyle(
//                           color: Colors.grey[600],
//                           fontSize: 16,
//                           fontStyle: FontStyle.italic,
//                           fontFamily: 'Quicksand',
//                         ),
//                         border: InputBorder.none,
//                         contentPadding:
//                             const EdgeInsets.symmetric(horizontal: 10),
//                       ),
//                     ),
//                     Divider(
//                       height: 0,
//                       indent: 10,
//                       endIndent: 10,
//                       color: Colors.grey.shade300,
//                     ),
//                     TextField(
//                       decoration: InputDecoration(
//                         hintText: "Nhập các chi tiết khác (không bắt buộc)",
//                         hintStyle: TextStyle(
//                           color: Colors.grey[600],
//                           fontSize: 14,
//                           fontStyle: FontStyle.italic,
//                           fontFamily: 'Quicksand',
//                         ),
//                         border: InputBorder.none,
//                         contentPadding:
//                             const EdgeInsets.symmetric(horizontal: 10),
//                       ),
//                     ),
//                     Divider(
//                       height: 8,
//                       indent: 10,
//                       endIndent: 10,
//                       color: Colors.grey.shade300,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


