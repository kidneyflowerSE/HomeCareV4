import 'package:flutter/material.dart';

class MessDetailComponent extends StatefulWidget {
  final String name;
  final String message;
  final String image;

  const MessDetailComponent({
    super.key,
    required this.name,
    required this.message,
    required this.image,
  });

  @override
  State<MessDetailComponent> createState() => _MessDetailComponentState();
}

class _MessDetailComponentState extends State<MessDetailComponent> {
  // function to send message
  final TextEditingController _messageController = TextEditingController();
  final List<String> _messages = [];

  void _sendMessage() {
    final messageText = _messageController.text;
    if (messageText.isNotEmpty) {
      setState(() {
        _messages.add(messageText);
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 80,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                widget.image,
                height: 40,
                width: 40,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              widget.name,
              style: const TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'block') {
                // ignore: avoid_print
                print('User blocked');
              } else if (value == 'cancel') {
                // ignore: avoid_print
                print('Action canceled');
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 'block',
                  child: Text(
                    'Chặn người giúp việc này',
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 14,
                    ),
                  ),
                ),
                const PopupMenuItem(
                  value: 'love',
                  child: Text(
                    'Thêm vào danh sách yêu thích',
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 14,
                    ),
                  ),
                ),
                const PopupMenuItem(
                  value: 'cancel',
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 14,
                    ),
                  ),
                ),
              ];
            },
            icon: const Icon(Icons.more_vert_rounded),
          ),
        ],
      ),
      // Cho bố cục không bị che khi bàn phím hiện lên
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 15.0,
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      _messages[index],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Aa',
                      hintStyle: TextStyle(
                        fontFamily: 'Quicksand',
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w400,
                      ),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 236, 232, 232),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.send),
                  color: Colors.green,
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
