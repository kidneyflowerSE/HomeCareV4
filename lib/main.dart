import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:foodapp/auth/login_or_register.dart';
import 'package:foodapp/components/spashscreen.dart';
import 'package:foodapp/themes/theme_provider.dart';

import 'components/request_provider.dart';
import 'data/repository/repository.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => RequestProvider()), // Thêm provider mới
      ],
      child: const MyApp(),
    ),
  );
}

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   var repository = DefaultRepository();
//   // try {
//   //   debugPrint('Sending message...');
//   //   await repository.sendMessage('0795335321');
//   //   debugPrint('Message sent!');
//   // } catch (e) {
//   //   debugPrint('Error in main: $e');
//   // }
//   // var customers = await repository.loadMessage(Message(phone: '0795335321'));
//
//   var customers = await repository.loadServices();
//   if(customers != null){
//     for(var customer in customers){
//       debugPrint(customer.toString());
//     }
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: context.watch<ThemeProvider>().themeData,
      home: const SplashScreen(),
    );
  }
}
