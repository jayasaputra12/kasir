import 'package:date_time_picker/date_time_picker.dart';
import 'package:dropdown_search2/dropdown_search2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kasir/common/shared_code.dart';
import 'package:kasir/model/customer/get_customer_model.dart';
import 'package:kasir/pages/transaksi/transaki_page.dart';
import 'package:kasir/repositories/customer/customer_repository.dart';
import 'package:kasir/repositories/report/report_repository.dart';
import 'package:kasir/widget/btn_primary.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';

import '../../../model/auth/auth_model.dart';
import '../../../model/transaction/create_transaksi_model.dart';
import '../../../repositories/cart/cart_repository.dart';
import '../../../widget/card_product_transaksi.dart';

class CheckoutPage extends StatefulWidget {
  CheckoutPage({this.transaksi, this.auth, super.key});
  DataTransaksi? transaksi;
  final AuthModel? auth;

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final TextEditingController _uangCustomer = TextEditingController();
  List<DataCustomer>? customer;
  DataCustomer? selectedCustomer;
  bool _chas = false;
  bool _tempo = false;
  int _uangKembali = 0;
  int _totalHarga = 0;
  DateTime now = DateTime.now();
  String? tanggalTempo;

  @override
  void initState() {
    CustomerRepository().getCustomer().then((value) {
      setState(() {
        customer = value.data!.data;
      });
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
              'TRANSAKSI',
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                color: Colors.white,
              ),
            ),
            Text(
              'ini adalah halaman transaksi',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Data customer*',
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Expanded(
                        child: DropdownSearch<DataCustomer>(
                          showSelectedItems: false,
                          showSearchBox: true,
                          enabled: _chas == true ? false : true,
                          dropdownSearchDecoration:
                              const InputDecoration.collapsed(hintText: ''),
                          maxHeight: 200,
                          items: customer,
                          itemAsString: (item) => item!.nameCustomer.toString(),
                          onChanged: (v) {
                            setState(() {
                              selectedCustomer = v;
                            });
                          },
                        ),
                      ),
                    ],
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
                              selectedCustomer?.nameCustomer ?? '',
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
                                selectedCustomer?.address ?? '',
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
                              selectedCustomer?.phone ?? '',
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
                  FutureBuilder(
                    future: CartRepository()
                        .getCart(transaksiId: widget.transaksi!.id!),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        _totalHarga = snapshot.data!.data!.data!.fold(
                            0,
                            (previousValue, element) =>
                                previousValue +
                                (int.parse(element.productId!.priceUnit!) *
                                    int.parse(element.quantity!)));
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.data!.data!.length,
                          itemBuilder: (context, index) {
                            return CardProductTransaksi(
                              product:
                                  snapshot.data!.data!.data![index].productId,
                              qty: snapshot.data!.data!.data![index].quantity!,
                            );
                          },
                        );
                      }
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text('Error'),
                        );
                      }
                      if (snapshot.data == null) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
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
                      InkWell(
                        onTap: () {
                          setState(() {
                            _chas = true;
                            _tempo = false;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(
                            color:
                                _chas ? const Color(0xff1B9C42) : Colors.white,
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
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _chas = false;
                            _tempo = true;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(
                            color:
                                _tempo ? const Color(0xff1B9C42) : Colors.white,
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
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _tempo
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Tanggal Tempo*",
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 10),
                            DateTimePicker(
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              fieldHintText: 'Tanggal Tempo',
                              type: DateTimePickerType.date,
                              timePickerEntryModeInput: true,
                              dateMask: 'yyyy-MM-dd',
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                              icon: const Icon(Icons.event),
                              dateLabelText: 'Date',
                              timeLabelText: "Hour",
                              onChanged: (val) {
                                setState(() {
                                  tanggalTempo = val;
                                  print(tanggalTempo);
                                });
                              },
                            ),
                            const SizedBox(height: 10),
                          ],
                        )
                      : const SizedBox(),
                  Text(
                    "Uang Customer*",
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _uangCustomer,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Rp. 0',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (value) {
                      setState(() {
                        _uangKembali = int.parse(value) - _totalHarga;
                      });
                    },
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
                                .getCart(transaksiId: widget.transaksi!.id!),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Kembalian",
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            SharedCode.convertToIdr(_uangKembali, 0),
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff1B9C42),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  BtnPrimary(
                    txtBtn: "Bayar Sekarang",
                    onPressed: () {
                      if (selectedCustomer != null) {
                        if (int.parse(selectedCustomer!.limitMoney!) <
                            _totalHarga) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              duration: Duration(milliseconds: 500),
                              content: Text('Limit anda tidak mencukupi'),
                            ),
                          );
                        } else if (selectedCustomer!.activate == "blokir") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              duration: Duration(milliseconds: 500),
                              content: Text('Customer telah di blokir'),
                            ),
                          );
                        } else {
                          if (_uangCustomer.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Uang customer tidak boleh kosong'),
                              ),
                            );
                          } else {
                            if (_uangKembali < 0) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Uang customer tidak cukup'),
                                ),
                              );
                            } else {
                              if (_chas) {
                                context.loaderOverlay.show();
                                CartRepository()
                                    .getCart(transaksiId: widget.transaksi!.id!)
                                    .then((value) {
                                  value.data!.data!.forEach((element) {
                                    ReportRepository()
                                        .createReportCash(
                                      idTransaksi:
                                          widget.transaksi!.id!.toString(),
                                      payment: "CHAS",
                                      paymentTerm: DateFormat('yyyy-MM-dd')
                                          .format(now)
                                          .toString(),
                                      productId:
                                          element.productId!.id!.toString(),
                                      quantitySale: element.quantity!,
                                      userId: widget.auth!.data!.user!.id!
                                          .toString(),
                                    )
                                        .catchError((e) {
                                      context.loaderOverlay.hide();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('Gagal'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    });
                                    ReportRepository().updateStok(
                                      idProduct: element.productId!.stock![0].id
                                          .toString(),
                                      decrease: element.quantity!.toString(),
                                    );
                                    ReportRepository().terjualStok(
                                      idProduct: element
                                          .productId!.penjualan![0].id
                                          .toString(),
                                      increase: element.quantity!.toString(),
                                    );
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => TransaksiPage(
                                            auth: widget.auth,
                                          ),
                                        ));
                                  });
                                }).catchError((e) {
                                  print(e);
                                });
                                // print(
                                //     "tanggal :${DateFormat('EEEE, dd MMMM yyyy').format(now)}");
                              } else {
                                context.loaderOverlay.show();
                                CartRepository()
                                    .getCart(transaksiId: widget.transaksi!.id!)
                                    .then((value) {
                                  value.data!.data!.forEach((element) {
                                    ReportRepository()
                                        .createReportTempo(
                                      idTransaksi:
                                          widget.transaksi!.id!.toString(),
                                      customerId:
                                          selectedCustomer!.id.toString(),
                                      payment: "TEMPO",
                                      paymentTerm: tanggalTempo,
                                      productId:
                                          element.productId!.id!.toString(),
                                      quantitySale: element.quantity!,
                                      userId: widget.auth!.data!.user!.id!
                                          .toString(),
                                    )
                                        .catchError((e) {
                                      context.loaderOverlay.hide();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('Gagal'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    });
                                    ReportRepository().updateStok(
                                      idProduct: element.productId!.stock![0].id
                                          .toString(),
                                      decrease: element.quantity!.toString(),
                                    );
                                    ReportRepository().terjualStok(
                                      idProduct: element
                                          .productId!.penjualan![0].id
                                          .toString(),
                                      increase: element.quantity!.toString(),
                                    );
                                    CustomerRepository().updateCustomer(
                                      id: selectedCustomer!.id.toString(),
                                      limitMoney: int.parse(
                                              selectedCustomer!.limitMoney!) -
                                          _totalHarga,
                                    );
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => TransaksiPage(
                                            auth: widget.auth,
                                          ),
                                        ));
                                  });
                                }).catchError((e) {
                                  print(e);
                                });
                              }
                            }
                          }
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(milliseconds: 500),
                            content: Text('Customer tidak boleh kosong'),
                          ),
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
