import 'package:flutter/material.dart';
import 'package:foodapp/components/city_selected.dart';
import 'package:foodapp/components/my_button.dart';
import 'package:foodapp/data/model/location.dart';
import 'package:foodapp/data/repository/repository.dart';
import 'package:foodapp/pages/choose_location_page.dart';
import '../components/loading_animation.dart';
import '../data/model/customer.dart';
import '../data/model/request.dart'; // Thêm import cho LoadingIndicator

class EditLocationPage extends StatefulWidget {
  final Customer customer;
  final Requests request;

  EditLocationPage({super.key, required this.customer, required this.request});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  State<EditLocationPage> createState() => _EditLocationPage();
}

class _EditLocationPage extends State<EditLocationPage> {
  late List<Location> locations = [];
  late bool isLoading = true;
  late Duration loadingDuration =
      Duration(seconds: 3); // Thay đổi thời gian ở đây
  double progress = 0.0; // Giá trị hiện tại của progress

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    setState(() {
      isLoading = true;
    });

    // Thời gian bắt đầu
    final startTime = DateTime.now();

    var repository = DefaultRepository();
    var data = await repository.loadLocation();

    // Thời gian kết thúc
    final endTime = DateTime.now();
    loadingDuration =
        endTime.difference(startTime); // Cập nhật thời gian loading

    // Tính toán số bước cho progress
    int steps = 100; // Số bước cho progress
    int stepDuration = (loadingDuration.inMilliseconds / steps).round();

    for (int i = 0; i <= steps; i++) {
      await Future.delayed(
          Duration(milliseconds: stepDuration)); // Chờ từng bước
      setState(() {
        progress = i / steps; // Cập nhật giá trị progress
      });
    }

    setState(() {
      if (data == null) {
        locations = [];
      } else {
        locations = data;
      }
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ChooseLocationPage(customer: widget.customer),
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
                          SelectLocation(locations: locations,),
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
                              hintText:
                                  "Nhập các chi tiết khác (không bắt buộc)",
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
