import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lets_eat/model/API.dart';
import 'package:lets_eat/model/plan.dart';
import 'package:lets_eat/screen/plan/sting_button.dart';

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
        friendName: 'you')
  ];

  Future<void> getPlanList() async {
    try {
      final response =
          await http.get(Uri.parse(baseUrl + ApiType.getPlan.rawValue));
      List<dynamic> data = jsonDecode(response.body);
      List<Plan> planList = data.map((e) => Plan.fromJson(e)).toList();

      setState(() {
        this.planList = planList;
      });
    } catch (e) {
      print('Failed to request: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: planList.isEmpty
                  ? const Center(
                      child: Text(
                        'No Data',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    )
                  : ListView.builder(
                      itemCount: planList.length,
                      itemBuilder: (context, index) {
                        Plan plan = planList[index];
                        return ListTile(
                          leading: const CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                          title: Text(plan.friendName),
                          subtitle: Text(
                              '${plan.creationDate} ~ ${plan.expirationDate}'),
                          trailing: StingButton(
                              otherUserName: plan.friendName,
                              planId: plan.planId),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
