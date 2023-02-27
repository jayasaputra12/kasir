import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kasir/model/category/category_model.dart';
import 'package:sizer/sizer.dart';

class CategoryCard extends StatelessWidget {
  CategoryCard({this.data, super.key});

  DataCategory? data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10, bottom: 10, top: 10, left: 10),
      width: 30.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            child: data!.photoCategory != null
                ? Image.network(
                    data!.photoCategory!,
                    width: 30.w,
                    height: 28.w,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/images/category.png',
                    width: 30.w,
                    height: 28.w,
                    fit: BoxFit.cover,
                  ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
            child: Center(
              child: Text(
                data!.nameCategory ?? "",
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
