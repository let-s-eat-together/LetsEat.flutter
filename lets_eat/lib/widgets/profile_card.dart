import 'package:flutter/material.dart';
import 'package:lets_eat/provider/user_provider.dart';
import 'package:provider/provider.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: const CircleAvatar(
          backgroundImage: AssetImage('assets/img/profile_image.png'),
          radius: 30,
        ),
        title: Text(
          '${user?.username}',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        // trailing: ElevatedButton(
        //   onPressed: () {
        //     // Navigate to the profile edit screen
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => ProfileEditScreen(
        //           onProfileChanged: (bool isChanged) {},
        //         ),
        //       ),
        //     );
        //   },
        //   child: Text('프로필 수정'),
        // ),
      ),
    );
  }
}
