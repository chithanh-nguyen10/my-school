import 'package:flutter/material.dart';
import "package:my_school/main_screen.dart";
import "firebase_options.dart";
import "package:firebase_core/firebase_core.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MainApp());
}

WidgetStateProperty<Color?>? colorConvert(Color color){
  return WidgetStateProperty.resolveWith((states) {
    if (states.contains(WidgetState.selected)) {
      return color; // Color when checkbox is selected
    }
    return null;
  });
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        canvasColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        drawerTheme: const DrawerThemeData(
          backgroundColor: Colors.white,
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Color(0xff228af4)
        ),
        dialogBackgroundColor: const Color.fromARGB(255, 20, 80, 139),
        checkboxTheme: CheckboxThemeData(
          fillColor: colorConvert(const Color(0xff228af4)),
          checkColor: colorConvert(Colors.white),
          overlayColor: colorConvert(const Color(0xff228af4)),
          side: const BorderSide(color: Color(0xff228af4), width: 2)
        ),
        tabBarTheme: TabBarTheme(
          unselectedLabelColor: Colors.grey[800],
          indicatorColor: const Color(0xff228af4),
          labelColor: const Color(0xff228af4),
          dividerColor: Colors.blue,
          dividerHeight: 0.7
        ),
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 1.5, color: Color(0xff228af4))
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 1.5, color: Color(0xff228af4))
          ),
          focusColor: Color(0xff228af4),
          hoverColor: Color(0xff228af4),
        ),
        dropdownMenuTheme: DropdownMenuThemeData(
          inputDecorationTheme: InputDecorationTheme(
            fillColor: Colors.white,
            filled: true
          ),
          menuStyle: MenuStyle(
            backgroundColor: colorConvert(Colors.white)
          )
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xff228af4),
          iconTheme: IconThemeData(
            color: Colors.white
          )
        )
      ),
      home: MainScreen(),
    );
  }
}
