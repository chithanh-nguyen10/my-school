// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:my_school/attendance.dart';
import 'package:my_school/camera.dart';
import 'package:my_school/control.dart';
import 'package:my_school/face.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var currentPage = DrawerSections.control;
  String title = "Controls";

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.control){
      container = ControlScreen();
    } else if (currentPage == DrawerSections.camera){
      container = CameraScreen();
    } else if (currentPage == DrawerSections.face){
      container = FaceAttend();
    } else if (currentPage == DrawerSections.attend){
      container = Attendance();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color(0xff228af4),
        title: Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 25)),
        iconTheme: IconThemeData(color: Colors.white),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              }
            );
          }
        ),
      ),
      drawer: Container(
        color: Colors.white,
        child: Drawer(
          child: SingleChildScrollView(
            child: Column(
              children: [
                MyDrawerList(),
              ],
            ),
          )
        ),
      ),
      body: Row(
        children: [
          Expanded(child: container)
        ]
      )
    );
  }

  Widget MyDrawerList() {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      color: Colors.white,
      child: Column(
        // shows the list of menu drawer
        children: [
          SizedBox(height:25),
          menuItem(1, "Control", Icons.home,
              currentPage == DrawerSections.control),
          menuItem(2, "Camera", Icons.camera_alt,
              currentPage == DrawerSections.camera),
          Divider(),
          menuItem(3, "Students Management", Icons.manage_accounts,
              currentPage == DrawerSections.face),
          menuItem(4, "Attendance", Icons.people_alt_sharp,
              currentPage == DrawerSections.attend),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected, {Color textColor = Colors.black}) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.control;
              this.title = "Controls";
            } else if (id == 2) {
              currentPage = DrawerSections.camera;
              this.title = "Camera";
            } else if (id == 3) {
              currentPage = DrawerSections.face;
              this.title = "Students Management";
            } else if (id == 4) {
              currentPage = DrawerSections.attend;
              this.title = "Attendance";
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 30,
                  color: textColor,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 19,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


enum DrawerSections {
  control,
  camera,
  face,
  attend
}