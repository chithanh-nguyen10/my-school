import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnOffTile extends StatelessWidget {
  final Function()? leftClick;
  final Function()? rightClick;
  final String leftTitle;
  final String rightTitle;
  final bool state;

  const OnOffTile({super.key, required this.leftClick, required this.rightClick, required this.leftTitle, required this.rightTitle,  required this.state});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    const double opac = 0.4;
    return Padding(
      padding: EdgeInsets.all(11.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: leftClick,
            child: Opacity(
              opacity: !state ? 1 : opac,
              child: Container(
                width: screenWidth * 0.45,
                height: screenHeight * 0.035,
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(4)),
                padding: EdgeInsets.all(6),
                child: Center(
                  child: Text(
                    leftTitle,
                    style: GoogleFonts.quicksand(
                        color: Colors.white,
                        letterSpacing: .1,
                        fontWeight: FontWeight.w700,
                        fontSize: screenWidth * 0.035),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: screenWidth * 0.035),
          GestureDetector(
            onTap: rightClick,
            child: Opacity(
              opacity: state ? 1 : opac,
              child: Container(
                width: screenWidth * 0.45,
                height: screenHeight * 0.035,
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(4)),
                padding: EdgeInsets.all(6),
                child: Center(
                  child: Text(
                    rightTitle,
                    style: GoogleFonts.quicksand(
                        color: Colors.white,
                        letterSpacing: .1,
                        fontWeight: FontWeight.w700,
                        fontSize: screenWidth * 0.035),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
