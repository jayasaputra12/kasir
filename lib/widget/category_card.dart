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
      width: 15.w,
      height: 15.w,
      child: Column(
        children: [
          Container(
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: data!.photoCategory != null
                  ? Image.network(
                      data!.photoCategory!,
                      width: 15.w,
                      height: 15.w,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/images/category.png',
                      width: 15.w,
                      height: 15.w,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            data!.nameCategory!,
            style: GoogleFonts.inter(
              fontSize: 8.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF3A3A3A),
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
