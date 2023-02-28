import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kasir/bloc/category/category_bloc.dart';
import 'package:kasir/bloc/product/product_bloc.dart';
import 'package:kasir/model/auth/auth_model.dart';
import 'package:kasir/model/product/product_model.dart';
import 'package:kasir/pages/product/detail_product.dart';
import 'package:kasir/repositories/product/product_repository.dart';
import 'package:sizer/sizer.dart';

import '../../../widget/category_card.dart';
import '../../../widget/header_dashboard.dart';
import '../../../widget/product_card.dart';

class HomePage extends StatefulWidget {
  HomePage({this.auth, super.key});
  AuthModel? auth;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 1;
  List<Datum>? listProduct;
  int totalPages = 0;
  bool _isLoading = false;
  ScrollController scrollController = ScrollController();
  bool onNotification(ScrollNotification scrollNotification) {
    if (scrollNotification is ScrollUpdateNotification) {
      if (scrollController.position.maxScrollExtent > scrollController.offset &&
          scrollController.position.maxScrollExtent - scrollController.offset <=
              50) {
        setState(() {
          _isLoading = true;
          currentPage += 1;
          ProductRepository().getProduct(page: currentPage).then((response) {
            print('halaman sekarang: $currentPage');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NotificationListener(
          onNotification: onNotification,
          child: SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderDashboard(auth: widget.auth),
                const SizedBox(height: 20),
                Text(
                  "Category",
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 45.w,
                  child: BlocBuilder<CategoryBloc, CategoryState>(
                    builder: (context, state) {
                      if (state is CategoryInitial) {
                        BlocProvider.of<CategoryBloc>(context)
                            .add(GetCategoryEvent());
                      }
                      if (state is CategoryLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.yellow,
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
                            return CategoryCard(
                              data: listCategory[index],
                            );
                          },
                        );
                      }
                      return Center(
                        child: Text(
                          "Category tidak ada",
                          style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Product",
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        "Lihat Semua",
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.blue,
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
                          color: Colors.yellow,
                        ),
                      );
                    }
                    if (snapshot.hasData) {
                      if (listProduct != null) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: listProduct!.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailProductPage(
                                        data: listProduct![index]),
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
                          color: Colors.yellow,
                        ));
                      }
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "Product tidak ada",
                          style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.yellow,
                        ),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.yellow,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                if (_isLoading)
                  const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  )
                else
                  Center(
                    child: Text(
                      "Tidak ada lagi product",
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
