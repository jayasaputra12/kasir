import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kasir/model/auth/auth_model.dart';
import 'package:sizer/sizer.dart';

import '../model/transaction/create_transaksi_model.dart';
import '../pages/navigation/cart/cart_page.dart';

class HeaderDashboard extends StatelessWidget {
  HeaderDashboard(
      {this.auth, this.transaksi, this.isDashboard = false, super.key});
  AuthModel? auth;
  DataTransaksi? transaksi;
  bool isDashboard;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 15.w,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset('assets/images/pic.png')),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        auth!.data!.user!.name ?? "",
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        auth!.data!.user!.role ?? "",
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              isDashboard
                  ? Container()
                  : Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CartPage(
                                  auth: auth,
                                  transaksi: transaksi,
                                ),
                              ),
                            );
                          },
                          child: Image.asset(
                            'assets/images/keranjang.png',
                            width: 8.w,
                            color: const Color(0xff595BD4),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Image.asset(
                          'assets/images/riwayat.png',
                          width: 8.w,
                          color: const Color(0xff595BD4),
                        ),
                      ],
                    )
            ],
          ),
        ),
        const SizedBox(height: 23),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Uang Kas",
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: const Color(0xff97969E),
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Image.asset(
                  'assets/images/kas.png',
                  width: 8.w,
                ),
                const SizedBox(width: 8),
                Text(
                  "Rp. 1.000.000",
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: const Color(0xff1B9C42),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
