// import 'package:flutter/material.dart';

// class MyConfirmText extends StatelessWidget {
//   const MyConfirmText({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//             child: Container(
//               height: 50,
//               margin: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: Colors.green,
//                 borderRadius: BorderRadius.circular(16)
//               ),
//             ),
//           ),

//           Expanded(
//             child: Container(
//               height: 50,
//               margin: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: Colors.green,
//                 borderRadius: BorderRadius.circular(16)
//               ),
//             ),
//           ),

//           Expanded(
//             child: Container(
//               height: 50,
//               margin: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: Colors.green,
//                 borderRadius: BorderRadius.circular(16)
//               ),
//             ),
//           ),

//           Expanded(
//             child: Container(
//               height: 50,
//               margin: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: Colors.green,
//                 borderRadius: BorderRadius.circular(16)
//               ),
//             ),
//           ),

//           Expanded(
//             child: Container(
//               height: 50,
//               margin: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: Colors.green,
//                 borderRadius: BorderRadius.circular(16)
//               ),
//             ),
//           ),

//           Expanded(
//             child: Container(
//               height: 50,
//               margin: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: Colors.green,
//                 borderRadius: BorderRadius.circular(16)
//               ),
//             ),
//           ),

//         ],
//       )
//     );
//   }
// }

import 'package:flutter/material.dart';

class MyConfirmText extends StatefulWidget {
  const MyConfirmText({super.key});

  @override
  State<MyConfirmText> createState() => _MyConfirmTextState();
}

class _MyConfirmTextState extends State<MyConfirmText> {
  // Tạo danh sách các FocusNode để kiểm soát các TextField
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());

  @override
  void initState() {
    super.initState();
    // Tự động focus vào ô đầu tiên khi khởi động
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNodes[0]);
    });
  }

  @override
  void dispose() {
    // Hủy các FocusNode khi không còn sử dụng
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(6, (index) {
          return Expanded(
            child: Container(
              margin: const EdgeInsets.all(8),
              child: TextField(
                style: const TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 16,
                    fontWeight: FontWeight.w800),
                controller: _controllers[index],
                focusNode: _focusNodes[index],
                textAlign: TextAlign.center, // Căn giữa text
                keyboardType: TextInputType.number, // Chỉ cho phép nhập số
                maxLength: 1, // Chỉ cho phép nhập 1 ký tự
                decoration: InputDecoration(
                  counterText: "", // Ẩn bộ đếm số ký tự
                  filled: true,
                  fillColor: Colors.green[100], // Màu nền của ô
                  // Viền khi không focus
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Colors.green, // Màu viền không focus
                      width: 2, // Độ dày viền không focus
                    ),
                  ),
                  // Viền khi focus
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 0, 0, 0), // Màu viền khi focus
                      width: 3, // Độ dày viền khi focus
                    ),
                  ),
                ),
                onChanged: (value) {
                  // Khi người dùng nhập một ký tự
                  if (value.isNotEmpty && index < 5) {
                    FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
                  }
                  if (value.isEmpty && index > 0) {
                    FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
                  }
                },
              ),
            ),
          );
        }),
      ),
    );
  }
}
