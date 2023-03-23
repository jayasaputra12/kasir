import 'package:kasir/model/history/detail_history_model.dart';
import 'package:kasir/repositories/history/base_history_repository.dart';
import 'package:http/http.dart' as http;

import '../../common/shared_code.dart';
import '../../model/history/history_model.dart';

class HistoryRepository implements BaseHistoryRepository {
  @override
  Future<GetHistoryModel> getHistory(
      {required int userId, required int page}) async {
    final res = await http.get(Uri.parse(
        "${SharedCode.baseUrl}/getTransaksi?user_id=$userId&page=$page&status=Done"));

    if (res.statusCode == 200) {
      return getHistoryModelFromJson(res.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<DetailHistoryModel> detailHistory(
      {required int idTransaksi, required int page}) async {
    final res = await http.get(Uri.parse(
        "${SharedCode.baseUrl}/getReportPenjualan?id_transaksi=$idTransaksi&page=$page"));

    if (res.statusCode == 200) {
      return detailHistoryModelFromJson(res.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
