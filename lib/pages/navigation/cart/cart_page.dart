import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kasir/model/transaction/create_transaksi_model.dart';
import 'package:kasir/pages/customer/add_customer_page.dart';
import 'package:kasir/pages/navigation/cart/checkout_page.dart';
import 'package:kasir/repositories/cart/cart_repository.dart';
import 'package:kasir/widget/btn_primary.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';

import '../../../bloc/cart/cart_bloc.dart';
import '../../../model/auth/auth_model.dart';
import '../../../widget/bottom_cart_widget.dart';
import '../../../widget/cart_product_card.dart';

class CartPage extends StatefulWidget {
  CartPage({this.auth, this.transaksi, super.key});
  AuthModel? auth;
  DataTransaksi? transaksi;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
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
              'CART',
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                color: Colors.white,
              ),
            ),
            Text(
              'ini adalah halaman cart product',
              style: GoogleFonts.inter(
                fontSize: 10.sp,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      CartRepository().deleteCartByTransaksiId(
                          transaksiId: widget.transaksi!.id!);
                    });
                  },
                  child: Text(
                    "Hapus Semua",
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff1B9C42),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddCustomerPage(),
                        ));
                  },
                  child: Text(
                    "Create Costumer",
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff1B9C42),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            FutureBuilder(
              future:
                  CartRepository().getCart(transaksiId: widget.transaksi!.id!),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.data!.length,
                    itemBuilder: (context, index) {
                      // total = int.parse(snapshot
                      //         .data!.data![index].productId!.priceUnit!) *
                      //     int.parse(snapshot.data!.data![index].quantity!);
                      return CartProductCard(
                        cart: snapshot.data!.data![index].productId,
                        qty: snapshot.data!.data![index].quantity,
                        id: snapshot.data!.data![index].id,
                        transaksiId: widget.transaksi,
                        refresh: () {
                          setState(() {});
                          context.loaderOverlay.hide();
                        },
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
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: BtnPrimary(
          txtBtn: 'Checkout',
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CheckoutPage(
                    transaksi: widget.transaksi,
                  ),
                ));
          },
        ),
      ),
    );
    // return BlocBuilder<CartBloc, CartState>(
    //   builder: (context, state) {
    //     if (state is CartLoaded) {
    //       var cart = state.getCartModel.data!.map((e) => e.productId).toList();
    //       var qty = state.getCartModel.data!.map((e) => e.quantity).toList();
    //       var id = state.getCartModel.data!.map((e) => e.id).toList();

    //       return Scaffold(
    //         resizeToAvoidBottomInset: false,
    //         appBar: AppBar(
    //           backgroundColor: const Color(0xff1B9C42),
    //           elevation: 0,
    //           leading: BackButton(
    //             color: Colors.white,
    //             onPressed: () {
    //               Navigator.pop(context);
    //             },
    //           ),
    //           title: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(
    //                 'CART',
    //                 style: GoogleFonts.inter(
    //                   fontSize: 12.sp,
    //                   color: Colors.white,
    //                 ),
    //               ),
    //               Text(
    //                 'ini adalah halaman cart product',
    //                 style: GoogleFonts.inter(
    //                   fontSize: 10.sp,
    //                   color: Colors.white,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         body: ListView.builder(
    //           padding: const EdgeInsets.all(20),
    //           itemCount: cart.length,
    //           itemBuilder: (context, index) {
    //             return CartProductCard(
    //               cart: cart[index],
    //               qty: qty[index],
    //               id: id[index],
    //               transaksiId: widget.transaksi,
    //               refresh: () {
    //                 context.loaderOverlay.show();
    //                 BlocProvider.of<CartBloc>(context).add(
    //                   GetCartEvent(transaksiId: widget.transaksi!.id!),
    //                 );
    //               },
    //             );
    //           },
    //         ),
    //         bottomNavigationBar: const BottomCartWidget(),
    //       );
    //     } else if (state is CartError) {
    //       context.loaderOverlay.hide();
    //     } else if (state is CartLoaded) {
    //       context.loaderOverlay.hide();
    //     } else if (state is CartLoading) {
    //       context.loaderOverlay.show();
    //     }
    //     return Scaffold(
    //       resizeToAvoidBottomInset: false,
    //       appBar: AppBar(
    //         backgroundColor: const Color(0xff1B9C42),
    //         elevation: 0,
    //         leading: BackButton(
    //           color: Colors.white,
    //           onPressed: () {
    //             Navigator.pop(context);
    //           },
    //         ),
    //         title: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Text(
    //               'CART',
    //               style: GoogleFonts.inter(
    //                 fontSize: 12.sp,
    //                 color: Colors.white,
    //               ),
    //             ),
    //             Text(
    //               'ini adalah halaman cart product',
    //               style: GoogleFonts.inter(
    //                 fontSize: 10.sp,
    //                 color: Colors.white,
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //       bottomNavigationBar: const BottomCartWidget(),
    //     );
    //   },
    // );
  }
}
