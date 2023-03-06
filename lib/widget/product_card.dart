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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xff97969E)),
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
            borderRadius: BorderRadius.circular(10),
            child: data!.photoProduct != null
                ? Image.network(
                    data!.photoProduct!,
                    height: 40.w,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/images/category.png',
                    height: 40.w,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
          ),
          const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data!.nameProduct ?? "",
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Text(
                  data!.category != null ? data!.category!.nameCategory! : "",
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: const Color(0xff8D92A3),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  data!.priceUnit != null
                      ? SharedCode.convertToIdr(int.parse(data!.priceUnit!), 0)
                      : "",
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: const Color(0xff1B9C42),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  data!.stock![0].quantity != null
                      ? "Stok: ${data!.stock![0].quantity.toString()}"
                      : "",
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "Terjual ${data!.penjualan![0].terjual.toString()} Product",
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: const Color(0xff8D92A3),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  data!.description ?? "",
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: const Color(0xff8D92A3),
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
