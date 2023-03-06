import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class TextfieldSearch extends StatelessWidget {
  TextfieldSearch(
      {this.controller, this.onEditingComplete, this.onChange, super.key});

  TextEditingController? controller;
  Function? onEditingComplete;
  Function? onChange;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onEditingComplete: onEditingComplete as void Function()?,
      onChanged: onChange as void Function(String)?,
      autofocus: false,
      decoration: InputDecoration(
        hintText: "Cari Produk",
        hintStyle: GoogleFonts.inter(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: const Color(0xff828282),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color(0xff97969E),
          ),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              size: 24,
              color: Color(0xff4F4F4F),
            ),
          ),
        ),
      ),
    );
  }
}
