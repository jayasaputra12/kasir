import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../common/shared_code.dart';

class AttentionPop extends StatelessWidget {
  AttentionPop({super.key, this.title, this.message});
  final String? title;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return SharedCode.buildPopUp(
      child: AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              SvgPicture.asset(
                "assets/images/atention.svg",
                width: 86,
              ),
              const SizedBox(height: 26),
              Text(
                title ?? "Perhatian",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff393E46),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              Text(
                message ?? "",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff393E46),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      context: context,
    );
  }
}
