import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class TextFieldCustom extends StatefulWidget {
  TextFieldCustom(
      {this.label, this.controller, this.isPassword = false, super.key});
  TextEditingController? controller = TextEditingController();
  String? label;
  bool? isPassword;

  @override
  State<TextFieldCustom> createState() => _TextFieldCustomState();
}

class _TextFieldCustomState extends State<TextFieldCustom> {
  bool _obscured = true;
  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured; // Prevents focus if tap on eye
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label ?? "",
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xff020202),
            ),
          ),
          const SizedBox(height: 6),
          TextFormField(
            obscureText: widget.isPassword! ? _obscured : false,
            controller: widget.controller,
            decoration: InputDecoration(
              suffixIcon: widget.isPassword!
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                      child: IconButton(
                        onPressed: _toggleObscured,
                        icon: Icon(
                          _obscured
                              ? Icons.visibility_rounded
                              : Icons.visibility_off_rounded,
                          color: const Color(0xff8D92A3),
                        ),
                      ),
                    )
                  : null,
              hintText: "",
              hintStyle: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w300,
                color: const Color(0xff8D92A3),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color(0xff020202),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color(0xff020202),
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color(0xff020202),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
