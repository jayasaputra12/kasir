import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:kasir/model/cart/add_cart_model.dart';
import 'package:kasir/model/history/detail_history_model.dart';
import 'package:kasir/model/history/history_model.dart';
import 'package:kasir/widget/card_product_transaksi.dart';
import 'package:kasir/widget/cart_history_product.dart';
import 'package:sizer/sizer.dart';

import '../../common/shared_code.dart';
import '../../repositories/cart/cart_repository.dart';
import '../../repositories/history/history_repository.dart';
import '../../widget/btn_primary.dart';

class DetailHistoryPage extends StatefulWidget {
  const DetailHistoryPage({this.history, super.key});
  final Datum? history;

  @override
  State<DetailHistoryPage> createState() => _DetailHistoryPageState();
}

class _DetailHistoryPageState extends State<DetailHistoryPage> {
  final int _perPage = 10;
  final PagingController<int, DataReport> _pagingController =
      PagingController(firstPageKey: 1);
  DataReport? dataReport;
  int _totalHarga = 0;
  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _getReportHistory(pageKey, widget.history!.id!);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'HISTORY TRANSAKSI',
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                color: Colors.white,
              ),
            ),
            Text(
              'ini adalah halaman history transaksi',
              style: GoogleFonts.inter(
                fontSize: 10.sp,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Data customer*',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Nama customer',
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              dataReport?.customer?.nameCustomer ?? '',
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                color: const Color(0xff97969E),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Alamat',
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                dataReport?.customer?.address ?? '',
                                style: GoogleFonts.inter(
                                  fontSize: 12.sp,
                                  color: const Color(0xff97969E),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'No. Telp',
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              dataReport?.customer?.phone ?? '',
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                color: const Color(0xff97969E),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Produk dibeli*",
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  PagedListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    pagingController: _pagingController,
                    builderDelegate: PagedChildBuilderDelegate<DataReport>(
                      itemBuilder: (context, item, index) {
                        return CardHistoryProduct(
                          product: item,
                          qty: item.quantitySale,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Status shipping*",
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                          color: dataReport?.payment == "CHAS"
                              ? const Color(0xff1B9C42)
                              : Colors.white,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Chas",
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                          color: dataReport?.payment == "TEMPO"
                              ? const Color(0xff1B9C42)
                              : Colors.white,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Tempo",
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Detail Transaksi*",
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Harga",
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10),
                          FutureBuilder(
                            future: CartRepository()
                                .getCart(transaksiId: widget.history!.id!),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                _totalHarga = snapshot.data!.data!.data!.fold(
                                    0,
                                    (previousValue, element) =>
                                        previousValue +
                                        (int.parse(
                                                element.productId!.priceUnit!) *
                                            int.parse(element.quantity!)));
                                return Text(
                                  SharedCode.convertToIdr(
                                      snapshot.data!.data!.data!.fold(
                                          0,
                                          (previousValue, element) =>
                                              previousValue +
                                              (int.parse(element
                                                      .productId!.priceUnit!) *
                                                  int.parse(
                                                      element.quantity!))),
                                      0),
                                  style: GoogleFonts.inter(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xff1B9C42),
                                  ),
                                );
                              }
                              if (snapshot.hasError) {
                                return const Center(
                                  child: Text('Error'),
                                );
                              }
                              if (snapshot.data == null) {
                                return const Center(
                                  child: Text('Loading'),
                                );
                              }
                              return const Center(
                                child: Text('Loading'),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  BtnPrimary(
                    txtBtn: "CETAK INVOICE",
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getReportHistory(int page, int idTransaksi) async {
    await HistoryRepository()
        .detailHistory(idTransaksi: idTransaksi, page: page)
        .then((value) {
      setState(() {
        dataReport = value.data!.data!.first;
      });
      try {
        final isLastPage = value.data!.data!.length < _perPage;
        if (isLastPage) {
          _pagingController.appendLastPage(value.data!.data!);
        } else {
          final nextPageKey = page + 1;
          _pagingController.appendPage(value.data!.data!, nextPageKey);
        }
      } catch (e) {
        _pagingController.error = e;
      }
    });
  }
}
