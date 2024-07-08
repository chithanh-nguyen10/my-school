import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_school/add_face.dart';

class FaceAttend extends StatefulWidget {
  const FaceAttend({super.key});

  @override
  State<FaceAttend> createState() => _FaceAttendState();
}

class _FaceAttendState extends State<FaceAttend> with TickerProviderStateMixin {
  List<String> students = [];
  bool ready = false;

  @override
  void initState() {
    super.initState();
    fetchData().then((_) {
      setState(() {
        ready = true;
      });
    }).catchError((error) {
      print("Failed to fetch data: $error");
      setState(() {
        ready = false;
      });
    });
  }

  Future<void> fetchData() async {
    try {
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      QuerySnapshot querySnapshot =
          await _firestore.collection('attendance-students-list').get();
      List<DocumentSnapshot> documents = querySnapshot.docs;
      students.clear();
      for (var document in documents) {
        var data = document.data() as Map<String, dynamic>;
        String newStudent = data["name"];
        students.add(newStudent);
      }
      print(students);
    } catch (e) {
      print("Error fetching data: $e");
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (ready) {
      return Column(children: [
        Expanded(
            child: ListView.builder(
          itemCount: students.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: InkWell(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        students[index],
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                Divider(),
              ],
            );
          },
        )),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () async {
              var result = await Navigator.push(context, MaterialPageRoute(
                builder: (context) => AddFace(),
              ));
              print(result);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 32.0),
            ),
            child: Text(
              'Add student',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        )
      ]);
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}
