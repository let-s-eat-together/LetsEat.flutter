import 'package:flutter/material.dart';

class PlanScreen extends StatefulWidget {
  @override
  _PlanScreenState createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  List<int?> planList = [0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Text('Plan'),
            Expanded(
              child: planList.isEmpty
                  ? Center(
                      child: Text(
                        'No Data',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    )
                  : ListView.builder(
                      itemCount: 11,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                          title: Text(index.toString()),
                          subtitle: Text("53days left."),
                          trailing: StingButton(
                              otherUserName: index.toString(), planId: 1),
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

class StingButton extends StatefulWidget {
  final String otherUserName;
  final int planId;

  StingButton({required this.otherUserName, required this.planId});

  @override
  _StingButtonState createState() => _StingButtonState();
}

class _StingButtonState extends State<StingButton> {
  bool isSting = false;

  void sendMessage(String to) {
    // 메시지 전송 로직 구현
    print("send to $to 콕!");
  }

  void pressReject(String to) {
    // 거절 로직 구현
    print("reject $to kok!");
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 40,
      icon: Icon(Icons.android),
      onPressed: () {
        setState(() {
          isSting = !isSting;
        });
        if (isSting) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("콕 찔러보기"),
                content: Text("${widget.otherUserName}님을 콕 찌르시겠습니까?"),
                actions: <Widget>[
                  TextButton(
                    child: Text("네"),
                    onPressed: () {
                      sendMessage(widget.otherUserName);
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text("아니요"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }
}
