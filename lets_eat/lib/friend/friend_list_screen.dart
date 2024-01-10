import 'package:flutter/material.dart';

class FriendListScreen extends StatefulWidget {
  @override
  _FriendListScreenState createState() => _FriendListScreenState();
}

class _FriendListScreenState extends State<FriendListScreen> {
  String searchText = "";
  final List<String> friendList = [
    "김서근", "포뇨", "하울", "소피아", "캐시퍼", "소스케",
    "치히로", "하쿠", "가오나시", "제니바", "카브", "마르클",
    "토토로", "사츠키", "지브리", "스튜디오", "캐릭터"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Text("Friend"),
          SearchTextField(
            onChanged: (value) {
              setState(() {
                searchText = value;
              });
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: friendList.where((name) => name.startsWith(searchText) || searchText == "").length,
              itemBuilder: (context, index) {
                String name = friendList.where((name) => name.startsWith(searchText) || searchText == "").elementAt(index);
                return ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  title: Text(name),
                  subtitle: Text("username"),
                  // trailing: StingButton(otherUserName: "test", planId: 1),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SearchTextField extends StatelessWidget {
  final Function(String) onChanged;

  SearchTextField({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: "Search",
          prefixIcon: Icon(Icons.search),
          suffixIcon: Icon(Icons.clear),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
      ),
    );
  }
}