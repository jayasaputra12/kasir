import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kasir/pages/dashboard/dashboard_page.dart';
import 'package:kasir/widget/btn_primary.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';

import '../../model/auth/auth_model.dart';

class TransaksiPage extends StatelessWidget {
  const TransaksiPage({this.auth, super.key});
  final AuthModel? auth;

  @override
  Widget build(BuildContext context) {
    context.loaderOverlay.hide();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/transaksi_done.png',
                width: MediaQuery.of(context).size.width * 0.5,
              ),
              Text(
                'TRANSAKSI BERHASIL',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1D1E3C),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "transaksi berhasil silahkan cetak invoice anda di bawah ini",
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF1D1E3C),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              BtnPrimary(
                txtBtn: "Back to Home",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DashboardPage(
                          auth: auth,
                        ),
                      ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
