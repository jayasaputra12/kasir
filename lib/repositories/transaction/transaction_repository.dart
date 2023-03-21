import 'package:kasir/common/shared_code.dart';
import 'package:kasir/model/transaction/create_transaksi_model.dart';
import 'package:kasir/repositories/transaction/base_transaction_repository.dart';
import 'package:http/http.dart' as http;

class TransactionRepository implements BaseTransactionRepository {
  @override
  Future<CreateTransaksiModel> createTransaksi({required int userId}) async {
    final res = await http.post(
      Uri.parse("${SharedCode.baseUrl}/createTransaksi"),
      body: {
        'user_id': userId.toString(),
      },
    );

    if (res.statusCode == 200) {
      return createTransaksiModelFromJson(res.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
