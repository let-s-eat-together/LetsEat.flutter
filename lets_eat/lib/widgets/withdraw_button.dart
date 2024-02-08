import 'package:flutter/material.dart';
import 'package:lets_eat/utils/api_withdraw.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';

class WithdrawButton extends StatelessWidget {
  const WithdrawButton({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    return Padding(
      padding:
          const EdgeInsets.only(left: 4), // Adjust the left padding as needed
      child: Align(
        alignment: Alignment.centerLeft,
        child: TextButton(
          onPressed: () {
            withdrawAPI(user?.token, context);
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.black, backgroundColor: Colors.transparent, // Text color
          ),
          child: const Text(
            '탈퇴하기',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
