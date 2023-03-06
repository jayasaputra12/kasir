import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kasir/model/auth/auth_model.dart';
import 'package:kasir/pages/auth/login_page.dart';
import 'package:kasir/pages/dashboard/dashboard_page.dart';
import 'package:sizer/sizer.dart';

import '../../services/shared_preferences_services.dart';
import '../navigation/navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1B9C42),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/images/splash.svg",
              height: 15.h,
              color: Colors.white,
            ),
            const SizedBox(height: 30),
            Text(
              'CashApp',
              style: GoogleFonts.inter(
                fontSize: 30.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  checkLogin() async {
    AuthModel? auth = SharedPreferencesService.getAuthModel();
    Timer(const Duration(seconds: 1), () {
      if (auth != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => DashboardPage(
                auth: auth,
              ),
            ),
            (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
            (route) => false);
      }
    });
  }
}
