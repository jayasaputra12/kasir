import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kasir/common/shared_code.dart';
import 'package:kasir/model/product/product_model.dart';
import 'package:sizer/sizer.dart';

class ProductCard extends StatelessWidget {
  ProductCard({this.data, super.key});

  Datum? data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: data!.photoProduct != null
                ? Image.network(
                    data!.photoProduct!,
                    width: 20.w,
                    height: 20.w,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/images/category.png',
                    width: 20.w,
                    height: 20.w,
                    fit: BoxFit.cover,
                  ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data!.nameProduct ?? "",
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                data!.priceUnit != null
                    ? SharedCode.convertToIdr(int.parse(data!.priceUnit!), 0)
                    : "",
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: const Color(0xff8D92A3),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
