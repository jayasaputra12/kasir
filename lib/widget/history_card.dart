import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kasir/model/history/history_model.dart';
import 'package:sizer/sizer.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({
    required this.hisotry,
    super.key,
  });

  final Datum hisotry;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "No Invoice",
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  hisotry.invoice ?? "",
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                "Status",
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  hisotry.status ?? "",
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                "Tanggal",
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  hisotry.createdAt ?? "",
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
