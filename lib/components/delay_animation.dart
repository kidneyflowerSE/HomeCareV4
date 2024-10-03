// import 'package:flutter/material.dart';
// import 'dart:ui' as ui;
// import 'package:flutter/services.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
//   late AnimationController _controllerLine;
//   late AnimationController _controllerLa1;
//   late AnimationController _controllerLa2;
//   late AnimationController _controllerLa3;
//   late AnimationController _controllerLa4;
//   late AnimationController _controllerHomecare;
//   late AnimationController _controllerHand;

//   late Animation<Offset> _homecareSlideAnimation;
//   late Animation<Offset> _handSlideAnimation;

//   ui.Image? _homeImage, _lineImage, _la1Image, _la2Image, _la3Image, _la4Image;
//   ui.Image? _homecareImage, _handImage;

//   @override
//   void initState() {
//     super.initState();
//     _controllerLine = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 1),
//     );
//     _controllerLa1 = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 1),
//     );
//     _controllerLa2 = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 1),
//     );
//     _controllerLa3 = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 1),
//     );
//     _controllerLa4 = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 1),
//     );
//     _controllerHomecare = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 500),
//     );
//     _controllerHand = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 1),
//     );

//     // Animation trượt từ trên xuống cho homecare
//     _homecareSlideAnimation = Tween<Offset>(
//       begin: const Offset(0, -2), // Trượt từ trên xuống
//       end: Offset.zero,
//     ).animate(CurvedAnimation(
//       parent: _controllerHomecare,
//       curve: Curves.easeInOut,
//     ));

//     // Animation trượt từ trái sang cho hand
//     _handSlideAnimation = Tween<Offset>(
//       begin: const Offset(-1, 0), // Trượt từ trái sang
//       end: Offset.zero,
//     ).animate(CurvedAnimation(
//       parent: _controllerHand,
//       curve: Curves.easeInOut,
//     ));

//     _loadImages(); // Load tất cả các ảnh
//   }

//   Future<void> _loadImages() async {
//     _homeImage = await _loadImage('lib/img/home.png');
//     _lineImage = await _loadImage('lib/img/line.png');
//     _la1Image = await _loadImage('lib/img/la1.png');
//     _la2Image = await _loadImage('lib/img/la2.png');
//     _la3Image = await _loadImage('lib/img/la3.png');
//     _la4Image = await _loadImage('lib/img/la4.png');
//     _homecareImage = await _loadImage('lib/img/homecare.png');
//     _handImage = await _loadImage('lib/img/hand.png');

//     // Sau khi ảnh được tải, bắt đầu các animation theo thứ tự
//     setState(() {
//       _controllerLine.forward().then((_) {
//         _controllerLa1.forward().then((_) {
//           _controllerLa2.forward().then((_) {
//             _controllerLa3.forward().then((_) {
//               _controllerLa4.forward().then((_) {
//                 _controllerHomecare.forward().then((_) {
//                   _controllerHand.forward(); // Cuối cùng là hand
//                 });
//               });
//             });
//           });
//         });
//       });
//     });
//   }

//   Future<ui.Image> _loadImage(String assetPath) async {
//     final ByteData data = await rootBundle.load(assetPath);
//     final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
//     final frame = await codec.getNextFrame();
//     return frame.image;
//   }

//   @override
//   void dispose() {
//     _controllerLine.dispose();
//     _controllerLa1.dispose();
//     _controllerLa2.dispose();
//     _controllerLa3.dispose();
//     _controllerLa4.dispose();
//     _controllerHomecare.dispose();
//     _controllerHand.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             if (_homeImage != null)
//               CustomPaint(
//                 painter: ImagePainter(
//                     _homeImage!, Offset.zero, 0.4), // Chỉnh scale về 0.4
//                 size: Size(_homeImage!.width.toDouble() * 0.4,
//                     _homeImage!.height.toDouble() * 0.4),
//               ),
//             _buildAnimatedImage(_lineImage, _controllerLine),
//             _buildAnimatedImage(_la1Image, _controllerLa1),
//             _buildAnimatedImage(_la2Image, _controllerLa2),
//             _buildAnimatedImage(_la3Image, _controllerLa3),
//             _buildAnimatedImage(_la4Image, _controllerLa4),
//             _buildSlideTransition(_homecareImage, _homecareSlideAnimation),
//             _buildSlideTransition(_handImage, _handSlideAnimation),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildAnimatedImage(ui.Image? image, AnimationController controller) {
//     return AnimatedBuilder(
//       animation: controller,
//       builder: (context, child) {
//         return image == null
//             ? const SizedBox()
//             : RotationTransition(
//                 turns: Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
//                     parent: controller, curve: Curves.easeInOut)),
//                 child: ScaleTransition(
//                   scale: Tween<double>(begin: 0, end: 1).animate(
//                       CurvedAnimation(
//                           parent: controller, curve: Curves.easeOutBack)),
//                   child: CustomPaint(
//                     painter: ImagePainter(
//                         image, Offset.zero, 0.4), // Chỉnh scale về 0.4
//                     size: Size(image.width.toDouble() * 0.4,
//                         image.height.toDouble() * 0.4),
//                   ),
//                 ),
//               );
//       },
//     );
//   }

