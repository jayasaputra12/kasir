import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kasir/common/shared_code.dart';
import 'package:kasir/model/cart/get_cart_model.dart';
import 'package:kasir/model/transaction/create_transaksi_model.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';

import '../repositories/cart/cart_repository.dart';

class CartProductCard extends StatefulWidget {
  CartProductCard({
    this.cart,
    this.qty,
    this.id,
    this.transaksiId,
    this.refresh,
    super.key,
  });
  ProductId? cart;
  String? qty;
  int? id;
  DataTransaksi? transaksiId;
  Function? refresh;

  @override
  State<CartProductCard> createState() => _CartProductCardState();
}

class _CartProductCardState extends State<CartProductCard> {
  @override
  Widget build(BuildContext context) {
    String total = SharedCode.convertToIdr(
        int.parse(widget.cart!.priceUnit!) * int.parse(widget.qty.toString()),
        0);
    return Container(
      height: 14.h,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(bottom: 10, top: 10, left: 10, right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: const Color(0xff8D92A3)),
      ),
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: Image.network(
              widget.cart!.photoProduct!,
              width: 20.w,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.cart!.nameProduct}",
                      style: GoogleFonts.poppins(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff3D3D3D),
                      ),
                    ),
                    Text(
                      total,
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff1B9C42),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        context.loaderOverlay.show();
                        CartRepository()
                            .deleteCart(id: widget.id!)
                            .then((value) {
                          CartRepository()
                              .getCart(transaksiId: widget.transaksiId!.id!);
                          setState(() {
                            widget.refresh!();
                          });
                        });
                      },
                      child: Image.asset(
                        'assets/images/trash.png',
                        width: 5.w,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: const Color(0xff8D92A3)),
                      ),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              if (int.parse(widget.qty.toString()) > 1) {
                                setState(() {
                                  widget.qty =
                                      (int.parse(widget.qty.toString()) - 1)
                                          .toString();
                                  CartRepository()
                                      .updateQuantity(
                                          id: widget.id!,
                                          quantity:
                                              int.parse(widget.qty.toString()))
                                      .then((value) {
                                    CartRepository().getCart(
                                        transaksiId: widget.transaksiId!.id!);
                                  });
                                });
                              } else if (int.parse(widget.qty.toString()) ==
                                  1) {
                                CartRepository()
                                    .deleteCart(id: widget.id!)
                                    .then((value) {
                                  CartRepository().getCart(
                                      transaksiId: widget.transaksiId!.id!);
                                  setState(() {
                                    widget.refresh!();
                                  });
                                });
                              }
                            },
                            child: Container(
                              height: 7.w,
                              width: 7.w,
                              child: const Icon(
                                Icons.remove,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(width: 25),
                          InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Ubah Jumlah'),
                                    content: Container(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextFormField(
                                            initialValue: widget.qty,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              hintText: 'Jumlah',
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                            ),
                                            onChanged: (value) {
                                              if (value.isNotEmpty) {
                                                setState(() {
                                                  widget.qty = value;
                                                });
                                              } else if (value.isEmpty) {
                                                setState(() {
                                                  widget.qty = '1';
                                                });
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Batal'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          CartRepository()
                                              .updateQuantity(
                                                  id: widget.id!,
                                                  quantity: int.parse(
                                                      widget.qty!.toString()))
                                              .then((value) {
                                            CartRepository().getCart(
                                                transaksiId:
                                                    widget.transaksiId!.id!);
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: const Text('Simpan'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text(
                              widget.qty.toString(),
                              style: GoogleFonts.inter(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff3D3D3D),
                              ),
                            ),
                          ),
                          const SizedBox(width: 25),
                          InkWell(
                            onTap: () {
                              setState(() {
                                widget.qty =
                                    (int.parse(widget.qty.toString()) + 1)
                                        .toString();
                                CartRepository()
                                    .updateQuantity(
                                        id: widget.id!,
                                        quantity:
                                            int.parse(widget.qty.toString()))
                                    .then((value) {
                                  CartRepository().getCart(
                                      transaksiId: widget.transaksiId!.id!);
                                });
                              });
                            },
                            child: Container(
                              height: 7.w,
                              width: 7.w,
                              child: const Icon(
                                Icons.add,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
