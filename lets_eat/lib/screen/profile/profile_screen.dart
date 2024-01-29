import 'package:flutter/material.dart';
import 'package:lets_eat/screen/profile/profile_edit_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
        ),
        body: ListView(
          padding: EdgeInsets.all(16),
          children: [
            ProfileCard(),
            SizedBox(height: 16),
            PushAlarmToggle(),
            DarkModeToggle(),
            SizedBox(height: 20),
            SettingsItem(
                title: "이용약관",
                onTap: () => _navigateToTextScreen(context, "이용 약관")),
            SettingsItem(
                title: "개인 정보 처리 방침",
                onTap: () => _navigateToTextScreen(context, "개인 정보 처리 방침")),
            SettingsItem(
                title: "버전 정보",
                onTap: () => _navigateToTextScreen(context, "버전 정보")),
            SizedBox(height: 20),
            LogOutButton(),
            WithdrawButton(),
          ],
        ));
  }

  void _navigateToTextScreen(BuildContext context, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TextScreen(title: title),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Replace with your actual profile data and image
    String nickname = "김바보";
    String profileImage = "assets/profile_image.jpg";

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundImage: AssetImage(profileImage),
          radius: 30,
        ),
        title: Text(
          nickname,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: ElevatedButton(
          onPressed: () {
            // Navigate to the profile edit screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileEditScreen(
                  onProfileChanged: (bool isChanged) {},
                ),
              ),
            );
          },
          child: Text("프로필 수정"),
        ),
      ),
    );
  }
}

class PushAlarmToggle extends StatefulWidget {
  @override
  _PushAlarmToggleState createState() => _PushAlarmToggleState();
}

class _PushAlarmToggleState extends State<PushAlarmToggle> {
  bool _isPushEnabled = true;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text("푸시 알림"),
      value: _isPushEnabled,
      onChanged: (value) {
        setState(() {
          _isPushEnabled = value;
        });
      },
    );
  }
}

class DarkModeToggle extends StatefulWidget {
  @override
  _DarkModeToggleState createState() => _DarkModeToggleState();
}

class _DarkModeToggleState extends State<DarkModeToggle> {
  bool _isDarkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text("다크 모드"),
      value: _isDarkModeEnabled,
      onChanged: (value) {
        setState(() {
          _isDarkModeEnabled = value;
        });
        // Implement dark mode handling logic here
      },
    );
  }
}

class SettingsItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  SettingsItem({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: onTap,
    );
  }
}

class LogOutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 4),
      // Adjust the left padding as needed
      child: Align(
        alignment: Alignment.centerLeft,
        child: TextButton(
          onPressed: () {
            // Implement logout logic here
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.transparent,
            // Set background color to transparent
            primary: Colors.black, // Text color
          ),
          child: Text(
            "로그아웃",
            style: TextStyle(
              fontSize: 16,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}

class WithdrawButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 4), // Adjust the left padding as needed
      child: Align(
        alignment: Alignment.centerLeft,
        child: TextButton(
          onPressed: () {
            // Implement withdraw logic here
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.transparent,
            // Set background color to transparent
            primary: Colors.black, // Text color
          ),
          child: Text(
            "탈퇴하기",
            style: TextStyle(
              fontSize: 16,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}

// class WithdrawButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {
//         // Implement withdraw logic here
//       },
//       child: Text("탈퇴하기"),
//     );
//   }
// }

class TextScreen extends StatelessWidget {
  final String title;

  TextScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Text("$title 테스트"),
        ));
  }
}
