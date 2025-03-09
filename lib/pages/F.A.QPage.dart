import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/data/model/F.A.Q.dart';
import 'package:foodapp/data/repository/repository.dart';

class FAQScreen extends StatefulWidget {
  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  late List<FAQ>? faqList = [];
//   final List<Map<String, String>> faqs = [
//     {
//       "question":
//           "1. Tại sao Quý khách hàng nên chọn người giúp việc thông qua HomeKare?",
//       "answer": """
// Những lý do sau đây sẽ giúp cho quý khách hàng giải đáp được thắc mắc trên:
//
// - Người giúp việc là nhân viên của ProCleaner, chịu sự quản lý và chấp hành nội quy của Công ty nên Quý khách hàng không cần lo lắng về việc quản lý Người giúp việc.
//
// - Người giúp việc có lý lịch nhân thân rõ ràng, có giấy chứng nhận sức khỏe của bệnh viện.
//
// - Quý khách hàng sẽ luôn có Người giúp việc ổn định trong suốt thời gian hợp đồng.
//
// - Quý khách hàng được ProCleaner chịu trách nhiệm vật chất nếu có thất thoát xảy ra do người giúp việc.
//
// - ProCleaner xếp hạng nhân viên thông qua đánh giá của khách hàng nên luôn đảm bảo chất lượng Người giúp việc.
//   """
//     },
//     {
//       "question": "2. Liên hệ với HomeKare như thế nào?",
//       "answer":
//           "Vui lòng gọi số: 08.3930.5057 08.3930.5058 hoặc gửi email đến địa chỉ: cs@procleaner.vn"
//     },
//     {
//       "question":
//           "3. Ứng dụng ProCleaner đòi các quyền truy cập (permission) để làm gì?",
//       "answer":
//           """Ứng dụng ProCleaner khi cài đặt sẽ sử dụng các quyền truy cập sau đây:
//
// - Vị trí người dùng: Giúp ứng dụng tìm vị trí hiện tại của người dùng để thiết lập địa điểm phục vụ dễ dàng hơn.
//
// - SMS: Giúp ứng dụng tự động điền mã kích hoạt tài khoản mà không cần phải vào ứng dụng tin nhắn.
//
// - Điện thoại: Giúp khách hàng khi click vào số điện thoại thì có thể gọi ngay cho ProCleaner.
//
// - Ảnh/phương tiện/tệp: ProCleaner lưu lại một số hình ảnh ít thay đổi để giúp ứng dụng chạy nhanh hơn.
//
// - Lịch sử ứng dụng và thiết bị: ProCleaner sẽ tự động ghi nhận những trường hợp chạy ứng dụng bị lỗi tạo điều kiện cho nhóm phát triển nâng cao chất lượng ứng dụng.
//
// - Quyền truy cập mạng: ProCleaner là ứng dụng cần kết nối mạng để có thể hoạt động.
//
// - Nhận dạng: ProCleaner sử dụng nhận dạng để gửi thông tin trạng thái Yêu cầu cho người dùng thông qua trung tâm thông báo của điện thoại.
//
// - Các quyền truy cập còn lại ProCleaner dùng để ghi nhận thói quen sử dụng của người dùng nhằm giúp nhóm phát triển liên tục cải tiến ứng dụng để phục vụ người sử dụng tốt hơn."""
//     },
//     {
//       "question": "4. Tại sao phải đánh giá người giúp việc?",
//       "answer":
//           "Đánh giá người giúp việc vừa là quyền lợi vừa là trách nhiệm của Quý khách hàng. Việc này giúp cho Công ty đánh giá chính xác hơn về chất lượng công việc mà nhân viên chúng tôi đang mang đến phục vụ Quý khách, đồng thời giúp chúng tôi có cơ sở để xác nhận với Quý khách hàng rằng chúng tôi đã mang đến cho Quý khách một dịch vụ đúng như cam kết."
//     },
//     {
//       "question": "5. Làm thế nào để sử dụng dịch vụ của HomeKare?",
//       "answer":
//           """• Đặt yêu cầu trực tiếp hoặc bằng ứng dụng ProCleaner trên smartphone hoặc thông qua website ProCleaner.vn.
//
//     • Liên hệ với chúng tôi:
//
//     Điện thoại: 08.3930.5057 08.3930.5058
//     Email: cs@procleaner.vn
//     Đến Trụ sở: 216 Nguyễn Thị Minh Khai, Phường 6, Quận 3, TP. HCM"""
//     },
//     {
//       "question": "6. Hình thức thanh toán phí sử dụng dịch vụ như thế nào?",
//       "answer":
//           """• Quý khách hàng thanh toán tiền phí sử dụng dịch theo từng tháng nếu là hợp đồng dài hạn hoặc ngay khi kết thúc thời gian sử dụng dịch vụ nếu là hợp đồng ngắn hạn (dưới một tháng).
//
// • Quý khách hàng thanh toán bằng tiền mặt cho nhân viên do Công ty chỉ định theo giấy giới thiệu của Công ty."""
//     },
//     {
//       "question": "7. Có cần phải ký hợp đồng giúp việc không?",
//       "answer":
//           """• Để thuận tiện cho Quý khách hàng, chúng tôi đã ghi sẵn các điều khoản trong mục “CHÍNH SÁCH” trên website Công ty (ProCleaner.vn). Khi Quý khách hàng đặt yêu cầu sử dụng dịch vụ của Công ty, thì mặc nhiên là đã đọc và đồng ý tất cả các điều khoản này.
//
// • Nếu Quý khách hàng cần ký hợp đồng, Công ty chúng tôi sẽ tư vấn và gửi đến Quý khách hàng từng hợp đồng riêng cho từng trường hợp cụ thể."""
//     },
//     {
//       "question": "8. Có được đổi người giúp việc không?",
//       "answer":
//           """Quý khách có toàn quyền yêu cầu thay đổi người giúp việc nhưng phải báo trước cho Công ty trước 24h của buổi làm đó."""
//     },
//     {
//       "question": "9. Người giúp việc có thu tiền mặt của khách hàng không?",
//       "answer":
//           """Việc thu tiền sẽ do nhân viên có giấy giới thiệu của Công ty đến thu. Người giúp việc sẽ không được phép thu tiền mặt của Quý khách hàng ngoại trừ đơn hàng yêu cầu dịch vụ dưới 1 tuần. Khi đó Người giúp việc cũng phải có giấy giới thiệu của Công ty thì mới được phép thu tiền của Quý khách hàng."""
//     },
//     {
//       "question":
//           "10. Thời gian từ lúc đặt yêu cầu đến lúc có người giúp việc tối thiểu là bao lâu?",
//       "answer":
//           """Để chúng tôi có thể sắp xếp Người giúp việc cho Quý khách hàng một cách thuận lợi, thời gian mà Người giúp việc của Công ty có thể đến phục vụ yêu cầu của Quý khách tối thiểu là 03 (ba) giờ đồng hồ kể từ lúc Quý khách đặt yêu cầu."""
//     },
//     {
//       "question":
//           "11. Thời gian phục vụ của người giúp việc bắt đầu và kết thúc khi nào?",
//       "answer":
//           """Việc thu tiền sẽ do nhân viên có giấy giới thiệu của Công ty đến thu. Người giúp việc sẽ không được phép thu tiền mặt của Quý khách hàng ngoại trừ đơn hàng yêu cầu dịch vụ dưới 1 tuần. Khi đó Người giúp việc cũng phải có giấy giới thiệu của Công ty thì mới được phép thu tiền của Quý khách hàng."""
//     },
//     {
//       "question": "12. Giá dịch vụ có tăng trong thời điểm Tết hay không?",
//       "answer":
//           """Việc Đối với những ngày thường hay ngày Tết lượng Khách hàng đăng ký sử dụng dịch vụ đang tăng lên rất nhanh nhưng với phương châm phục vụ Khách hàng đặt chất lượng lên hàng đầu, trở thành Khách hàng thường xuyên và gắn bó với Công ty thì ProCleaner vẫn giữ giá dịch vụ như cũ đối với tất cả các dịch vụ. Trừ những Khách hàng có nhu cầu sử dụng trong khoảng thời gian Công ty nghỉ Tết Nguyên Đán bắt đâu từ 30 Tết – hết mùng 4 Tết thì giá dịch vụ sẽ tính 300% so với ngày thường theo quy định Luật lao động của Việt Nam."""
//     },
//     {
//       "question": "13. ProCleaner cung cấp dịch vụ ở những nơi nào?",
//       "answer":
//           """Công ty chúng tôi cung cấp dịch vụ ở tất cả các Quận trong địa bàn Thành phố Hồ Chí Minh."""
//     },
//     {
//       "question":
//           "14. Chất lượng người giúp việc của ProCleaner được đảm bảo như thế nào?",
//       "answer":
//           """Chúng tôi có một quy trình tuyển dùng và đạo tạo người giúp việc chuyên nhiệp từ khâu tìm kiếm nguồn lực người giúp việc, lựa chọn tuyển dùng và đào tạo đến khâu điều phối người giúp việc phù hợp với từng đối tượng khách hàng. Điều đó giúp chúng tôi có thể tự tin để mang để cho Quý khách hàng những dịch vụ với chất lượng cao nhất. Ngoải ra, chúng tôi cũng thiết kế các kênh liên lạc một cách linh động nhất để Quý khách có thể trao đổi trực tiếp với Công ty về chất lượng dịch vụ và con người mà Công ty chúng tôi đang mang đến cho Quý khách. Điều này giúp chúng tôi có thể lắng nghe phản ánh của Quý khách một cách nhanh chóng, chính xác và đầy đủ nhất để có thể ngày một nâng cao chất lượng dịch vụ mà chúng tôi mong muốn mang đến cho Quý khách, làm cho cuộc sống của Quý khách ngày càng tiện lợi hơn."""
//     },
//   ];

// Danh sách trạng thái mở rộng của từng ExpansionTile
  final List<Map<String, String>> faqs = [];
  List<bool> isOpenList = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    var repository = DefaultRepository();
    var data = await repository.loadFAQ();
    setState(() {
      faqList = data ?? [];
      faqs.addAll(faqList!
          .map((faq) => {"question": faq.question, "answer": faq.answer})
          .toList());
    });
    isOpenList = List.generate(faqs.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Câu hỏi thường gặp",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Quicksand',
              )),
          backgroundColor: Colors.green,
          iconTheme: IconThemeData(color: Colors.white)),
      backgroundColor: Colors.grey.shade50,
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 1,
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
              ),
              child: ExpansionTile(
                title: Text(
                  faqs[index]["question"]!,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Quicksand',
                    fontSize: 16,
                  ),
                ),
                // Màu nền khi mở rộng
                backgroundColor: Colors.blue.shade50,
                textColor: Colors.green,
                // Màu nền khi đóng
                collapsedBackgroundColor: Colors.white,
                // Bo góc
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                // Trạng thái ban đầu
                initiallyExpanded: isOpenList[index],

                trailing: AnimatedSwitcher(
                  duration: Duration(milliseconds: 600),
                  transitionBuilder: (child, animation) {
                    return RotationTransition(turns: animation, child: child);
                  },
                  child: isOpenList[index]
                      ? Icon(
                          Icons.remove,
                          key: ValueKey('open'),
                          color: Colors.green,
                        )
                      : Icon(Icons.add, key: ValueKey('closed')),
                ),
                onExpansionChanged: (isOpen) {
                  setState(() {
                    isOpenList[index] = isOpen;
                  });
                },
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      faqs[index]["answer"]!,
                      style: TextStyle(
                        color: Colors.black87,
                        fontFamily: 'Quicksand',
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
