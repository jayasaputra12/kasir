import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kasir/model/product/product_model.dart';
import 'package:sizer/sizer.dart';

import '../common/shared_code.dart';

class BarcodeWidget extends StatelessWidget {
  BarcodeWidget({this.data, super.key});
  Datum? data;

  @override
  Widget build(BuildContext context) {
    return SharedCode.buildPopUp(
      child: AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: SingleChildScrollView(
          child: data!.photoBarcode != null
              ? Image.network(
                  data!.photoBarcode!,
                  width: 60.w,
                  height: 30.w,
                  fit: BoxFit.cover,
                )
              : Column(
                  children: [
                    SvgPicture.asset(
                      "assets/images/atention.svg",
                      width: 86,
                    ),
                    const SizedBox(height: 26),
                    Text(
                      "Perhatian",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff393E46),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "Barocode Tidak Ada",
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
