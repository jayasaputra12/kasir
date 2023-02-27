import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kasir/bloc/category/category_bloc.dart';
import 'package:kasir/bloc/product/product_bloc.dart';
import 'package:kasir/model/auth/auth_model.dart';
import 'package:kasir/pages/product/detail_product.dart';
import 'package:sizer/sizer.dart';

import '../../../widget/category_card.dart';
import '../../../widget/header_dashboard.dart';
import '../../../widget/product_card.dart';

class HomePage extends StatelessWidget {
  HomePage({this.auth, super.key});
  AuthModel? auth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderDashboard(auth: auth),
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
                      return Center(
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
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductInitial) {
                    BlocProvider.of<ProductBloc>(context)
                        .add(GetProductEvent());
                  }
                  if (state is ProductLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.yellow,
                      ),
                    );
                  }
                  if (state is ProductLoaded) {
                    var listProduct =
                        state.product.data!.data!.map((e) => e).toList();
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: listProduct.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailProductPage(data: listProduct[index]),
                              ),
                            );
                          },
                          child: ProductCard(data: listProduct[index]),
                        );
                      },
                    );
                  }

                  return Center(child: Text("Product tidak ada"));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
