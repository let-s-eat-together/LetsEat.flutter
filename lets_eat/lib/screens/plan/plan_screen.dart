import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lets_eat/models/API.dart';
import 'package:lets_eat/models/plan.dart';
import 'package:lets_eat/screens/plan/sting_button.dart';

class PlanScreen extends StatefulWidget {
  @override
  _PlanScreenState createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  List<Plan> planList = [
    Plan(
        planId: 1,
        creationDate: '2023-12-31',
        expirationDate: '2024-01-22',
        friendName: '1'),
    Plan(
        planId: 2,
        creationDate: '2023-12-31',
        expirationDate: '2024-01-22',
        friendName: '2'),
    Plan(
        planId: 3,
        creationDate: '2023-12-31',
        expirationDate: '2024-01-22',
        friendName: '3'),
    Plan(
        planId: 4,
        creationDate: '2023-12-31',
        expirationDate: '2024-01-22',
        friendName: '4'),
  ];

  Future<void> getPlanList() async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl + ApiType.getPlan.rawValue),
        headers: headers,
      );

      List<dynamic> data = jsonDecode(response.body);
      List<Plan> planList = data.map((e) => Plan.fromJson(e)).toList();

      setState(() {
        this.planList = planList;
      });
    } catch (e) {
      debugPrint('Failed to request: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: getPlanList,
          child: planList.isEmpty
              ? const Center(
                  child: Text(
                    'No Data',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                )
              : ListView.separated(
                  itemCount: planList.length,
                  itemBuilder: (context, index) {
                    Plan plan = planList[index];
                    return ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      title: Text(plan.friendName),
                      subtitle:
                          Text('${plan.creationDate} ~ ${plan.expirationDate}'),
                      trailing: StingButton(
                          otherUserName: plan.friendName, planId: plan.planId),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                  },
                ),
        ),
      ),
    );
  }
}
