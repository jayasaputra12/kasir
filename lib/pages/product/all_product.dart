import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:kasir/bloc/product/product_bloc.dart';
import 'package:kasir/model/category/category_model.dart';
import 'package:kasir/pages/navigation/home/home_page.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';

import '../../common/shared_code.dart';
import '../../model/auth/auth_model.dart';
import '../../model/product/product_model.dart';
import '../../model/transaction/create_transaksi_model.dart';
import '../../repositories/cart/cart_repository.dart';
import '../../repositories/product/product_repository.dart';
import '../../widget/product_card.dart';
import '../../widget/textfield_search.dart';
import 'detail_product.dart';

class AllProduct extends StatefulWidget {
  AllProduct({this.transaksi, this.auth, this.category, key});
  DataTransaksi? transaksi;
  DataCategory? category;
  AuthModel? auth;

  @override
  State<AllProduct> createState() => _AllProductState();
}

class _AllProductState extends State<AllProduct> {
  static const _pageSize = 20;
  int currentPage = 1;
  List<Datum>? listProduct;
  int totalPages = 0;
  bool _isLoading = false;
  int _totalItems = 0;
  ScrollController scrollController = ScrollController();
  bool onNotification(ScrollNotification scrollNotification) {
    if (scrollNotification is ScrollUpdateNotification) {
      if (scrollController.position.maxScrollExtent > scrollController.offset &&
          scrollController.position.maxScrollExtent - scrollController.offset <=
              50) {
        currentPage += 1;
        print("current page $currentPage");
        setState(() {
          _isLoading = true;

          widget.category?.id == null
              ? ProductRepository()
                  .getProduct(page: currentPage)
                  .then((response) {
                  if (response.data!.data!.isNotEmpty) {
                    setState(() {
                      listProduct!.addAll(response.data!.data!);
                      currentPage = response.data!.lastPage!;
                      _isLoading = false;
                    });
                    // if (currentPage >= response.data!.lastPage!) {
                    //   setState(() {
                    //     listProduct!.addAll(response.data!.data!);
                    //     currentPage = response.data!.lastPage!;
                    //     _isLoading = false;
                    //   });
                    // }
                  } else {
                    setState(() {
                      _isLoading = false;
                    });
                  }
                })
              : ProductRepository()
                  .getProductbyCategory(
                      categoryId: widget.category!.id, page: currentPage)
                  .then((response) {
                  if (response.data!.data!.isNotEmpty) {
                    setState(() {
                      listProduct!.addAll(response.data!.data!);
                      currentPage = response.data!.lastPage!;
                      _isLoading = false;
                    });
                    // if (currentPage >= response.data!.lastPage!) {
                    //   setState(() {
                    //     listProduct!.addAll(response.data!.data!);
                    //     currentPage = response.data!.lastPage!;
                    //     _isLoading = false;
                    //   });
                    // }
                  } else {
                    setState(() {
                      _isLoading = false;
                    });
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
    widget.category?.id == null
        ? ProductRepository().getProduct(page: currentPage).then((response) {
            if (response != null) {
              setState(() {
                listProduct = response.data!.data!;
                totalPages = response.data!.total!;
              });
            }
          })
        : ProductRepository()
            .getProductbyCategory(
                categoryId: widget.category!.id, page: currentPage)
            .then((response) {
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
    scrollController.dispose();
    super.dispose();
  }

  final TextEditingController _searchController = TextEditingController();
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
      body: NotificationListener(
        onNotification: onNotification,
        child: SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextfieldSearch(
                controller: _searchController,
                onChange: (value) {
                  BlocProvider.of<ProductBloc>(context).add(
                      GetProductByNameEvent(
                          productName: value, page: currentPage));
                },
              ),
              const SizedBox(height: 20),
              FutureBuilder(
                future: widget.category?.id == null
                    ? ProductRepository().getProduct(page: currentPage)
                    : ProductRepository().getProductbyCategory(
                        categoryId: widget.category!.id!, page: currentPage),
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
                      return BlocBuilder<ProductBloc, ProductState>(
                        builder: (context, state) {
                          if (_searchController.text != "") {
                            if (state is ProductLoaded) {
                              var product = state.product.data!.data!
                                  .map((e) => e)
                                  .toList();
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
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailProductPage(
                                            transaksi: widget.transaksi,
                                            data: product[index],
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
                                    child: ProductCard(data: product[index]),
                                  );
                                },
                              );
                            }
                          }
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
              // BlocBuilder<ProductBloc, ProductState>(
              //   builder: (context, state) {
              //     if (state is ProductLoading) {
              //       return const Center(
              //         child: CircularProgressIndicator(
              //           color: Color(0xff1B9C42),
              //         ),
              //       );
              //     }
              //     if (state is ProductLoaded) {
              //       var product =
              //           state.product.data!.data!.map((e) => e).toList();
              //       return GridView.builder(
              //         shrinkWrap: true,
              //         physics: const NeverScrollableScrollPhysics(),
              //         gridDelegate:
              //             const SliverGridDelegateWithFixedCrossAxisCount(
              //           crossAxisCount: 2,
              //           crossAxisSpacing: 15,
              //           mainAxisSpacing: 5,
              //           childAspectRatio: 138 / 300,
              //         ),
              //         itemCount: product.length,
              //         itemBuilder: (context, index) {
              //           return InkWell(
              //             onTap: () {
              //               Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                   builder: (context) => DetailProductPage(
              //                     transaksi: widget.transaksi,
              //                     data: product[index],
              //                     auth: widget.auth,
              //                     refresh: () {
              //                       CartRepository()
              //                           .getCart(
              //                               transaksiId: widget.transaksi!.id!)
              //                           .then((value) {
              //                         var qtyLength = value.data!
              //                             .map((e) => e.quantity)
              //                             .length;
              //                         setState(() {
              //                           _totalItems = qtyLength;
              //                         });
              //                       });
              //                     },
              //                   ),
              //                 ),
              //               );
              //             },
              //             child: ProductCard(data: product[index]),
              //           );
              //         },
              //       );
              //     }
              //     return FutureBuilder(
              //       future: widget.category?.id == null
              //           ? ProductRepository().getProduct(page: currentPage)
              //           : ProductRepository().getProductbyCategory(
              //               categoryId: widget.category!.id!,
              //               page: currentPage),
              //       builder: (context, snapshot) {
              //         if (snapshot.data == null) {
              //           return const Center(
              //             child: CircularProgressIndicator(
              //               color: Color(0xff1B9C42),
              //             ),
              //           );
              //         }
              //         if (snapshot.hasData) {
              //           if (listProduct != null) {
              //             return GridView.builder(
              //               shrinkWrap: true,
              //               physics: const NeverScrollableScrollPhysics(),
              //               gridDelegate:
              //                   const SliverGridDelegateWithFixedCrossAxisCount(
              //                 crossAxisCount: 2,
              //                 crossAxisSpacing: 15,
              //                 mainAxisSpacing: 5,
              //                 childAspectRatio: 138 / 300,
              //               ),
              //               itemCount: listProduct!.length,
              //               itemBuilder: (context, index) {
              //                 return InkWell(
              //                   onTap: () {
              //                     Navigator.push(
              //                       context,
              //                       MaterialPageRoute(
              //                         builder: (context) => DetailProductPage(
              //                           transaksi: widget.transaksi,
              //                           data: listProduct![index],
              //                           auth: widget.auth,
              //                           refresh: () {
              //                             CartRepository()
              //                                 .getCart(
              //                                     transaksiId:
              //                                         widget.transaksi!.id!)
              //                                 .then((value) {
              //                               var qtyLength = value.data!
              //                                   .map((e) => e.quantity)
              //                                   .length;
              //                               setState(() {
              //                                 _totalItems = qtyLength;
              //                               });
              //                             });
              //                           },
              //                         ),
              //                       ),
              //                     );
              //                   },
              //                   child: ProductCard(data: listProduct![index]),
              //                 );
              //               },
              //             );
              //           } else {
              //             return const Center(
              //                 child: CircularProgressIndicator(
              //               color: Color(0xff1B9C42),
              //             ));
              //           }
              //         } else if (snapshot.hasError) {
              //           return Center(
              //             child: Text(
              //               "Product tidak ada",
              //               style: GoogleFonts.inter(
              //                 fontSize: 12.sp,
              //                 fontWeight: FontWeight.w400,
              //               ),
              //             ),
              //           );
              //         } else if (snapshot.connectionState ==
              //             ConnectionState.waiting) {
              //           return const Center(
              //             child: CircularProgressIndicator(
              //               color: Color(0xff1B9C42),
              //             ),
              //           );
              //         }
              //         return const Center(
              //           child: CircularProgressIndicator(
              //             color: Color(0xff1B9C42),
              //           ),
              //         );
              //       },
              //     );
              //   },
              // ),
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
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
