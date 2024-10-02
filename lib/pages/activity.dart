// import 'package:flutter/material.dart';

// class ServicesOrder extends StatefulWidget {
//   const ServicesOrder({super.key});

//   @override
//   State<ServicesOrder> createState() => _ServicesOrderState();
// }

// class _ServicesOrderState extends State<ServicesOrder>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   final List<Widget> servicesPage = [const OnDemand(), const LongTerm()];

//   int _selectedIndex = 0;

//   void _selectedTabIndex(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     _tabController.addListener(() {
//       _selectedTabIndex(_tabController.index);
//     });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _tabController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: const Text('Đặt người giúp việc'),
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(48.0),
//           child: TabBar(
//             controller: _tabController,
//             labelColor: Colors.green,
//             unselectedLabelColor: Colors.black,
//             tabs: [
//               Container(
//                 decoration: BoxDecoration(
//                   border: Border(
//                     bottom: BorderSide(
//                       color: _selectedIndex == 0 ? Colors.green : Colors.white,
//                       // Viền dưới khi tab được chọn
//                       width: 1.0,
//                     ),
//                   ),
//                 ),
//                 height: 48,
//                 alignment: Alignment.center,
//                 child: const Text('Theo ngày'),
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   border: Border(
//                     bottom: BorderSide(
//                       color: _selectedIndex == 1 ? Colors.green : Colors.white,
//                       // Viền dưới khi tab được chọn
//                       width: 1.0,
//                     ),
//                   ),
//                 ),
//                 height: 48,
//                 alignment: Alignment.center,
//                 child: const Text('Dài hạn'),
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: const [
//           OnDemand(),
//           LongTerm(),
//         ],
//       ),
//     );
//   }
// }

// class OnDemand extends StatefulWidget {
//   const OnDemand({super.key});

//   @override
//   State<OnDemand> createState() => _OnDemandState();
// }

// class _OnDemandState extends State<OnDemand> {
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Container(
//         width: double.infinity, // Đảm bảo chiều rộng chiếm toàn bộ màn hình
//         padding: const EdgeInsets.only(
//           left: 10.0,
//           right: 10,
//           top: 30,
//           bottom: 10,
//         ),
//         color: Colors.white,
//         child: const Row(),
//       ),
//     );
//   }
// }

// class LongTerm extends StatefulWidget {
//   const LongTerm({super.key});

//   @override
//   State<LongTerm> createState() => _LongTermState();
// }

// class _LongTermState extends State<LongTerm> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
