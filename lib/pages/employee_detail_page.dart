// import 'package:flutter/material.dart';
// import 'package:foodapp/components/my_button.dart';

// class EmployeeDetailPage extends StatelessWidget {
//   const EmployeeDetailPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(60.0),
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.green[400],
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.3),
//                 spreadRadius: 3,
//                 blurRadius: 10,
//                 offset: Offset(0, 3),
//               ),
//             ],
//           ),
//           child: AppBar(
//             automaticallyImplyLeading: false,
//             // backgroundColor: Colors.transparent,
//             // elevation: 0,
//             centerTitle: true,
//             title: Text(
//               "Chi tiết nhân viên",
//               style: TextStyle(
//                 fontFamily: 'Quicksand',
//                 fontWeight: FontWeight.w700,
//                 fontSize: 18,
//               ),
//             ),
//             leading: IconButton(
//               icon: Icon(Icons.arrow_back_ios_new_outlined),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//             actions: [
//               Icon(
//                 Icons.heart_broken,
//                 color: Colors.redAccent[700],
//               ),
//               SizedBox(width: 16),
//               Icon(Icons.info_outline_rounded),
//               SizedBox(width: 8),
//             ],
//           ),
//         ),
//       ),
//       body: Container(
//         margin: EdgeInsets.only(top: 25),
//         child: Column(
//           children: [
//             Container(
//               margin: EdgeInsets.symmetric(horizontal: 100),
//               alignment: Alignment.center,
//               padding: EdgeInsets.symmetric(horizontal: 8),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 color: Colors.green[400],
//               ),
//               height: 25,
//               child: Text(
//                 "Mã nhân viên: #49549",
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w600,
//                     fontFamily: 'Quicksand',
//                     fontSize: 16),
//               ),
//             ),
//             const SizedBox(height: 25),
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(154),
//                 border: Border.all(
//                   color: Colors.green,
//                   width: 4,
//                 ),
//               ),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(150),
//                 child: Image.asset(
//                   'lib/images/staff/anhhuy.jpg',
//                   height: 300,
//                   width: 300,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               "Phạm Nguyễn Quốc Huy",
//               style: TextStyle(
//                   color: Colors.green[400],
//                   fontFamily: 'Quicksand',
//                   fontSize: 25,
//                   fontWeight: FontWeight.w800),
//             ),
//             const SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.location_on_sharp,
//                   color: Colors.grey[400],
//                 ),
//                 const SizedBox(width: 5),
//                 Text(
//                   "Quận Thủ Đức, TP.Hồ Chí Minh",
//                   style: TextStyle(
//                     color: Colors.grey[400],
//                     fontSize: 16,
//                     fontFamily: 'Quicksand',
//                   ),
//                 )
//               ],
//             ),
//             const SizedBox(height: 10),
//             Row(
//               children: [
//                 Expanded(
//                   child: Column(
//                     children: [
//                       Text(
//                         "20",
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontFamily: 'Quicksand',
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         "Tuổi",
//                         style: TextStyle(
//                           color: Colors.grey[400],
//                           fontFamily: 'Quicksand',
//                           fontSize: 16,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text(
//                             "5",
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontFamily: 'Quicksand',
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Icon(
//                             Icons.star,
//                             color: Colors.amberAccent,
//                           )
//                         ],
//                       ),
//                       Text(
//                         "Số sao",
//                         style: TextStyle(
//                           color: Colors.grey[400],
//                           fontFamily: 'Quicksand',
//                           fontSize: 16,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: Column(
//                     children: [
//                       Text(
//                         "582",
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontFamily: 'Quicksand',
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         "Giờ làm",
//                         style: TextStyle(
//                           color: Colors.grey[400],
//                           fontFamily: 'Quicksand',
//                           fontSize: 16,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: Column(
//                     children: [
//                       Text(
//                         "239",
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontFamily: 'Quicksand',
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         "Đánh giá",
//                         style: TextStyle(
//                           color: Colors.grey[400],
//                           fontFamily: 'Quicksand',
//                           fontSize: 16,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             Container(
//               margin: EdgeInsets.symmetric(horizontal: 20),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       margin: EdgeInsets.symmetric(horizontal: 4),
//                       padding: EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         color: Colors.green.shade500,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.2),
//                             spreadRadius: 1,
//                             blurRadius: 5,
//                             offset: Offset(0, 4),
//                           )
//                         ],
//                         borderRadius: BorderRadius.circular(8),
//                         border: Border.all(
//                           width: 2,
//                           color: Colors.green.shade800,
//                         ),
//                       ),
//                       child: Center(
//                         child: Text(
//                           'Quét nhà',
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontFamily: 'Quicksand',
//                             fontWeight: FontWeight.w600,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Container(
//                       margin: EdgeInsets.symmetric(horizontal: 4),
//                       padding: EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         color: Colors.green.shade500,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.2),
//                             spreadRadius: 1,
//                             blurRadius: 5,
//                             offset: Offset(0, 4),
//                           )
//                         ],
//                         borderRadius: BorderRadius.circular(8),
//                         border: Border.all(
//                           width: 2,
//                           color: Colors.green.shade800,
//                         ),
//                       ),
//                       child: Center(
//                         child: Text(
//                           'Rửa chén',
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontFamily: 'Quicksand',
//                             fontWeight: FontWeight.w600,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Container(
//                       margin: EdgeInsets.symmetric(horizontal: 4),
//                       padding: EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         color: Colors.green.shade500,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.2),
//                             spreadRadius: 1,
//                             blurRadius: 5,
//                             offset: Offset(0, 4),
//                           )
//                         ],
//                         borderRadius: BorderRadius.circular(8),
//                         border: Border.all(
//                           width: 2,
//                           color: Colors.green.shade800,
//                         ),
//                       ),
//                       child: Center(
//                         child: Text(
//                           'Nấu cơm',
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontFamily: 'Quicksand',
//                             fontWeight: FontWeight.w600,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Container(
//                       margin: EdgeInsets.symmetric(horizontal: 4),
//                       padding: EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         color: Colors.green.shade500,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.2),
//                             spreadRadius: 1,
//                             blurRadius: 5,
//                             offset: Offset(0, 4),
//                           )
//                         ],
//                         borderRadius: BorderRadius.circular(8),
//                         border: Border.all(
//                           width: 2,
//                           color: Colors.green.shade800,
//                         ),
//                       ),
//                       child: Center(
//                         child: Text(
//                           'Giặt đồ',
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontFamily: 'Quicksand',
//                             fontWeight: FontWeight.w600,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomAppBar(
//         child: MyButton(text: "Đặt lịch với nhân viên này", onTap: () {}),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../../data/model/helper.dart';

class EmployeeDetailPage extends StatelessWidget {
  final List<Helper> helpers;
  final int index;

  const EmployeeDetailPage(
      {super.key, required this.helpers, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.green[400],
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 3,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: AppBar(
            automaticallyImplyLeading: false,
            // backgroundColor: Colors.transparent,
            // elevation: 0,
            centerTitle: true,
            title: const Text(
              "Chi tiết nhân viên",
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_outlined),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              Icon(
                Icons.heart_broken,
                color: Colors.redAccent[700],
              ),
              const SizedBox(width: 16),
              const Icon(Icons.info_outline_rounded),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 25),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 100),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.green[400],
              ),
              height: 25,
              child: Text(
                helpers[index].helperId!,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Quicksand',
                    fontSize: 16),
              ),
            ),
            const SizedBox(height: 25),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(154),
                border: Border.all(
                  color: Colors.green,
                  width: 4,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(150),
                child: Image.network(
                  helpers[index].avatar!,
                  height: 300,
                  width: 300,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              helpers[index].fullName!,
              style: TextStyle(
                  color: Colors.green[400],
                  fontFamily: 'Quicksand',
                  fontSize: 25,
                  fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on_sharp,
                  color: Colors.grey[400],
                ),
                const SizedBox(width: 5),
                Text(
                  helpers[index].address!,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 16,
                    fontFamily: 'Quicksand',
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                        "20",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Quicksand',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Tuổi",
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontFamily: 'Quicksand',
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "5",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Quicksand',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.amberAccent,
                          )
                        ],
                      ),
                      Text(
                        "Số sao",
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontFamily: 'Quicksand',
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                        "582",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Quicksand',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Giờ làm",
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontFamily: 'Quicksand',
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                        "239",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Quicksand',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Đánh giá",
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontFamily: 'Quicksand',
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.green.shade500,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 4),
                          )
                        ],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          width: 2,
                          color: Colors.green.shade800,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Quét nhà',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.green.shade500,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 4),
                          )
                        ],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          width: 2,
                          color: Colors.green.shade800,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Rửa chén',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.green.shade500,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 4),
                          )
                        ],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          width: 2,
                          color: Colors.green.shade800,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Nấu cơm',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.green.shade500,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 4),
                          )
                        ],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          width: 2,
                          color: Colors.green.shade800,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Giặt đồ',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
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
      ),
      bottomNavigationBar: BottomAppBar(
        child: GestureDetector(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(40)),
            child: const Center(
              child: Text(
                'Đặt lịch với nhân viên này',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                    fontFamily: 'Quicksand'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
