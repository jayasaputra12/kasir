import 'package:kasir/common/shared_code.dart';
import 'package:kasir/model/product/product_model.dart';
import 'package:kasir/repositories/product/base_product_repository.dart';
import 'package:http/http.dart' as http;

class ProductRepository implements BaseProductRepostirory {
  @override
  Future<ProductModel> getProduct({int? page}) async {
    final res = await http
        .get(Uri.parse("${SharedCode.baseUrl}/getProduct?page=$page"));

    print("${SharedCode.baseUrl}/getProduct?page=$page");

    final product = productModelFromJson(res.body);

    if (res.statusCode == 200) {
      return product;
    } else {
      throw Exception('Product not found');
    }
  }

  Future<ProductModel> getProductbyCategory(
      {int? page, int? categoryId}) async {
    final res = await http.get(Uri.parse(
        "${SharedCode.baseUrl}/getProduct?category_id=$categoryId&page=$page"));

    print("${SharedCode.baseUrl}/getProduct?category_id=$categoryId");

    final product = productModelFromJson(res.body);

    if (res.statusCode == 200) {
      return product;
    } else {
      throw Exception('Product not found');
    }
  }

  Future<ProductModel> getProductbyName({String? productName, int? page}) async {
    final res = await http.get(Uri.parse(
        "${SharedCode.baseUrl}/getProduct?name_product=$productName&page=$page"));

    final product = productModelFromJson(res.body);

    if (res.statusCode == 200) {
      return product;
    } else {
      throw Exception('Product not found');
    }
  }
}
