import 'package:flutter/material.dart';
import 'package:foodapp/pages/services_order.dart';

import '../data/model/service.dart';

class ServiceListMenu extends StatefulWidget {
  final dynamic customer;
  final List<Services> services;

  const ServiceListMenu({Key? key, required this.customer, required this.services}) : super(key: key);

  @override
  State<ServiceListMenu> createState() => _ServiceListMenuState();
}

class _ServiceListMenuState extends State<ServiceListMenu> {
  final List<Map<String, String>> servicesInfo = [
    {'iconPath': 'lib/images/services/bridge.png', 'label': 'Dọn nhà'},
    {'iconPath': 'lib/images/services/choi.png', 'label': 'Rửa chén bát'},
    {'iconPath': 'lib/images/services/clean.png', 'label': 'Giặt đồ'},
    {'iconPath': 'lib/images/services/nobiet.png', 'label': 'Lau nhà'},
    {'iconPath': 'lib/images/services/rubbish.png', 'label': 'Vệ sinh tủ lạnh'},
    {'iconPath': 'lib/images/services/wash.png', 'label': 'Chăm trẻ em'},
    {'iconPath': 'lib/images/services/xabong.png', 'label': 'Dark Services'},
    {'iconPath': 'lib/images/services/xit.png', 'label': 'Tắm hộ'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 20,
          childAspectRatio: 0.75,
        ),
        itemCount: servicesInfo.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      ServicesOrder(
                        customer: widget.customer,
                        service: widget.services[index],
                      ),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.easeInOut;

                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);

                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                ),
              );
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.green,
                    ),
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30,
                    child: Image.asset(
                      servicesInfo[index]['iconPath']!,
                      fit: BoxFit.contain,
                      height: 40,
                      width: 40,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Expanded(
                  child: Text(
                    servicesInfo[index]['label']!,
                    style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
