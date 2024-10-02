import 'package:flutter/material.dart';
import 'package:foodapp/components/field_order_service.dart';

class AddressType extends StatelessWidget {
  const AddressType({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: FieldOrderService(
        hintText: 'Nhập địa chỉ',
      ),
    );
  }
}