//   Widget _buildSlideTransition(ui.Image? image, Animation<Offset> animation) {
//     return SlideTransition(
//       position: animation,
//       child: image == null
//           ? const SizedBox()
//           : CustomPaint(
//               painter:
//                   ImagePainter(image, Offset.zero, 0.4), // Chỉnh scale về 0.4
//               size: Size(
//                   image.width.toDouble() * 0.4, image.height.toDouble() * 0.4),
//             ),
//     );
//   }
// }

// class ImagePainter extends CustomPainter {
//   final ui.Image image;
//   final Offset offset;
//   final double scaleFactor;

//   ImagePainter(this.image, this.offset, this.scaleFactor);

//   @override
//   void paint(Canvas canvas, Size size) {
//     // Vẽ ảnh ở giữa canvas với offset
//     final double scaledWidth = image.width.toDouble() * scaleFactor;
//     final double scaledHeight = image.height.toDouble() * scaleFactor;

//     final Offset center = Offset(
//       (size.width - scaledWidth) / 2 + offset.dx,
//       (size.height - scaledHeight) / 2 + offset.dy,
//     );
//     canvas.save();
//     canvas.scale(scaleFactor); // Giảm kích thước ảnh
//     canvas.drawImage(image, center, Paint());
//     canvas.restore();
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }

import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

class DelayAnimation extends StatefulWidget {
  final Duration loadingDuration;
  const DelayAnimation({super.key, required this.loadingDuration});

  @override
  // ignore: library_private_types_in_public_api
  _DelayAnimationState createState() => _DelayAnimationState();
}

