import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DualDisplay extends StatelessWidget {
  final String leftText;
  final String leftValue;
  final String rightText;
  final String rightValue;

  const DualDisplay(
      {super.key,
      required this.leftText,
      required this.leftValue,
      required this.rightText,
      required this.rightValue});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: EdgeInsets.all(3.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SizedBox(
                        width: screenWidth * 0.45,
                        height: screenHeight * 0.038,
                        child: Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 2)),
                          child: Row(
                            // mainAxisSize: MainAxisSize.min,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                leftText,
                                style: GoogleFonts.robotoMono(
                                    color: Colors.grey,
                                    letterSpacing: .1,
                                    fontWeight: FontWeight.w700,
                                    fontSize: screenWidth * 0.03),
                              ),
                              Text(
                                leftValue,
                                style: GoogleFonts.robotoMono(
                                    color: Colors.black,
                                    letterSpacing: .1,
                                    fontWeight: FontWeight.w700,
                                    fontSize: screenWidth * 0.03),
                              ),
                            ],
                          ),
                        ))
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(3.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SizedBox(
                        width: screenWidth * 0.45,
                        height: screenHeight * 0.038,
                        child: Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 2)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                rightText,
                                style: GoogleFonts.robotoMono(
                                    color: Colors.grey,
                                    letterSpacing: .1,
                                    fontWeight: FontWeight.w700,
                                    fontSize: screenWidth * 0.03),
                              ),
                              Text(
                                rightValue,
                                style: GoogleFonts.robotoMono(
                                    color: Colors.black,
                                    letterSpacing: .1,
                                    fontWeight: FontWeight.w700,
                                    fontSize: screenWidth * 0.03),
                              ),
                            ],
                          ),
                        ))
                  ],
                )
              ],
            ),
          )
        ]);
  }
}
