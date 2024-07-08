import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnOff extends StatelessWidget {
  final Function()? changeState;
  final String title;
  final bool state;

  const OnOff(
      {super.key,
      required this.changeState,
      required this.title,
      required this.state});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            width: screenWidth * 0.8,
            height: screenHeight * 0.038,
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2)),
              child: Row(
                children: [
                  Text(
                    title,
                    style: GoogleFonts.robotoMono(
                        color: Colors.grey,
                        letterSpacing: .1,
                        fontWeight: FontWeight.w700,
                        fontSize: screenWidth * 0.036),
                  ),
                  Expanded(child:SizedBox(width: screenWidth * 0.2)),
                  GestureDetector(
                      onTap: changeState,
                      child: Container(
                        width: screenWidth * 0.3,
                        height: screenWidth * 0.055,
                        decoration: BoxDecoration(
                          color: state
                              ? Color(0xFFdbb60f)
                              : Color(0xFF28292e),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Text(
                            state ? "ON" : "OFF",
                            style: GoogleFonts.quicksand(
                                color: state
                                    ? Colors.white
                                    : Color(0xFF23c48e),
                                fontWeight: FontWeight.w700,
                                fontSize: screenWidth * 0.035),
                          ),
                        ),
                      ))
                ],
              ),
            ))
      ],
    );
  }
}
