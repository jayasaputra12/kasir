import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:kasir/model/auth/auth_model.dart';
import 'package:kasir/model/product/product_model.dart';
import 'package:kasir/model/transaction/create_transaksi_model.dart';
import 'package:kasir/repositories/product/product_repository.dart';
import 'package:kasir/widget/product_card.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';

import '../../bloc/product/product_bloc.dart';
import '../../common/shared_code.dart';
import '../../model/category/category_model.dart';
import '../../repositories/cart/cart_repository.dart';
import '../../widget/textfield_search.dart';
import '../navigation/home/home_page.dart';

class NewAllProduct extends StatefulWidget {
  const NewAllProduct({this.auth, this.transaksi, this.category, super.key});
  final DataTransaksi? transaksi;
  final AuthModel? auth;
  final DataCategory? category;

  @override
  State<NewAllProduct> createState() => _NewAllProductState();
}

class _NewAllProductState extends State<NewAllProduct> {
  final TextEditingController _searchController = TextEditingController();
  final int _perPage = 10;
  final PagingController<int, Datum> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      if (widget.category?.id == null) {
        _getProduct(pageKey);
      } else {
        _getCategoryById(id: widget.category!.id, page: pageKey);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
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
              'All Porduct',
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                color: Colors.white,
              ),
            ),
            Text(
              'lihat semua product di halaman ini',
              style: GoogleFonts.inter(
                fontSize: 10.sp,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                SharedCode.scanBarcode().then(
                  (value) => {
                    if (value != null)
                      {
                        context.loaderOverlay.show(),
                        ProductRepository()
                            .getProductbyCodeUnique(codeUnique: value)
                            .then((value) => {
                                  if (value.meta!.code == 200)
                                    {
                                      context.loaderOverlay.hide(),
                                      CartRepository().addCart(
                                          productId:
                                              value.data!.data!.first.id!,
                                          userId: widget.auth!.data!.user!.id!,
                                          transaksiId: widget.transaksi!.id!,
                                          quantity: 1),
                                    }
                                  else
                                    {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(value.meta!.message!),
                                      ))
                                    }
                                }),
                        if (value == "-1")
                          {
                            context.loaderOverlay.hide(),
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(
                                    auth: widget.auth,
                                    transaksi: widget.transaksi,
                                  ),
                                ),
                                (route) => false)
                          }
                      }
                  },
                );
              },
              icon: const Icon(
                Icons.qr_code_scanner,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          children: [
            TextfieldSearch(
              controller: _searchController,
              onChange: (value) {
                BlocProvider.of<ProductBloc>(context).add(
                    GetProductByNameEvent(productName: value, page: _perPage));
              },
            ),
            const SizedBox(height: 20),
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (_searchController.text != "") {
                  if (state is ProductLoaded) {
                    var product =
                        state.product.data!.data!.map((e) => e).toList();
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 5,
                        childAspectRatio: 135 / 300,
                      ),
                      itemCount: product.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {},
                          child: ProductCard(data: product[index]),
                        );
                      },
                    );
                  }
                }

                return PagedGridView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate<Datum>(
                    itemBuilder: (context, item, index) {
                      return ProductCard(
                        data: item,
                      );
                    },
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 5,
                    childAspectRatio: 135 / 300,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getProduct(int page) async {
    await ProductRepository().getProduct(page: page).then((value) {
      try {
        final isLastPage = value.data!.data!.length < _perPage;
        if (isLastPage) {
          _pagingController.appendLastPage(value.data!.data!);
        } else {
          final nextPageKey = page + 1;
          _pagingController.appendPage(value.data!.data!, nextPageKey);
        }
      } catch (e) {
        _pagingController.error = e;
      }
    });
  }

  Future<void> _getCategoryById({int? id, int? page}) async {
    await ProductRepository()
        .getProductbyCategory(categoryId: id, page: page)
        .then((value) {
      try {
        final isLastPage = value.data!.data!.length < _perPage;
        if (isLastPage) {
          _pagingController.appendLastPage(value.data!.data!);
        } else {
          final nextPageKey = page! + 1;
          _pagingController.appendPage(value.data!.data!, nextPageKey);
        }
      } catch (e) {
        _pagingController.error = e;
      }
    });
  }
}
