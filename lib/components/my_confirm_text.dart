import 'package:flutter/material.dart';

class MyConfirmText extends StatefulWidget {
  final Function(String) onCodeChanged; // Thêm callback để truyền giá trị ra ngoài

  const MyConfirmText({super.key, required this.onCodeChanged});

  @override
  State<MyConfirmText> createState() => _MyConfirmTextState();
}

class _MyConfirmTextState extends State<MyConfirmText> {
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  final List<TextEditingController> _controllers =
  List.generate(6, (_) => TextEditingController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNodes[0]);
    });
  }

  @override
  void dispose() {
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _updateCode() {
    // Gộp tất cả giá trị từ 6 ô thành 1 chuỗi
    String code = _controllers.map((c) => c.text).join();
    widget.onCodeChanged(code); // Gửi mã code ra ngoài
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
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                maxLength: 1,
                decoration: InputDecoration(
                  counterText: "",
                  filled: true,
                  fillColor: Colors.green[100],
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Colors.green,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 3,
                    ),
                  ),
                ),
                onChanged: (value) {
                  _updateCode(); // Gọi khi có thay đổi

                  // Tự động focus sang ô tiếp theo
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
