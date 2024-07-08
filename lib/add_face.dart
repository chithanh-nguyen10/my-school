import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_school/components/mytextfield.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

class AddFace extends StatefulWidget {
  const AddFace({super.key});

  @override
  State<AddFace> createState() => _AddFaceState();
}

class _AddFaceState extends State<AddFace> {
  String _captureImageUrl = 'http://192.168.1.3:5000/capture_image';
  final nameController = TextEditingController();

  String idTransform(int id) {
    return '${id.toString().padLeft(3, '0')}';
  }

  Future<void> _captureImage(String filename) async {
    try {
      var response = await http.post(
        Uri.parse('$_captureImageUrl'),
        body: {'filename': filename},
      );
      
      if (response.statusCode == 200) {
        print('Image captured and displayed.');
      } else {
        print('Failed to capture image: ${response.statusCode}');
      }
    } catch (e) {
      print('Error capturing image: $e');
    }
  }

  @override
  void dispose(){
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
        backgroundColor: const Color(0xff228af4),
        // title: Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 25)),
      ), body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: FractionallySizedBox(
              widthFactor: 1, // Adjust as needed
              heightFactor: 0.39, // Adjust as needed
              child: WebView(
                initialUrl: 'http://192.168.1.3:5000/video_feed',
                javascriptMode: JavascriptMode.unrestricted,
              ),
            ),
          ),
          MyTextField(
            controller: nameController,
            hintText: "Type your name",
            obscureText: false,
            fontSize: 22,
          ),
          SizedBox(height: 10),
          Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () async {
              DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
                .collection("identify")
                .doc("current-id")
                .get();
              int id = documentSnapshot.get("id") + 1;
              await FirebaseFirestore.instance
              .collection("identify")
              .doc("current-id")
              .update({
                "id" : id
              });
              await FirebaseFirestore.instance
              .collection("attendance-students-list")
              .add({
                "id" : id,
                "name": nameController.text
              });
              _captureImage(idTransform(id));
              Navigator.pop(context, "succeed");
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 32.0),
            ),
            child: Text(
              'Take Picture',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        )
        ],
      ));
  }
}
