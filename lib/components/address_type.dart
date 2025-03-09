import 'package:flutter/material.dart';
import 'package:foodapp/components/field_order_service.dart';

class AddressType extends StatefulWidget {
  final Function(String) onAddressChanged;

  const AddressType({super.key, required this.onAddressChanged});

  @override
  State<AddressType> createState() => _AddressTypeState();
}

class _AddressTypeState extends State<AddressType> {
  String address = '';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FieldOrderService(
        hintText: 'Nhập địa chỉ',
        onChanged: (value) {
          setState(() {
            address = value;
          });
          widget.onAddressChanged(value); // Truyền giá trị lên component cha
        },
      ),
    );
  }
}
