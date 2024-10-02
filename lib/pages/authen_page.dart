// import 'package:flutter/material.dart';
// import 'package:foodapp/components/my_button.dart';
// import 'package:foodapp/components/my_confirm_text.dart';
// import 'package:foodapp/pages/login_page.dart';

// class AuthenPage extends StatelessWidget {
//   final void Function()? onTap;

//   const AuthenPage({super.key, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     void login() {
//       /*
//       Fill out authentication here
//       */

//       // Navigate to login page
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => LoginPage(onTap: () {}),
//         ),
//       );
//     }

//     return Scaffold(
//       backgroundColor: Colors.white,
//       resizeToAvoidBottomInset:
//           false, // Prevents the Stack from resizing when the keyboard appears
//       body: Stack(
//         children: [
//           // Background with circles
//           Positioned(
//             left: 0,
//             top: -70,
//             child: ClipRect(
//               child: Align(
//                 alignment: Alignment.topLeft,
//                 widthFactor: 1.0,
//                 child: Container(
//                   width: 120,
//                   height: 120,
//                   decoration: const BoxDecoration(
//                     color: Color(0xFF8cbe3d),
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             left: -80,
//             top: -30,
//             child: ClipRect(
//               child: Align(
//                 alignment: Alignment.topLeft,
//                 widthFactor: 1.0,
//                 child: Container(
//                   width: 150,
//                   height: 150,
//                   decoration: const BoxDecoration(
//                     color: Color(0xFF02571c),
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             right: 0,
//             bottom: -70,
//             child: ClipRect(
//               child: Align(
//                 alignment: Alignment.bottomRight,
//                 widthFactor: 1.0,
//                 child: Container(
//                   width: 120,
//                   height: 120,
//                   decoration: const BoxDecoration(
//                     color: Color(0xFF8cbe3d),
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             right: -80,
//             bottom: -30,
//             child: ClipRect(
//               child: Align(
//                 alignment: Alignment.bottomRight,
//                 widthFactor: 1.0,
//                 child: Container(
//                   width: 150,
//                   height: 150,
//                   decoration: const BoxDecoration(
//                     color: Color(0xFF02571c),
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           // Main content
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 // Logo
//                 Image.asset(
//                   './lib/images/logo.png',
//                   width: 220,
//                   height: 220,
//                 ),

//                 const SizedBox(height: 25),

//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 25),
//                   child: Text(
//                     'Mã xác nhận gồm 6 chữ số vừa được gửi vào email của bạn. Vui lòng nhập mã của bạn bên dưới:',
//                     style: TextStyle(fontFamily: 'Quicksand', fontSize: 14),
//                   ),
//                 ),

//                 // Confirm text field
//                 MyConfirmText(),

//                 const SizedBox(height: 20),

//                 // Confirm button
//                 MyButton(text: "Xác nhận", onTap: login),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:foodapp/components/my_button.dart';
import 'package:foodapp/components/my_confirm_text.dart';
import 'package:foodapp/pages/login_page.dart';

class AuThenPage extends StatelessWidget {
  final void Function()? onTap;

  const AuThenPage({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    void login() {
      /*

    fill out authentication here

    */

      // navigate to home page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(
            onTap: () {},
          ),
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            top: -70,
            child: ClipRect(
              child: Align(
                alignment: Alignment.topLeft,
                widthFactor: 1.0,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: const BoxDecoration(
                    color: Colors.yellow,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: -80,
            top: -30,
            child: ClipRect(
              child: Align(
                alignment: Alignment.topLeft,
                widthFactor: 1.0,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: -70,
            child: ClipRect(
              child: Align(
                alignment: Alignment.bottomRight,
                widthFactor: 1.0,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: const BoxDecoration(
                    color: Colors.yellow,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: -80,
            bottom: -30,
            child: ClipRect(
              child: Align(
                alignment: Alignment.bottomRight,
                widthFactor: 1.0,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // logo
                Image.asset(
                  'lib/images/logo.png',
                  width: 220,
                  height: 220,
                ),

                const SizedBox(
                  height: 25,
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    'Mã xác nhận gồm 6 chữ số vừa được gửi vào email của bạn. Vui lòng nhập mã của bạn bên dưới:',
                    style: TextStyle(fontFamily: 'Quicksand', fontSize: 14),
                  ),
                ),

                // Ô nhập mã xác nhận
                const MyConfirmText(),

                const SizedBox(
                  height: 20,
                ),

                MyButton(text: "Xác nhận", onTap: login)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
