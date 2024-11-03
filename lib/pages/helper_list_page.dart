import 'package:flutter/material.dart';
import 'package:foodapp/data/model/helper.dart';

import '../components/my_employee_detail.dart';
import '../data/model/customer.dart';
// import '../data/model/request.dart';
import '../data/model/request.dart';
import '../data/repository/repository.dart';
import '../pages/review_order_page.dart';

class HelperList extends StatefulWidget {
  final Customer customer;
  final Requests request;
  const HelperList({super.key, required this.customer, required this.request});

  @override
  State<HelperList> createState() => _HelperListState();
}

class _HelperListState extends State<HelperList> {
  late List<Helper> helpers = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    var repository = DefaultRepository();
    var data = await repository.loadCleanerData();
    if (data == null) {
      helpers = [];
    } else {
      helpers = data;
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: FadeInImage.assetNetwork(
                placeholder: 'lib/images/avt.png',
                image: helpers[index].avatar ?? '',
                width: 48,
                height: 48,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'lib/images/avt.png',
                    width: 48,
                    height: 48,
                  );
                },
              ),
            ),
            title: Text(helpers[index].fullName!),
            subtitle: Text(helpers[index].experienceDescription!),
            trailing: IconButton(
              onPressed: (){
                showBottomSheet(
                    context: context,
                    builder: (context){
                      return ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                        child: Container(
                          height: 400,
                          color: Colors.grey,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                TextButton(
                                  onPressed: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const MyEmployeeDetail()),
                                    );
                                  },
                                  child: const Text('xem chi tiết',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.green,
                                      fontFamily: 'Quicksand',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                );
              },
              icon: const Icon(Icons.more_horiz),
            ),
            onTap: () {
              widget.request.helperId = helpers[index].helperId;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReviewOrderPage(customer: widget.customer, helper: helpers[index], request: widget.request,)),
              );
            },
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            color: Colors.grey,
            thickness: 1,
            indent: 24,
            endIndent: 24,
          );
        },
        itemCount: helpers.length,
        shrinkWrap: true,
      ),
    );
  }
}
