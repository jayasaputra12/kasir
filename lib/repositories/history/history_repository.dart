import 'package:kasir/repositories/history/base_history_repository.dart';
import 'package:http/http.dart' as http;

import '../../common/shared_code.dart';
import '../../model/history/history_model.dart';

class HistoryRepository implements BaseHistoryRepository {
  @override
  Future<GetHistoryModel> getHistory({required int userId}) async {
    final res = await http
        .get(Uri.parse("${SharedCode.baseUrl}/getReportPenjualan?user_id=$userId"));

    if (res.statusCode == 200) {
      return getHistoryModelFromJson(res.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
