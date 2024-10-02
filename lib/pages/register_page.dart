// import 'package:flutter/material.dart';
// import 'package:foodapp/components/my_button.dart';
// import 'package:foodapp/components/my_textfield.dart';
// import 'package:foodapp/pages/authen_page.dart';

// class RegisterPage extends StatefulWidget {
//   final void Function()? onTap;

//   const RegisterPage({
//     super.key,
//     required this.onTap,
//   });

//   @override
//   State<RegisterPage> createState() => _RegisterPageState();
// }

// class _RegisterPageState extends State<RegisterPage> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmController = TextEditingController();

//   void authen() {
//     /*
//     Fill out authentication here
//     */

//     // Navigate to authentication page
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => AuthenPage(onTap: () {}),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       resizeToAvoidBottomInset:
//           false, // Prevents the Stack from resizing when the keyboard appears
//       body: Stack(
//         children: [
//           // Background with circles
//           Positioned(
//             left: 0,
//             top: -70,
//             child: ClipRect(
//               child: Align(
//                 alignment: Alignment.topLeft,
//                 widthFactor: 1.0,
//                 child: Container(
//                   width: 120,
//                   height: 120,
//                   decoration: const BoxDecoration(
//                     color: Color(0xFF8cbe3d),
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             left: -80,
//             top: -30,
//             child: ClipRect(
//               child: Align(
//                 alignment: Alignment.topLeft,
//                 widthFactor: 1.0,
//                 child: Container(
//                   width: 150,
//                   height: 150,
//                   decoration: const BoxDecoration(
//                     color: Color(0xFF02571c),
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             right: 0,
//             bottom: -70,
//             child: ClipRect(
//               child: Align(
//                 alignment: Alignment.bottomRight,
//                 widthFactor: 1.0,
//                 child: Container(
//                   width: 120,
//                   height: 120,
//                   decoration: const BoxDecoration(
//                     color: Color(0xFF8cbe3d),
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             right: -80,
//             bottom: -30,
//             child: ClipRect(
//               child: Align(
//                 alignment: Alignment.bottomRight,
//                 widthFactor: 1.0,
//                 child: Container(
//                   width: 150,
//                   height: 150,
//                   decoration: const BoxDecoration(
//                     color: Color(0xFF02571c),
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           // Main content
//           Padding(
//             padding: const EdgeInsets.only(top: 45),
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   // Logo
//                   Image.asset(
//                     './lib/images/logo.png',
//                     width: 220,
//                     height: 220,
//                   ),

//                   const SizedBox(height: 10),

//                   // Message
//                   const Text(
//                     "Bắt đầu tạo tài khoản",
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontFamily: 'Quicksand',
//                       color: Color.fromARGB(255, 69, 69, 69),
//                     ),
//                   ),

//                   const SizedBox(height: 25),

//                   // Email text field
//                   MyTextfield(
//                     controller: emailController,
//                     hintText: "Nhập email hoặc số điện thoại",
//                     obscureText: false,
//                     // emailIcon: Icons.email_outlined,
//                   ),

//                   // const SizedBox(height: 10),

//                   // Password text field
//                   // MyTextfield(
//                   //   controller: passwordController,
//                   //   hintText: "Password",
//                   //   obscureText: true,
//                   // ),

//                   // const SizedBox(height: 10),

//                   // Confirm password text field
//                   // MyTextfield(
//                   //   controller: confirmController,
//                   //   hintText: "Confirm Password",
//                   //   obscureText: true,
//                   // ),

//                   const SizedBox(height: 25),

//                   // Sign up button
//                   MyButton(text: "Lấy mã xác thực", onTap: authen),

//                   const SizedBox(height: 10),

//                   // Already have an account?
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Đã có tài khoản?",
//                         style: TextStyle(
//                           color: Theme.of(context).colorScheme.inversePrimary,
//                           fontFamily: 'Quicksand',
//                           fontSize: 16,
//                         ),
//                       ),
//                       const SizedBox(width: 4),
//                       GestureDetector(
//                         onTap: widget.onTap,
//                         child: const Text(
//                           "Đăng nhập",
//                           style: TextStyle(
//                             color: Colors.red,
//                             fontFamily: 'Quicksand',
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                             fontStyle: FontStyle.italic,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:foodapp/components/my_button.dart';
import 'package:foodapp/components/my_textfield.dart';
import 'package:foodapp/pages/authen_page.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({
    super.key,
    required this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  void authen() {
    /*

    fill out authentication here
    */

    // navigate to home page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AuThenPage(
          onTap: () {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Nền với các hình tròn
          Positioned(
            left: 0,
            top: -70,
            child: ClipRect(
              child: Align(
                alignment: Alignment.topLeft,
                widthFactor: 1.0,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: const BoxDecoration(
                    color: Colors.yellow,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: -80,
            top: -30,
            child: ClipRect(
              child: Align(
                alignment: Alignment.topLeft,
                widthFactor: 1.0,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: -70,
            child: ClipRect(
              child: Align(
                alignment: Alignment.bottomRight,
                widthFactor: 1.0,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: const BoxDecoration(
                    color: Colors.yellow,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: -80,
            bottom: -30,
            child: ClipRect(
              child: Align(
                alignment: Alignment.bottomRight,
                widthFactor: 1.0,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 45),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // logo
                  Image.asset(
                    'lib/images/logo.png',
                    width: 220,
                    height: 220,
                  ),

                  const SizedBox(height: 10),

                  // message, app slogan
                  const Text(
                    "Bắt đầu tạo tài khoản",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Quicksand',
                      color: Color.fromARGB(255, 69, 69, 69),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // email textfield
                  MyTextField(
                    controller: emailController,
                    hintText: "Nhập email hoặc số điện thoại",
                    obscureText: false,
                    // emailIcon: Icons.email_outlined,
                  ),

                  // const SizedBox(height: 10),

                  // // password textfield
                  // MyTextfield(
                  //   controller: passwordController,
                  //   hintText: "Password",
                  //   obscureText: true,
                  // ),

                  // const SizedBox(height: 10),

                  // // password textfield
                  // MyTextfield(
                  //   controller: confirmController,
                  //   hintText: "Confirm Password",
                  //   obscureText: true,
                  // ),

                  const SizedBox(height: 25),

                  // sign up button
                  MyButton(text: "Lấy mã xác thực", onTap: authen),

                  const SizedBox(height: 10),

                  // already have an account ? Login here
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Đã có tài khoản?",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Quicksand',
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          "Đăng nhập",
                          style: TextStyle(
                            color: Colors.red,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
