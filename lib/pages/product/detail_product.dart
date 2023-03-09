import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kasir/common/shared_code.dart';
import 'package:kasir/model/product/product_model.dart';
import 'package:kasir/model/transaction/create_transaksi_model.dart';
import 'package:kasir/pages/navigation/cart/cart_page.dart';
import 'package:kasir/repositories/cart/cart_repository.dart';
import 'package:kasir/widget/barcode_widge.dart';
import 'package:sizer/sizer.dart';

import '../../model/auth/auth_model.dart';

class DetailProductPage extends StatefulWidget {
  DetailProductPage(
      {this.data,
      this.auth,
      this.transaksi,
      this.refresh,
      this.isDashboard = false,
      super.key});
  Datum? data;
  DataTransaksi? transaksi;
  AuthModel? auth;
  Function? refresh;
  bool isDashboard;

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  int _qty = 1;
  int _hargaAwal = 0;

  @override
  Widget build(BuildContext context) {
    print(widget.isDashboard);
    int hargaAwal = int.parse(widget.data!.priceUnit!);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
              'Detail Porduct',
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                color: Colors.white,
              ),
            ),
            Text(
              'ini adalah halaman detail product',
              style: GoogleFonts.inter(
                fontSize: 10.sp,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: widget.isDashboard
            ? []
            : [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartPage(
                            auth: widget.auth,
                            transaksi: widget.transaksi,
                          ),
                        ),
                      );
                    },
                    icon: Image.asset(
                      'assets/images/keranjang.png',
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.data!.photoProduct != null
                ? Image.network(
                    widget.data!.photoProduct!,
                    width: width,
                    height: height * 0.35,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/images/category.png',
                    width: width,
                    height: height * 0.35,
                    fit: BoxFit.cover,
                  ),
            Container(
              height: 31,
              decoration: const BoxDecoration(
                color: Color(0xff1B9C42),
              ),
              child: Center(
                child: Text(
                  "KATEGORI - ${widget.data!.category!.nameCategory}",
                  style: GoogleFonts.inter(
                    fontSize: 10.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.data!.priceUnit != null
                                ? SharedCode.convertToIdr(
                                    int.parse(widget.data!.priceUnit!), 0)
                                : "",
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff1B9C42),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            widget.data!.nameProduct ?? "",
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff3D3D3D),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => BarcodeWidget(
                                data: widget.data,
                              ),
                            );
                          },
                          child: Image.asset(
                            'assets/images/barcode.png',
                            width: 10.w,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Product Terjual",
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff3D3D3D),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Terjual ${widget.data!.penjualan![0].terjual} Product",
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff97969E),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Stock Produk",
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff3D3D3D),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Stock Produk ${widget.data!.stock![0].quantity}",
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff97969E),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Harga Modal",
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff3D3D3D),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.data!.priceUnit != null
                        ? SharedCode.convertToIdr(
                            int.parse(widget.data!.priceUnit!), 0)
                        : "",
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff97969E),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Deskripsi",
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff3D3D3D),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.data!.description ?? "",
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff3D3D3D),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: widget.isDashboard
          ? null
          : Container(
              height: 35.w,
              width: width,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 5, top: 10),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Harga",
                                  style: GoogleFonts.inter(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff3D3D3D),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  _hargaAwal == 0
                                      ? SharedCode.convertToIdr(hargaAwal, 0)
                                      : SharedCode.convertToIdr(_hargaAwal, 0),
                                  style: GoogleFonts.inter(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xff1B9C42),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 20),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    if (_qty > 1) {
                                      _qty--;
                                      _hargaAwal = _qty * hargaAwal;
                                    }
                                  });
                                },
                                child: Container(
                                  height: 10.w,
                                  width: 10.w,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff1B9C42),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Container(
                                width: 5.w,
                                child: Center(
                                  child: Text(
                                    _qty.toString(),
                                    style: GoogleFonts.inter(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xff3D3D3D),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _qty++;
                                    _hargaAwal = _qty * hargaAwal;
                                  });
                                },
                                child: Container(
                                  height: 10.w,
                                  width: 10.w,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff1B9C42),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        if (widget.data!.stock![0].quantity == "0") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              duration: Duration(milliseconds: 500),
                              content: Text("Stok Habis"),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        } else {
                          CartRepository()
                              .addCart(
                                  productId: widget.data!.id!,
                                  userId: widget.auth!.data!.user!.id!,
                                  transaksiId: widget.transaksi!.id!,
                                  quantity: _qty)
                              .then((value) => {
                                    if (value.meta!.code == 200)
                                      {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            duration: const Duration(
                                                milliseconds: 500),
                                            content: Text(value.meta!.message!),
                                            backgroundColor: Colors.green,
                                          ),
                                        ),
                                      }
                                    else
                                      {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            duration: const Duration(
                                                milliseconds: 500),
                                            content: Text(value.meta!.message!),
                                            backgroundColor: Colors.red,
                                          ),
                                        ),
                                      }
                                  });
                        }
                      },
                      child: Container(
                        height: 15.w,
                        width: width,
                        decoration: BoxDecoration(
                          color: const Color(0xff1B9C42),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "Tambah ke Keranjang",
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
