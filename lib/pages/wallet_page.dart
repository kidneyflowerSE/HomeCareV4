// import 'package:flutter/material.dart';

// class WalletScreen extends StatelessWidget {
//   const WalletScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Dữ liệu mẫu cho giao dịch gần đây
//     final List<Transaction> transactions = [
//       Transaction(
//         title: 'Nạp tiền từ Ngân hàng',
//         date: '19/01/2025',
//         amount: 500000,
//         isIncoming: true,
//       ),
//       Transaction(
//         title: 'Thanh toán dịch vụ',
//         date: '18/01/2025',
//         amount: 200000,
//         isIncoming: false,
//       ),
//       Transaction(
//         title: 'Nhận hoàn tiền',
//         date: '17/01/2025',
//         amount: 50000,
//         isIncoming: true,
//       ),
//     ];

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Ví của bạn"),
//         backgroundColor: Colors.green,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             EnhancedWalletCard(
//               balance: 500000,
//               points: 5000,
//               recentTransactions: transactions,
//               onTopUpPressed: () {
//                 // Xử lý nạp tiền
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const TopUpPage(),
//                   ),
//                 );
//               },
//               onTransferPressed: () {
//                 // Xử lý chuyển tiền
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const TransferPage(),
//                   ),
//                 );
//               },
//               onQRPressed: () {
//                 // Xử lý quét mã QR
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const QRScannerPage(),
//                   ),
//                 );
//               },
//               onHistoryPressed: () {
//                 // Xử lý xem lịch sử giao dịch
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const TransactionHistoryPage(),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
