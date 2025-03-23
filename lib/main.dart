import 'package:flutter/material.dart';
import 'package:foodapp/data/model/request.dart';
import 'package:foodapp/data/model/service.dart';
import 'package:provider/provider.dart';
import 'package:foodapp/auth/login_or_register.dart';
import 'package:foodapp/components/spashscreen.dart';
import 'package:foodapp/themes/theme_provider.dart';

import 'components/request_provider.dart';
import 'data/repository/repository.dart';

// void main() {
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (context) => ThemeProvider()),
//         ChangeNotifierProvider(create: (context) => RequestProvider()), // Thêm provider mới
//       ],
//       child: const MyApp(),
//     ),
//   );
// }
//
// // Future<void> main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   var repository = DefaultRepository();
// //
// //   // var request = Requests(
// //   //     customerInfo: CustomerInfo(fullName: 'Quốc An Nguyễn',
// //   //         phone: '0908123675',
// //   //         address: "abc",
// //   //         usedPoint: 0),
// //   //     service: RequestService(title: "Rửa bát",
// //   //         coefficientService: 1.0,
// //   //         coefficientOther: 1.0,
// //   //         cost: 20000),
// //   //     location: RequestLocation(province: 'hcm', district: 'q1', ward: 'p1'),
// //   //     id: '',
// //   //     oderDate: "2025-03-03",
// //   //     scheduleIds: [],
// //   //     startTime: "06:00",
// //   //     endTime: "10:00",
// //   //     requestType: 'Ngắn hạn',
// //   //     totalCost: 0,
// //   //     status: '',
// //   //     deleted: false,
// //   //     comment: Comment(review: '', loseThings: false, breakThings: false),
// //   //     profit: 0, startDate: "2025-03-03");
// //   //
// //   // List<String> ids = ['67ca5f695e4280bfc267587d,'];
// //   var customers = await repository.doneConfirmRequest('67c694777c8f836e8dcc6567');
// //
// //   // var totalCost = await repository.calculateCost(20000,
// //   //     request, customers!, 1.1);
// //   // print(totalCost);
// //   // print(customers?.first.coefficientList.toString());
// //
// //   // if(customers != null){
// //   //   for(var customer in customers){
// //   //     debugPrint(customer.toString());
// //   //   }
// //   // }
// // }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: context
//           .watch<ThemeProvider>()
//           .themeData,
//       home: const SplashScreen(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late IOWebSocketChannel channel;
  String message = "Chưa có tin nhắn";

  @override
  void initState() {
    super.initState();

    // Kết nối đến WebSocket Server
    channel = IOWebSocketChannel.connect('ws://10.0.2.2:8080');

    print("🔗 Đang kết nối đến WebSocket...");

    // Lắng nghe message từ server
    channel.stream.listen(
            (data) {
          setState(() {
            message = data;
          });
          print("📩 Tin nhắn nhận được từ server: $data");
        },
        onDone: () {
          print("✅ Kết nối WebSocket thành công!");
        },
        onError: (error) {
          print("❌ Lỗi kết nối WebSocket: $error");
        }
    );
  }

  void sendMessage() {
    channel.sink.add("Hello from Flutter");
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("WebSocket Flutter")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Message từ server: $message"),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: sendMessage,
                child: Text("Gửi message đến server"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

