import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRCameraScreen extends StatefulWidget {
  @override
  _QRCameraScreenState createState() => _QRCameraScreenState();
}

// class _QRCameraScreenState extends State<QRCameraScreen> {
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   Barcode? result;
//   QRViewController? controller;

//   @override
//   void reassemble() {
//     super.reassemble();
//     if (controller != null) {
//       controller!.pauseCamera();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("QR Camera")),
//       body: SafeArea(
//         child: Center(
//           child: Text("QR Camera"),
//         ),
//       ),
//     );
//   }
// }
class _QRCameraScreenState extends State<QRCameraScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QR Scanner')),
      body:  MobileScanner(
          // fit: BoxFit.contain,
          onDetect: (capture) {
            final List<Barcode> barcodes = capture.barcodes;
            // final Uint8List? image = capture.image;
            for (final barcode in barcodes) {
              debugPrint('Barcode found! ${barcode.rawValue}' ?? 'No barcode found');
            }
          },
        
      ),
    );
  }
}
