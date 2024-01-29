import 'package:flutter/material.dart';

class ProfileEditScreen extends StatefulWidget {
  final ValueChanged<bool> onProfileChanged;

  const ProfileEditScreen({Key? key, required this.onProfileChanged}) : super(key: key);

  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  bool isOK = false;
  bool showAlert = false;
  TextEditingController usernameController = TextEditingController();

  final String regex = r"^[^\s]+$";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Text(
              "프로필 수정",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextField(
              controller: usernameController,
              onChanged: (newValue) {
                setState(() {
                  isOK = RegExp(regex).hasMatch(newValue);
                });
              },
              decoration: InputDecoration(
                hintText: "이름을 수정해주세요...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    usernameController.clear();
                  },
                  child: Icon(Icons.cancel, color: Colors.grey),
                ),
              ),
            ),
            // SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    isOK ? "사용 가능한 닉네임입니다." : "사용 불가한 닉네임입니다.",
                    style: TextStyle(
                      fontSize: 12,
                      color: isOK ? Colors.green : Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                if (isOK) {
                  widget.onProfileChanged(true);
                  Navigator.pop(context);
                } else {
                  setState(() {
                    showAlert = true;
                  });
                }
              },
              child: Text("완료"),
            ),
            showAlert
                ? AlertDialog(
              title: Text("닉네임이 올바르지 않습니다!", style: TextStyle(fontSize: 14),),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      showAlert = false;
                    });
                  },
                  child: Text("확인"),
                ),
              ],
            )
                : Container(),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
