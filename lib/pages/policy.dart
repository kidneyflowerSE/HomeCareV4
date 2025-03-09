import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/data/model/Policy.dart';
import 'package:foodapp/data/repository/repository.dart';

class PolicyScreen extends StatefulWidget {
  @override
  _PolicyScreenState createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {
  late List<Policy>? policyList = [];
  final List<Map<String, String>> policies = [];
  List<bool> isOpenList = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    var repository = DefaultRepository();
    var data = await repository.loadPolicy();
    if (mounted) {
      setState(() {
        policyList = data ?? [];
        policies.addAll(policyList!
            .map((policy) => {"title": policy.title, "content": policy.content})
            .toList());
        isOpenList = List.generate(policies.length, (index) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chính sách",
          style: TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.grey.shade100,
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: policies.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 1,
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
              ),
              child: ExpansionTile(
                title: Text(
                  policies[index]["title"]!,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Quicksand',
                    fontSize: 16,
                  ),
                ),
                backgroundColor: Colors.blue.shade50,
                textColor: Colors.green,
                collapsedBackgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                initiallyExpanded: isOpenList[index],
                trailing: AnimatedSwitcher(
                  duration: Duration(milliseconds: 600),
                  transitionBuilder: (child, animation) {
                    return RotationTransition(turns: animation, child: child);
                  },
                  child: isOpenList[index]
                      ? Icon(
                          Icons.remove,
                          key: ValueKey('open'),
                          color: Colors.green,
                        )
                      : Icon(Icons.add, key: ValueKey('closed')),
                ),
                onExpansionChanged: (isOpen) {
                  setState(() {
                    isOpenList[index] = isOpen;
                  });
                },
                children: [
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      policies[index]["content"]!,
                      style: TextStyle(
                        color: Colors.black87,
                        fontFamily: 'Quicksand',
                        fontSize: 14,
                        height: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
