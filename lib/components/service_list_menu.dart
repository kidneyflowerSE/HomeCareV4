import 'package:flutter/material.dart';
import 'package:foodapp/data/model/CostFactor.dart';
import 'package:foodapp/pages/services_order.dart';
import '../data/model/service.dart';

class ServiceListMenu extends StatefulWidget {
  final dynamic customer;
  final List<Services> services;
  final List<CostFactor> costFactors;

  const ServiceListMenu(
      {Key? key, required this.customer, required this.services, required this.costFactors})
      : super(key: key);

  @override
  State<ServiceListMenu> createState() => _ServiceListMenuState();
}

class _ServiceListMenuState extends State<ServiceListMenu> {
  final List<Map<String, String>> servicesInfo = [
    {'iconPath': 'lib/images/services/bridge.png', 'label': 'Dọn nhà'},
    {'iconPath': 'lib/images/services/choi.png', 'label': 'Chăm sóc bé'},
    {
      'iconPath': 'lib/images/services/clean.png',
      'label': 'Chăm sóc người già'
    },
    {'iconPath': 'lib/images/services/nobiet.png', 'label': 'Chăm sóc sản phụ'},
    {'iconPath': 'lib/images/services/rubbish.png', 'label': 'Nuôi bệnh'},
    {'iconPath': 'lib/images/services/wash.png', 'label': 'Đưa đón bé đi học'},
    {'iconPath': 'lib/images/services/xabong.png', 'label': 'Nấu ăn'},
    {'iconPath': 'lib/images/services/xit.png', 'label': 'Vệ sinh phòng'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 16,
          mainAxisSpacing: 24,
          childAspectRatio: 0.75,
        ),
        itemCount: servicesInfo.length,
        itemBuilder: (context, index) {
          return _buildServiceItem(index, context);
        },
      ),
    );
  }

  Widget _buildServiceItem(int index, BuildContext context) {
    return InkWell(
      onTap: () => _navigateToService(index, context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildServiceIcon(index),
          const SizedBox(height: 8),
          _buildServiceLabel(index),
        ],
      ),
    );
  }

  Widget _buildServiceIcon(int index) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.green.shade50,
                  Colors.white,
                ],
              ),
              border: Border.all(
                color: Colors.green.withOpacity(0.3),
                width: 1.5,
              ),
            ),
            child: Image.asset(
              servicesInfo[index]['iconPath']!,
              height: 32,
              width: 32,
              fit: BoxFit.contain,
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: () => _navigateToService(index, context),
                splashColor: Colors.green.withOpacity(0.1),
                highlightColor: Colors.green.withOpacity(0.05),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceLabel(int index) {
    return Expanded(
      child: Text(
        servicesInfo[index]['label']!,
        style: const TextStyle(
          fontSize: 13,
          fontFamily: 'Quicksand',
          fontWeight: FontWeight.w600,
          height: 1.2,
        ),
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  void _navigateToService(int index, BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => ServicesOrder(
          customer: widget.customer,
          service: widget.services[0],
          costFactors: widget.costFactors, services: widget.services,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }
}
