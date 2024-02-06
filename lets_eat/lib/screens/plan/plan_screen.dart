import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lets_eat/models/api.dart';
import 'package:lets_eat/models/plan.dart';
import 'package:lets_eat/provider/user_provider.dart';
import 'package:lets_eat/screens/plan/sting_button.dart';
import 'package:provider/provider.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  _PlanScreenState createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  List<Plan> planList = [
    // Plan(
    //     planId: 1,
    //     creationDate: '2023-12-31',
    //     expirationDate: '2024-01-22',
    //     friendName: '1'),
    // Plan(
    //     planId: 2,
    //     creationDate: '2023-12-31',
    //     expirationDate: '2024-01-22',
    //     friendName: '2'),
    // Plan(
    //     planId: 3,
    //     creationDate: '2023-12-31',
    //     expirationDate: '2024-01-22',
    //     friendName: '3'),
    // Plan(
    //     planId: 4,
    //     creationDate: '2023-12-31',
    //     expirationDate: '2024-01-22',
    //     friendName: '4'),
  ];

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final token = userProvider.user?.token;
    getPlanList(token!);
  }

  Future<void> getPlanList(String token) async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl + ApiType.getPlan.rawValue),
        headers: API.getHeaderWithToken(token),
      );

      List<dynamic> data = jsonDecode(response.body);
      List<Plan> planList = data.map((e) => Plan.fromJson(e)).toList();

      setState(() {
        this.planList = planList;
      });
      debugPrint('Success to request: ${response.body}');
    } catch (e) {
      debugPrint('Failed to request: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final token = userProvider.user?.token;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 187, 157, 211),
        title: const Text(
          '약속',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => getPlanList(token!),
          child: ListView.separated(
            itemCount: planList.length,
            itemBuilder: (context, index) {
              Plan plan = planList[index];
              if (planList.isEmpty) {
                return const Center(
                  child: Text(
                    '친구와의 약속이 없습니다.',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                );
              } else {
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
              }
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
