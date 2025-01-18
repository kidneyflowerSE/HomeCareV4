// import 'package:flutter/material.dart';
// import 'package:foodapp/auth/login_or_register.dart';
// import 'package:foodapp/themes/theme_provider.dart';
// import 'package:provider/provider.dart';

// void main() {
//   runApp(
//     MultiProvider(
//       providers: [
//         // theme provider
//         ChangeNotifierProvider(create: (context) => ThemeProvider()),
//       ],
//       child: const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: const LoginOrRegister(),
//       theme: Provider.of<ThemeProvider>(context).themeData,
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:foodapp/data/model/message.dart';

import 'package:provider/provider.dart';
import 'package:foodapp/auth/login_or_register.dart';
import 'package:foodapp/components/delay_animation.dart';
import 'package:foodapp/themes/theme_provider.dart';

import 'data/repository/repository.dart';

void main() => runApp(
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        child: const MyApp(),
      ),
    );

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
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        theme: context.watch<ThemeProvider>().themeData,
      );
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _navigateAfterDelay());
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 5));
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginOrRegister()),
      );
    }
  }

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Center(child: DelayAnimation(loadingDuration: Duration(seconds: 1),)),
      );
}
