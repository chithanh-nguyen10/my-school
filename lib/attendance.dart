import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> with TickerProviderStateMixin {
  List<String> current = [];
  List<String> students = [];
  bool ready = false;

  @override
  void initState() {
    super.initState();
    fetchData().then((_) {
      fetchStudentsData().then((_) {
        setState(() {
          ready = true;
        });
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
          await _firestore.collection('attendance-current').get();
      List<DocumentSnapshot> documents = querySnapshot.docs;
      current.clear();
      for (var document in documents) {
        var data = document.data() as Map<String, dynamic>;
        String newStudent = data["name"];
        current.add(newStudent);
      }
      print(current);
    } catch (e) {
      print("Error fetching data: $e");
      throw e;
    }
  }

  Future<void> fetchStudentsData() async {
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
    if (ready)
      return Column(
        children: [
          const SizedBox(height: 3),
          Text(
            "Attendance: ${current.length}/${students.length}",
            style: GoogleFonts.robotoMono(
                color: Colors.black,
                letterSpacing: .1,
                fontWeight: FontWeight.w700,
                fontSize: 22),
          ),
          Divider(),
          Expanded(
              child: ListView.builder(
            itemCount: current.length,
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
                          current[index],
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
          ))
        ],
      );
    else
      return Center(child: CircularProgressIndicator());
  }
}
