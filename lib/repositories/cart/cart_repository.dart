import 'dart:convert';

import 'package:kasir/common/shared_code.dart';
import 'package:kasir/model/cart/add_cart_model.dart';
import 'package:kasir/model/cart/detele_cart_model.dart';
import 'package:kasir/model/cart/get_cart_model.dart';
import 'package:kasir/model/cart/update_cart_model.dart';
import 'package:kasir/repositories/cart/base_cart_repository.dart';
import 'package:http/http.dart' as http;

class CartRepository implements BaseCartRepository {
  @override
  Future<AddCartModel> addCart(
      {required int productId,
      required int userId,
      required int transaksiId,
      required int quantity}) async {
    Map<String, dynamic> body = {
      'product_id': productId.toString(),
      'user_id': userId.toString(),
      'transaksi_id': transaksiId.toString(),
      'quantity': quantity.toString()
    };

    final res = await http.post(Uri.parse("${SharedCode.baseUrl}/createCart"),
        body: body);

    if (res.statusCode == 200) {
      return addCartModelFromJson(res.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<AddCartModel> updateQuantity(
      {required int id, required int quantity}) async {
    Map<String, dynamic> body = {'quantity': quantity.toString()};

    final res = await http
        .post(Uri.parse("${SharedCode.baseUrl}/updateCart/$id"), body: body);

    if (res.statusCode == 200) {
      return addCartModelFromJson(res.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<AddCartModel> deleteCart({required int id}) async {
    final res =
        await http.post(Uri.parse("${SharedCode.baseUrl}/deleteCart/$id"));

    if (res.statusCode == 200) {
      return addCartModelFromJson(res.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<GetCartModel> getCart({required int transaksiId}) async {
    final res = await http.get(
        Uri.parse("${SharedCode.baseUrl}/getCart?transaksi_id=$transaksiId"));

    if (res.statusCode == 200) {
      return getCartModelFromJson(res.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<DeleteCartModel> deleteCartByTransaksiId(
      {required int transaksiId}) async {
    final res = await http.post(
        Uri.parse("${SharedCode.baseUrl}/deleteByTransaksi/$transaksiId"));

    if (res.statusCode == 200) {
      return deleteCartModelFromJson(res.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
