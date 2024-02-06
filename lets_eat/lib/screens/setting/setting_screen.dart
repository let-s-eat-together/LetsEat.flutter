import 'package:flutter/material.dart';
import 'package:lets_eat/widgets/logout_button.dart';
import 'package:lets_eat/widgets/profile_card.dart';
import 'package:lets_eat/widgets/withdraw_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const ProfileCard(),
            const SizedBox(height: 20),
            const PushAlarmToggle(),
            const Divider(),
            const DarkModeToggle(),
            const SizedBox(height: 20),
            ListTile(
              title: const Text('이용약관'),
              onTap: () {
                _navigateToTextScreen(context, '이용 약관');
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('개인 정보 처리 방침'),
              onTap: () {
                _navigateToTextScreen(context, '개인 정보 처리 방침');
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('버전 정보'),
              onTap: () {
                _navigateToTextScreen(context, '버전 정보');
              },
            ),
            const SizedBox(height: 20),
            const LogOutButton(),
            const Divider(),
            const WithdrawButton(),
          ],
        ),
      ),
    );
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

class PushAlarmToggle extends StatefulWidget {
  const PushAlarmToggle({super.key});

  @override
  _PushAlarmToggleState createState() => _PushAlarmToggleState();
}

class _PushAlarmToggleState extends State<PushAlarmToggle> {
  bool _isPushEnabled = true;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: const Text('푸시 알림'),
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
  const DarkModeToggle({super.key});

  @override
  _DarkModeToggleState createState() => _DarkModeToggleState();
}

class _DarkModeToggleState extends State<DarkModeToggle> {
  bool _isDarkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: const Text('다크 모드'),
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

class TextScreen extends StatelessWidget {
  final String title;

  const TextScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Text('$title 테스트'),
        ));
  }
}
