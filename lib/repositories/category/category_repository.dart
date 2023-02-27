import 'package:kasir/model/category/category_model.dart';
import 'package:kasir/repositories/category/base_category_repository.dart';
import 'package:http/http.dart' as http;

import '../../common/shared_code.dart';

class CategoryRepository implements BaseCategoryRepository {
  @override
  Future<CategoryModel> getCategory() async {
    final res = await http.get(Uri.parse("${SharedCode.baseUrl}/getCategory"));

    final category = categoryModelFromJson(res.body);

    if (res.statusCode == 200) {
      return category;
    } else {
      throw Exception('Category not found');
    }
  }
}
