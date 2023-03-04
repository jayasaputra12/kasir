import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kasir/model/transaction/create_transaksi_model.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';

import '../../../bloc/cart/cart_bloc.dart';
import '../../../model/auth/auth_model.dart';
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
    BlocProvider.of<CartBloc>(context)
        .add(GetCartEvent(transaksiId: widget.transaksi!.id!));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Cart',
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xff3D3D3D),
          ),
        ),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartInitial) {
            BlocProvider.of<CartBloc>(context)
                .add(GetCartEvent(transaksiId: widget.transaksi!.id!));
          } else if (state is CartLoading) {
            context.loaderOverlay.show();
          } else if (state is CartLoaded) {
            print(state.getCartModel.data!.length);
            if (state.getCartModel.data!.isEmpty) {
              context.loaderOverlay.hide();
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/bike.png',
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'Cart is Empty',
                      style: GoogleFonts.poppins(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff3D3D3D),
                      ),
                    ),
                  ],
                ),
              );
            }
            context.loaderOverlay.hide();
            var cart =
                state.getCartModel.data!.map((e) => e.productId).toList();
            var qty = state.getCartModel.data!.map((e) => e.quantity).toList();
            var id = state.getCartModel.data!.map((e) => e.id).toList();
            return ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: cart.length,
              itemBuilder: (context, index) {
                return CartProductCard(
                    cart: cart[index],
                    qty: qty[index],
                    id: id[index],
                    transaksiId: widget.transaksi,
                    refresh: () {
                      context.loaderOverlay.show();
                      BlocProvider.of<CartBloc>(context).add(
                        GetCartEvent(transaksiId: widget.transaksi!.id!),
                      );
                    });
              },
            );
          } else if (state is CartError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
          return Container();
        },
      ),
    );
  }
}
