// import 'package:flutter/material.dart';

// class MyTextField extends StatelessWidget {
//   final TextEditingController controller;
//   final String hintText;
//   final bool obscureText;
//   final IconData? emailIcon;
//   final IconData? lockIcon;

//   const MyTextField({
//     super.key,
//     required this.controller,
//     required this.hintText,
//     required this.obscureText,
//     this.emailIcon,
//     this.lockIcon,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 25),
//       child: TextField(
//         controller: controller,
//         obscureText: obscureText,
//         decoration: InputDecoration(
//           hintText: hintText,
//           hintStyle: TextStyle(
//               color: Colors.grey[600],
//               fontSize: 16,
//               fontStyle: FontStyle.italic,
//               fontFamily: 'Quicksand'),
//           prefixIcon: emailIcon != null
//               ? Icon(
//                   emailIcon,
//                   color: Colors.yellow,
//                   size: 30,
//                 )
//               : lockIcon != null
//                   ? Icon(lockIcon, color: Colors.yellow, size: 30)
//                   : null,
//           enabledBorder: const UnderlineInputBorder(
//               borderSide: BorderSide(color: Colors.grey)),
//           focusedBorder: const UnderlineInputBorder(
//               borderSide: BorderSide(color: Colors.black)),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey), // Viền ngoài
          borderRadius: BorderRadius.circular(8), // Bo góc
        ),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
                fontStyle: FontStyle.italic,
                fontFamily: 'Quicksand',
              ),
              border: InputBorder.none, // Không viền bên trong
              contentPadding: const EdgeInsets.only(left: 10)),
        ),
      ),
    );
  }
}
