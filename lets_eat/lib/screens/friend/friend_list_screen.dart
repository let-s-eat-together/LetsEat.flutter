import 'package:flutter/material.dart';
import 'package:lets_eat/screens/friend/add_friend_screen.dart';

class FriendListScreen extends StatefulWidget {
  const FriendListScreen({super.key});

  @override
  _FriendListScreenState createState() => _FriendListScreenState();
}

class _FriendListScreenState extends State<FriendListScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  String searchText = '';
  final List<String> friendList = [
    '김서근',
    '포뇨',
    '하울',
    '소피아',
    '캐시퍼',
    '소스케',
    '치히로',
    '하쿠',
    '가오나시',
    '제니바',
    '카브',
    '마르클',
    '토토로',
    '사츠키',
    '지브리',
    '스튜디오',
    '캐릭터'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 187, 157, 211),
        title: const Text(
          '친구',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.normal,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => const AddFriendScreen()),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 16),
            SearchBar(
              hintText: '친구 검색',
              leading: const Icon(Icons.search),
              controller: _textEditingController,
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              trailing: [
                IconButton(
                  onPressed: () {
                    _textEditingController.clear();
                    setState(() {
                      searchText = '';
                    });
                  },
                  icon: const Icon(Icons.clear),
                ),
              ],
              elevation: MaterialStateProperty.all(10.0),
              constraints: const BoxConstraints(
                maxWidth: 400,
                minHeight: 50,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: friendList
                    .where((name) =>
                        name.startsWith(searchText) || searchText == '')
                    .length,
                itemBuilder: (context, index) {
                  String name = friendList
                      .where((name) =>
                          name.startsWith(searchText) || searchText == '')
                      .elementAt(index);
                  return ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    title: Text(name),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchTextField extends StatelessWidget {
  final Function(String) onChanged;

  const SearchTextField({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Search',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: const Icon(Icons.clear),
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
