import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kasir/common/shared_code.dart';
import 'package:kasir/repositories/history/history_repository.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';

import '../../model/auth/auth_model.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({this.auth, super.key});
  final AuthModel? auth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color(0xff1B9C42),
        elevation: 0,
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'History',
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                color: Colors.white,
              ),
            ),
            Text(
              'ini adalah halaman history',
              style: GoogleFonts.inter(
                fontSize: 10.sp,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        "Semua",
                        style: GoogleFonts.inter(
                            fontSize: 12.sp, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        "Tanggal",
                        style: GoogleFonts.inter(
                            fontSize: 12.sp, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            FutureBuilder(
              future:
                  HistoryRepository().getHistory(userId: auth!.data!.user!.id!),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Error"),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  context.loaderOverlay.show();
                }
                if (snapshot.data == null) {
                  return const Center();
                }
                if (snapshot.hasData) {
                  context.loaderOverlay.hide();
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.data!.data!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                    snapshot.data!.data!.data![index]
                                            .createdAt ??
                                        "",
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
                                  "Nama Produk",
                                  style: GoogleFonts.inter(
                                    fontSize: 12.sp,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    snapshot.data!.data!.data![index].product!
                                            .nameProduct ??
                                        "",
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
                                  "Jumlah",
                                  style: GoogleFonts.inter(
                                    fontSize: 12.sp,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    snapshot
                                        .data!.data!.data![index].quantitySale
                                        .toString(),
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
                                  "Total Bayar",
                                  style: GoogleFonts.inter(
                                    fontSize: 12.sp,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    SharedCode.convertToIdr(
                                        int.parse(snapshot.data!.data!
                                            .data![index].totalPrice!),
                                        0),
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
                    },
                  );
                }
                return const Center(
                  child: Text("Loading"),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
