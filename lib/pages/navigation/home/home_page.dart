import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kasir/bloc/category/category_bloc.dart';
import 'package:kasir/model/auth/auth_model.dart';
import 'package:kasir/model/product/product_model.dart';
import 'package:kasir/model/transaction/create_transaksi_model.dart';
import 'package:kasir/pages/navigation/cart/cart_page.dart';
import 'package:kasir/pages/product/all_product.dart';
import 'package:kasir/pages/product/detail_product.dart';
import 'package:kasir/repositories/cart/cart_repository.dart';
import 'package:kasir/repositories/product/product_repository.dart';
import 'package:kasir/widget/textfield_search.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';

import '../../../widget/category_card.dart';
import '../../../widget/header_dashboard.dart';
import '../../../widget/product_card.dart';

class HomePage extends StatefulWidget {
  HomePage({this.auth, this.transaksi, super.key});
  AuthModel? auth;
  DataTransaksi? transaksi;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 1;
  List<Datum>? listProduct;
  int totalPages = 0;
  bool _isLoading = false;
  int _totalItems = 0;
  ScrollController scrollController = ScrollController();
  bool onNotification(ScrollNotification scrollNotification) {
    if (scrollNotification is ScrollUpdateNotification) {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent &&
          scrollController.position.maxScrollExtent - scrollController.offset <=
              10) {
        setState(() {
          _isLoading = true;
          currentPage += 1;
          ProductRepository().getProduct(page: currentPage).then((response) {
            if (response != null) {
              if (currentPage >= response.data!.lastPage!) {
                setState(() {
                  listProduct!.addAll(response.data!.data!);
                  currentPage = response.data!.lastPage!;
                  _isLoading = false;
                });
              }
            }
          });
        });
      }
    }
    return true;
  }

  @override
  void initState() {
    CartRepository().getCart(transaksiId: widget.transaksi!.id!).then((value) {
      var qtyLength = value.data!.map((e) => e.quantity).length;
      setState(() {
        _totalItems = qtyLength;
      });
    });
    ProductRepository().getProduct(page: currentPage).then((response) {
      if (response != null) {
        setState(() {
          listProduct = response.data!.data!;
          totalPages = response.data!.total!;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    context.loaderOverlay.hide();
    return Scaffold(
      body: SafeArea(
        child: NotificationListener(
          // onNotification: onNotification,
          child: SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderDashboard(auth: widget.auth),
                const SizedBox(height: 30),
                Text(
                  "Kategori",
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 30.w,
                  child: BlocBuilder<CategoryBloc, CategoryState>(
                    builder: (context, state) {
                      if (state is CategoryInitial) {
                        context.loaderOverlay.hide();
                        BlocProvider.of<CategoryBloc>(context)
                            .add(GetCategoryEvent());
                      }
                      if (state is CategoryLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xff1B9C42),
                          ),
                        );
                      }
                      if (state is CategoryLoaded) {
                        var listCategory =
                            state.category.data!.map((e) => e).toList();
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: listCategory.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AllProduct(
                                      auth: widget.auth,
                                      transaksi: widget.transaksi,
                                      category: listCategory[index],
                                    ),
                                  ),
                                );
                              },
                              child: CategoryCard(
                                data: listCategory[index],
                              ),
                            );
                          },
                        );
                      }
                      return Center(
                        child: Text(
                          "Category tidak ada",
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AllProduct(
                            auth: widget.auth, transaksi: widget.transaksi),
                      ),
                    );
                  },
                  child: Container(
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color(0xff97969E),
                      ),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        const Icon(
                          Icons.search,
                          color: Color(0xff97969E),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Cari Produk",
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff97969E),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Product",
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AllProduct(
                                transaksi: widget.transaksi, auth: widget.auth),
                          ),
                        );
                      },
                      child: Text(
                        "Lihat Semua",
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff1B9C42),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                FutureBuilder(
                  future: ProductRepository().getProduct(page: currentPage),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xff1B9C42),
                        ),
                      );
                    }
                    if (snapshot.hasData) {
                      if (listProduct != null) {
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 5,
                            childAspectRatio: 138 / 300,
                          ),
                          itemCount: listProduct!.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailProductPage(
                                      transaksi: widget.transaksi,
                                      data: listProduct![index],
                                      auth: widget.auth,
                                      refresh: () {
                                        CartRepository()
                                            .getCart(
                                                transaksiId:
                                                    widget.transaksi!.id!)
                                            .then((value) {
                                          var qtyLength = value.data!
                                              .map((e) => e.quantity)
                                              .length;
                                          setState(() {
                                            _totalItems = qtyLength;
                                          });
                                        });
                                      },
                                    ),
                                  ),
                                );
                              },
                              child: ProductCard(data: listProduct![index]),
                            );
                          },
                        );
                      } else {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: Color(0xff1B9C42),
                        ));
                      }
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "Product tidak ada",
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xff1B9C42),
                        ),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xff1B9C42),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                // if (_isLoading)
                //   const Center(
                //     child: CircularProgressIndicator(
                //       color: Colors.black,
                //     ),
                //   )
                // else
                //   Center(
                //     child: Text(
                //       "Tidak ada lagi product",
                //       style: GoogleFonts.inter(
                //         fontSize: 12.sp,
                //         fontWeight: FontWeight.w400,
                //       ),
                //     ),
                //   ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