class _DelayAnimationState extends State<DelayAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controllerLine;
  late AnimationController _controllerLa1;
  late AnimationController _controllerLa2;
  late AnimationController _controllerLa3;
  late AnimationController _controllerLa4;
  late AnimationController _controllerHomecare;
  late AnimationController _controllerHand;

  late Animation<Offset> _homecareSlideAnimation;
  late Animation<double> _homecareFadeAnimation;
  late Animation<Offset> _handSlideAnimation;

  ui.Image? _homeImage, _lineImage, _la1Image, _la2Image, _la3Image, _la4Image;
  ui.Image? _homecareImage, _handImage;

  @override
  void initState() {
    super.initState();
    _controllerLine = AnimationController(
      vsync: this,
      duration: widget.loadingDuration,
    );
    _controllerLa1 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _controllerLa2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _controllerLa3 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _controllerLa4 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _controllerHomecare = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _controllerHand = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    // Animation trượt từ trên xuống cho homecare
    _homecareSlideAnimation = Tween<Offset>(
      begin: const Offset(0, -2), // Trượt từ trên xuống
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controllerHomecare,
      curve: Curves.easeInOut,
    ));

    // Animation fade cho homecare
    _homecareFadeAnimation = Tween<double>(begin: -4, end: 1).animate(
      CurvedAnimation(
        parent: _controllerHomecare,
        curve: Curves.easeInOut,
      ),
    );

    // Animation trượt từ trái sang cho hand
    _handSlideAnimation = Tween<Offset>(
      begin: const Offset(-1, 0), // Trượt từ trái sang
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controllerHand,
      curve: Curves.easeInOut,
    ));

    _loadImages(); // Load tất cả các ảnh
  }

  Future<void> _loadImages() async {
    _homeImage = await _loadImage('lib/images/delay/home.png');
    _lineImage = await _loadImage('lib/images/delay/line.png');
    _la1Image = await _loadImage('lib/images/delay/la1.png');
    _la2Image = await _loadImage('lib/images/delay/la2.png');
    _la3Image = await _loadImage('lib/images/delay/la3.png');
    _la4Image = await _loadImage('lib/images/delay/la4.png');
    _homecareImage = await _loadImage('lib/images/delay/homecare.png');
    _handImage = await _loadImage('lib/images/delay/hand.png');

    // Sau khi ảnh được tải, bắt đầu các animation theo thứ tự
    setState(() {
      _controllerLine.forward().then((_) {
        _controllerLa1.forward().then((_) {
          _controllerLa2.forward().then((_) {
            _controllerLa3.forward().then((_) {
              _controllerLa4.forward().then((_) {
                _controllerHomecare.forward().then((_) {
                  _controllerHand.forward(); // Cuối cùng là hand
                });
              });
            });
          });
        });
      });
    });
  }

  Future<ui.Image> _loadImage(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final frame = await codec.getNextFrame();
    return frame.image;
  }

  @override
  void dispose() {
    _controllerLine.dispose();
    _controllerLa1.dispose();
    _controllerLa2.dispose();
    _controllerLa3.dispose();
    _controllerLa4.dispose();
    _controllerHomecare.dispose();
    _controllerHand.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (_homeImage != null)
              CustomPaint(
                painter: ImagePainter(_homeImage!, Offset.zero, 0.4),
                size: Size(_homeImage!.width.toDouble() * 0.4,
                    _homeImage!.height.toDouble() * 0.4),
              ),
            _buildAnimatedImage(_lineImage, _controllerLine),
            _buildAnimatedImage(_la1Image, _controllerLa1),
            _buildAnimatedImage(_la2Image, _controllerLa2),
            _buildAnimatedImage(_la3Image, _controllerLa3),
            _buildAnimatedImage(_la4Image, _controllerLa4),
            _buildHomecareTransition(),
            _buildSlideTransition(_handImage, _handSlideAnimation),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedImage(ui.Image? image, AnimationController controller) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return image == null
            ? const SizedBox()
            : RotationTransition(
                turns: Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
                    parent: controller, curve: Curves.easeInOut)),
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0, end: 1).animate(
                      CurvedAnimation(
                          parent: controller, curve: Curves.easeOutBack)),
                  child: CustomPaint(
                    painter: ImagePainter(image, Offset.zero, 0.4),
                    size: Size(image.width.toDouble() * 0.4,
                        image.height.toDouble() * 0.4),
                  ),
                ),
              );
      },
    );
  }

  Widget _buildHomecareTransition() {
    return SlideTransition(
      position: _homecareSlideAnimation,
      child: FadeTransition(
        opacity: _homecareFadeAnimation,
        child: _homecareImage == null
            ? const SizedBox()
            : CustomPaint(
                painter: ImagePainter(_homecareImage!, Offset.zero, 0.4),
                size: Size(_homecareImage!.width.toDouble() * 0.4,
                    _homecareImage!.height.toDouble() * 0.4),
              ),
      ),
    );
  }

  Widget _buildSlideTransition(ui.Image? image, Animation<Offset> animation) {
    return SlideTransition(
      position: animation,
      child: image == null
          ? const SizedBox()
          : CustomPaint(
              painter: ImagePainter(image, Offset.zero, 0.4),
              size: Size(
                  image.width.toDouble() * 0.4, image.height.toDouble() * 0.4),
            ),
    );
  }
}

class ImagePainter extends CustomPainter {
  final ui.Image image;
  final Offset offset;
  final double scaleFactor;

  ImagePainter(this.image, this.offset, this.scaleFactor);

  @override
  void paint(Canvas canvas, Size size) {
    final double scaledWidth = image.width.toDouble() * scaleFactor;
    final double scaledHeight = image.height.toDouble() * scaleFactor;

    final Offset center = Offset(
      (size.width - scaledWidth) / 2 + offset.dx,
      (size.height - scaledHeight) / 2 + offset.dy,
    );
    canvas.save();
    canvas.scale(scaleFactor);
    canvas.drawImage(image, center, Paint());
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
