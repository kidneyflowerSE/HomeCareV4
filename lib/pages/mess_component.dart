import 'package:flutter/material.dart';
import 'package:foodapp/pages/mess_detail_component.dart';

class MessComponent extends StatelessWidget {
  const MessComponent({super.key});

  @override
  Widget build(BuildContext context) {
    // Danh sách thông tin các thành viên
    final List<Map<String, String>> members = [
      {
        'name': 'Pham Nguyen Quoc Huy',
        'message': 'Chúc mừng bạn đã giành được Voucher của chương trình',
        'image': 'lib/images/staff/anhhuy.jpg'
      },
      {
        'name': 'Pham Minh Duc',
        'message': 'Chúc mừng bạn đã giành được Voucher của chương trình',
        'image': 'lib/images/staff/anhduc.jpg'
      },
      {
        'name': 'Tran Phi Hung',
        'message': 'Mày lây bệnh cho tao',
        'image': 'lib/images/staff/anhhung.jpg'
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      itemCount: members.length,
      itemBuilder: (context, index) {
        final member = members[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MessDetailComponent(
                  name: member['name']!,
                  message: member['message']!,
                  image: member['image']!,
                ),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    member['image']!,
                    height: 60,
                    width: 60,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        member['name']!,
                        style: const TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "Bạn: ${member['message']}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: true,
                        style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: 13,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
