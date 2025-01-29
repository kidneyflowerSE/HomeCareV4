import 'package:flutter/material.dart';
import 'package:foodapp/data/model/CostFactor.dart';
import 'package:foodapp/data/model/customer.dart';
import 'package:foodapp/data/model/service.dart';
import 'package:foodapp/pages/home_page.dart';

class OrderSuccess extends StatefulWidget {
  final Customer customer;
  final List<CostFactor> costFactors;
  final List<Services> services;

  const OrderSuccess(
      {super.key,
      required this.customer,
      required this.costFactors,
      required this.services});

  @override
  State<OrderSuccess> createState() => _OrderSuccessState();
}

class _OrderSuccessState extends State<OrderSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle_outline,
                size: 100,
                color: Colors.green,
              ),
              const SizedBox(height: 20),
              const Text(
                "Đặt đơn thành công!",
                style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                "Cảm ơn bạn đã sử dụng dịch vụ của chúng tôi. Hệ thống sẽ xử lý đơn hàng của bạn sớm nhất có thể.",
                style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    print(widget.customer);
                    print(widget.costFactors);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(
                          customer: widget.customer,
                          featuredStaff: [
                            {
                              'name': 'Phạm Nguyễn Quốc Huy',
                              'avatar': 'lib/images/staff/anhhuy.jpg',
                              'position': 'Thợ sửa ổng nước',
                              'rating': "4.8",
                              'completedJobs': "120",
                            },
                            {
                              'name': 'Trần Phi Hùng',
                              'avatar': 'lib/images/staff/anhhung.jpg',
                              'position': 'Thợ điện chuyên nghiệp',
                              'rating': "4.5",
                              'completedJobs': "98",
                            },
                          ],
                          costFactor: widget.costFactors,
                          services: widget.services,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Về Trang Chủ",
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
