import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kasir/common/shared_code.dart';
import 'package:kasir/model/cart/get_cart_model.dart';
import 'package:kasir/model/transaction/create_transaksi_model.dart';
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.cart!.photoProduct!,
                  width: 30.w,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.cart!.nameProduct}",
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff3D3D3D),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "${widget.qty} items",
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          color: const Color(0xff8D92A3),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          "•",
                          style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            color: const Color(0xff8D92A3),
                          ),
                        ),
                      ),
                      Text(
                        "${SharedCode.convertToIdr(int.parse(widget.qty.toString()) * int.parse(widget.cart!.priceUnit.toString()), 0)}",
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          color: const Color(0xff8D92A3),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            if (int.parse(widget.qty.toString()) > 1) {
                              CartRepository()
                                  .updateQuantity(
                                      id: widget.id!,
                                      quantity:
                                          int.parse(widget.qty.toString()) - 1)
                                  .then((value) {
                                CartRepository().getCart(
                                    transaksiId: widget.transaksiId!.id!);
                                setState(() {
                                  widget.qty =
                                      (int.parse(widget.qty.toString()) - 1)
                                          .toString();
                                });
                              });
                            } else if (int.parse(widget.qty.toString()) == 1) {
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
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(3.5.w),
                            ),
                            child: const Icon(
                              Icons.remove,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Text(
                          widget.qty.toString(),
                          style: GoogleFonts.poppins(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff3D3D3D),
                          ),
                        ),
                        const SizedBox(width: 15),
                        InkWell(
                          onTap: () {
                            CartRepository()
                                .updateQuantity(
                                    id: widget.id!,
                                    quantity:
                                        int.parse(widget.qty.toString()) + 1)
                                .then((value) {
                              CartRepository().getCart(
                                  transaksiId: widget.transaksiId!.id!);
                              setState(() {
                                widget.qty =
                                    (int.parse(widget.qty.toString()) + 1)
                                        .toString();
                              });
                            });
                          },
                          child: Container(
                            height: 7.w,
                            width: 7.w,
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(3.5.w),
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: InkWell(
              onTap: () {
                CartRepository().deleteCart(id: widget.id!).then((value) {
                  CartRepository()
                      .getCart(transaksiId: widget.transaksiId!.id!);
                  setState(() {
                    widget.refresh!();
                  });
                });
              },
              child: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          )
        ],
      ),
    );
  }
}
