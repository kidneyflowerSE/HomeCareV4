import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:foodapp/auth/login_or_register.dart';
import 'package:foodapp/components/spashscreen.dart';
import 'package:foodapp/themes/theme_provider.dart';

import 'data/repository/repository.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
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
//   var customers = await repository.loadCustomer();
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
