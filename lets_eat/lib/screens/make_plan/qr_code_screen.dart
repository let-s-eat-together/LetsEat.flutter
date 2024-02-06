import 'package:flutter/material.dart';
import 'package:lets_eat/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeScreen extends StatefulWidget {
  final DateTime expirationDate;

  const QRCodeScreen({Key? key, required this.expirationDate})
      : super(key: key);

  @override
  _QRCodeScreenState createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    return Scaffold(
      appBar: AppBar(title: const Text('QR Code')),
      body: SafeArea(
        child: Center(
          child: QrImageView(
            data: '${widget.expirationDate.toString()}\n${user?.id}',
            size: 200,
            version: QrVersions.auto,
          ),
        ),
      ),
    );
  }
}
