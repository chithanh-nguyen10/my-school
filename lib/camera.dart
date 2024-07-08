import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  Widget build(BuildContext context) {
    print('Building CameraScreen...');
    return  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: FractionallySizedBox(
              widthFactor: 1, // Adjust as needed
              heightFactor: 0.39, // Adjust as needed
              child: WebView(
                initialUrl: 'http://192.168.1.3:7123/video_feed',
                javascriptMode: JavascriptMode.unrestricted,
              ),
            ),
          ),
        ],
      );
  }
}
