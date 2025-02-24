import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> with TickerProviderStateMixin {
  bool _isBalanceVisible = false;
  late final AnimationController _fadeController = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  );

  late final Animation<double> _fadeAnimation = CurvedAnimation(
    parent: _fadeController,
    curve: Curves.easeIn,
  );
  // Sample data
  final double _balance = 5000000;
  final List<Map<String, dynamic>> _linkedBanks = [
    {
      'name': 'Vietcombank',
      'accountNumber': '**** **** 1234',
      'logo': 'lib/images/payment/vietcombank.jpg',
      'color': Colors.green,
    },
    {
      'name': 'VNPay',
      'accountNumber': '**** **** 5678',
      'logo': 'lib/images/payment/vnpay.jpg',
      'color': Colors.red,
    },
  ];

  final List<Map<String, dynamic>> _transactions = [
    {
      'type': 'income',
      'amount': 1000000,
      'description': 'Nhận tiền từ Nguyễn Văn A',
      'date': DateTime.now().subtract(const Duration(hours: 2)),
    },
    {
      'type': 'expense',
      'amount': 500000,
      'description': 'Thanh toán hóa đơn điện',
      'date': DateTime.now().subtract(const Duration(hours: 5)),
    },
    {
      'type': 'income',
      'amount': 2000000,
      'description': 'Hoàn tiền từ đơn hàng #123',
      'date': DateTime.now().subtract(const Duration(days: 1)),
    },
    {
      'type': 'income',
      'amount': 2000000,
      'description': 'Hoàn tiền từ đơn hàng #123',
      'date': DateTime.now().subtract(const Duration(days: 1)),
    },
    {
      'type': 'expense',
      'amount': 2000000,
      'description': 'Hoàn tiền từ đơn hàng #82823',
      'date': DateTime.now().subtract(const Duration(days: 1)),
    },
    {
      'type': 'income',
      'amount': 2000000,
      'description': 'Hoàn tiền từ đơn hàng #123',
      'date': DateTime.now().subtract(const Duration(days: 1)),
    },
    {
      'type': 'expense',
      'amount': 2000000,
      'description': 'Hoàn tiền từ đơn hàng #123',
      'date': DateTime.now().subtract(const Duration(days: 1)),
    },
  ];
  @override
  void initState() {
    super.initState();
    // Start the fade-in animation
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  String _formatCurrency(double amount) {
    final formatter = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    return formatter.format(amount);
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inHours < 24) {
      if (difference.inHours < 1) {
        return '${difference.inMinutes} phút trước';
      }
      return '${difference.inHours} giờ trước';
    }
    return DateFormat('dd/MM/yyyy HH:mm').format(date);
  }

  Widget _buildBalanceCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade700, Colors.green.shade900],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Số dư ví',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Quicksand',
                  ),
                ),
                IconButton(
                  icon: Icon(
                    _isBalanceVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _isBalanceVisible = !_isBalanceVisible;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 300),
              firstChild: Text(
                _formatCurrency(_balance),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Quicksand',
                ),
              ),
              secondChild: Text(
                '* * * * * *',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Quicksand',
                ),
              ),
              crossFadeState: _isBalanceVisible
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBanksList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Tài khoản liên kết',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Quicksand',
            ),
          ),
        ),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: _linkedBanks.length + 1,
            itemBuilder: (context, index) {
              if (index == _linkedBanks.length) {
                return _buildAddBankCard();
              }
              return _buildBankCard(_linkedBanks[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBankCard(Map<String, dynamic> bank) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Handle bank card tap
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: 150,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                    backgroundColor: bank['color'].withOpacity(0.1),
                    radius: 20,
                    // child: Icon(
                    //   Icons.account_balance,
                    //   color: bank['color'],s
                    // ),
                    child: ClipRRect(
                      child: Image.asset(bank['logo']),
                    )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bank['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Quicksand',
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      bank['accountNumber'],
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                        fontFamily: 'Quicksand',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddBankCard() {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Handle add bank
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: 150,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade300,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_circle_outline,
                  size: 32,
                  color: Colors.green.shade700,
                ),
                const SizedBox(height: 8),
                Text(
                  'Thêm tài khoản',
                  style: TextStyle(
                    color: Colors.green.shade700,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Quicksand',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Giao dịch gần đây',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Quicksand',
                ),
              ),
              TextButton(
                onPressed: () {
                  // Handle view all transactions
                },
                child: const Text(
                  'Xem tất cả',
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _transactions.length,
          itemBuilder: (context, index) {
            final transaction = _transactions[index];
            return Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  // Handle transaction tap
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: transaction['type'] == 'income'
                              ? Colors.green.shade50
                              : Colors.red.shade50,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          transaction['type'] == 'income'
                              ? Icons.arrow_downward
                              : Icons.arrow_upward,
                          color: transaction['type'] == 'income'
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              transaction['description'],
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              _formatDate(transaction['date']),
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        _formatCurrency(transaction['amount'].toDouble()),
                        style: TextStyle(
                          color: transaction['type'] == 'income'
                              ? Colors.green
                              : Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text(
            'Ví của tôi',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Quicksand',
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          actions: [
            Container(
              // padding: const EdgeInsets.all(0),
              margin: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                  color: Colors.green.shade200,
                  borderRadius: BorderRadius.circular(50)),
              child: IconButton(
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: _buildBalanceCard(),
              ),
              _buildBanksList(),
              const SizedBox(height: 8),
              _buildTransactionsList(),
            ],
          ),
        ),
      ),
    );
  }
}
