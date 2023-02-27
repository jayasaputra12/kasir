import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kasir/common/shared_code.dart';
import 'package:kasir/model/product/product_model.dart';
import 'package:kasir/widget/barcode_widge.dart';
import 'package:sizer/sizer.dart';

class DetailProductPage extends StatefulWidget {
  DetailProductPage({this.data, super.key});
  Datum? data;

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  int _qty = 1;
  int _hargaAwal = 0;
  @override
  Widget build(BuildContext context) {
    String penjualan = widget.data!.penjualan![0].terjual.toString();
    String quantity = widget.data!.stock![0].quantity.toString();
    int hargaAwal = int.parse(widget.data!.priceUnit!);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(
          color: Colors.black,
        ),
        title: Text(
          'Detail Porduct',
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xff3D3D3D),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.data!.photoProduct != null
                ? Image.network(widget.data!.photoProduct!)
                : Image.asset(
                    'assets/images/category.png',
                    width: width,
                    height: height * 0.35,
                    fit: BoxFit.cover,
                  ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.data!.nameProduct ?? "",
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff3D3D3D),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "${widget.data!.category!.nameCategory} / ${quantity.toString()} Stok Tesisa / ${penjualan.toString()} Terjual",
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
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
              "Deskripsi",
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xff3D3D3D),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              widget.data!.description ?? "",
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xff3D3D3D),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
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
          padding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 5, top: 10),
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
                            style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff3D3D3D),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            _hargaAwal == 0
                                ? "${SharedCode.convertToIdr(hargaAwal, 0)}"
                                : "${SharedCode.convertToIdr(_hargaAwal, 0)}",
                            style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff3D3D3D),
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
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.remove,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Container(
                          width: 5.w,
                          child: Center(
                            child: Text(
                              "${_qty.toString()}",
                              style: GoogleFonts.poppins(
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
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 15.w,
                width: width,
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.shopping_cart,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Tambah ke Keranjang",
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff3D3D3D),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
