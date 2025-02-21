import 'package:flutter/material.dart';
import 'package:foodapp/data/model/CostFactor.dart';
import 'package:foodapp/data/model/service.dart';
import 'package:foodapp/pages/services_order.dart';

class AllServicesPage extends StatelessWidget {
  final dynamic customer;
  final List<Services> services;
  final List<CostFactor> costFactors;

  const AllServicesPage({
    Key? key,
    required this.customer,
    required this.services,
    required this.costFactors,
  }) : super(key: key);

  final List<Map<String, dynamic>> categories = const [
    {
      'title': 'Dịch vụ chăm sóc và hỗ trợ',
      'services': [
        {
          'iconPath': 'lib/images/services/clean.png',
          'label': 'Chăm sóc 10 tuổi',
          'isNew': false,
        },
        {
          'iconPath': 'lib/images/services/rubbish.png',
          'label': 'Chăm sóc người bệnh',
          'isNew': false,
        },
      ]
    },
    {
      'title': 'Dịch vụ bảo dưỡng điện máy',
      'services': [
        {
          'iconPath': 'lib/images/services/wash.png',
          'label': 'Vệ sinh bình nóng lạnh',
          'isNew': true,
        },
        {
          'iconPath': 'lib/images/services/clean.png',
          'label': 'Vệ sinh máy giặt',
          'isNew': true,
        },
      ]
    },
    {
      'title': 'Dịch vụ dành cho doanh nghiệp',
      'services': [
        {
          'iconPath': 'lib/images/services/xit.png',
          'label': 'Dọn dẹp văn phòng',
          'isNew': true,
        },
        {
          'iconPath': 'lib/images/services/wash.png',
          'label': 'Dọn dẹp phòng',
          'isNew': false,
        },
        {
          'iconPath': 'lib/images/services/nobiet.png',
          'label': 'Vệ sinh phòng',
          'isNew': true,
        },
        {
          'iconPath': 'lib/images/services/nobiet.png',
          'label': 'Vệ sinh phòng',
          'isNew': true,
        },
      ]
    },
    {
      'title': 'Dịch vụ tiện ích nâng cao',
      'services': [
        {
          'iconPath': 'lib/images/services/xabong.png',
          'label': 'Giặt ủi',
          'isNew': false,
        },
        {
          'iconPath': 'lib/images/services/xit.png',
          'label': 'Nấu ăn gia đình',
          'isNew': false,
        },
        {
          'iconPath': 'lib/images/services/bridge.png',
          'label': 'Đi Chợ',
          'isNew': false,
        },
        {
          'iconPath': 'lib/images/services/clean.png',
          'label': 'Khử khuẩn',
          'isNew': false,
        },
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'Khám phá HomeCare',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: categories.map((category) {
            return _buildCategorySection(context, category);
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildCategorySection(
      BuildContext context, Map<String, dynamic> category) {
    return Container(
      margin: const EdgeInsets.only(
        top: 16,
        left: 16,
        right: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
              ),
            ),
            child: Text(
              category['title'],
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Quicksand',
                color: Colors.black87,
              ),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.9,
            ),
            itemCount: category['services'].length,
            itemBuilder: (context, index) {
              final service = category['services'][index];
              return Column(
                children: [
                  _buildServiceIcon(service['iconPath']),
                  _buildServiceLabel(service['label']),
                ],
              );
            },
          ),
          // const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildServiceIcon(String iconPath) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(16),
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
              borderRadius: BorderRadius.circular(16),
              shape: BoxShape.rectangle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.green,
                  Colors.green.withOpacity(0.5),
                ],
              ),
            ),
            child: Icon(
              Icons.home_work_outlined,
              color: Colors.white,
              size: 32,
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                customBorder: const CircleBorder(),
                // onTap: () => _navigateToService(index, context),
                splashColor: Colors.green.withOpacity(0.1),
                highlightColor: Colors.green.withOpacity(0.05),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceLabel(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontFamily: 'Quicksand',
          fontWeight: FontWeight.w400,
          height: 1.2,
        ),
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  // Widget _buildServiceItem(BuildContext context, Map<String, dynamic> service) {
  //   return InkWell(
  //     onTap: () => _navigateToService(context),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: Colors.green.shade50,
  //         borderRadius: BorderRadius.circular(12),
  //       ),
  //       child: Stack(
  //         children: [
  //           Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Container(
  //                 padding: const EdgeInsets.all(4),
  //                 // child: Image.asset(
  //                 //   service['iconPath'],
  //                 //   height: 48,
  //                 //   width: 48,
  //                 //   fit: BoxFit.contain,
  //                 // ),
  //                 child: Icon(
  //                   Icons.cleaning_services,
  //                   size: 32,
  //                   color: Colors.green,
  //                 ),
  //               ),
  //               Container(
  //                 // padding: const EdgeInsets.symmetric(horizontal: 8),
  //                 child: Text(
  //                   service['label'],
  //                   style: const TextStyle(
  //                     fontSize: 12,
  //                     fontFamily: 'Quicksand',
  //                     fontWeight: FontWeight.w400,
  //                     height: 1.2,
  //                   ),
  //                   textAlign: TextAlign.center,
  //                   maxLines: 2,
  //                   overflow: TextOverflow.ellipsis,
  //                 ),
  //               ),
  //             ],
  //           ),
  //           if (service['isNew'] == true)
  //             Positioned(
  //               top: 0,
  //               right: 0,
  //               child: Container(
  //                 padding:
  //                     const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
  //                 decoration: BoxDecoration(
  //                   color: Colors.red,
  //                   borderRadius: BorderRadius.circular(12),
  //                 ),
  //                 child: const Text(
  //                   'NEW',
  //                   style: TextStyle(
  //                     color: Colors.white,
  //                     fontSize: 8,
  //                     fontWeight: FontWeight.w500,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  void _navigateToService(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => ServicesOrder(
          customer: customer,
          service: services[0],
          costFactors: costFactors,
          services: services,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.1),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }
}
