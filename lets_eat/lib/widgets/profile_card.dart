import 'package:flutter/material.dart';
import 'package:lets_eat/models/user.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Replace with your actual profile data and image

    User? user = UserDataManager.getUser() as User?;
    String profileImage = 'assets/img/profile_image.png';

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundImage: AssetImage(profileImage),
          radius: 30,
        ),
        title: Text(
          user?.username ?? '사용자 이름',
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
