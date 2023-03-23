import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kasir/common/shared_code.dart';
import 'package:kasir/model/history/detail_history_model.dart';
import 'package:sizer/sizer.dart';

import '../model/cart/get_cart_model.dart';

class CardHistoryProduct extends StatelessWidget {
  CardHistoryProduct({
    this.qty,
    this.product,
    super.key,
  });

  DataReport? product;
  String? qty;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              product!.product!.photoProduct!,
              width: 25.w,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product!.product!.nameProduct!,
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                SharedCode.convertToIdr(
                    int.parse(product!.product!.priceUnit.toString()), 0),
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff1B9C42),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '$qty pcs',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
