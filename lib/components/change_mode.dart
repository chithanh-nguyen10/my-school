import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangeMode extends StatelessWidget {
  final Function()? onAuto;
   final Function()? onManual;
  final String title;
  final bool mode;

  const ChangeMode(
      {super.key,
      required this.onAuto,
      required this.onManual,
      required this.title,
      required this.mode});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
        padding: EdgeInsets.only(left: 18.0, right: 18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                onTap: onAuto,
                child: Container(
                  width: screenWidth * 0.2,
                  height: screenHeight * 0.03,
                  decoration: BoxDecoration(
                      color: !mode ? Colors.blue : Colors.white,
                      border: Border.all(color: Colors.blue, width: 3)),
                  child: Center(
                    child: Text(
                      "AUTO",
                      style: GoogleFonts.robotoMono(
                          color: !mode ? Colors.white : Colors.blue,
                          fontWeight: FontWeight.w700,
                          fontSize: screenWidth * 0.03),
                    ),
                  ),
                )),
            Text(
              title,
              style: GoogleFonts.robotoMono(
                  color: Colors.black,
                  letterSpacing: .1,
                  fontWeight: FontWeight.w700,
                  fontSize: screenWidth * 0.045),
            ),
            GestureDetector(
                onTap: onManual,
                child: Container(
                  width: screenWidth * 0.2,
                  height: screenHeight * 0.03,
                  decoration: BoxDecoration(
                      color: mode ? Colors.blue : Colors.white,
                      border: Border.all(color: Colors.blue, width: 3)),
                  child: Center(
                    child: Text(
                      "MANUAL",
                      style: GoogleFonts.robotoMono(
                          color: mode ? Colors.white : Colors.blue,
                          fontWeight: FontWeight.w700,
                          fontSize: screenWidth * 0.03),
                    ),
                  ),
                )),
          ],
        ));
  }
}
