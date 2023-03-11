import 'package:kasir/model/reportPenjualan/create_report_model.dart';
import 'package:kasir/model/stok/terjual_model.dart';
import 'package:kasir/repositories/report/base_report_repository.dart';
import 'package:http/http.dart' as http;

import '../../common/shared_code.dart';
import '../../model/stok/update_stok_model.dart';

class ReportRepository implements BaseReportRepository {
  @override
  Future<CreateReportPenjualan> createReportCash({
    String? productId,
    String? quantitySale,
    String? payment,
    String? paymentTerm,
    String? idTransaksi,
    String? userId,
  }) async {
    final res = await http
        .post(Uri.parse("${SharedCode.baseUrl}/createReportPenjualan"), body: {
      "product_id": productId,
      "quantity_sale": quantitySale,
      "payment": payment,
      "payment_term": paymentTerm,
      "id_transaksi": idTransaksi,
      "user_id": userId,
    });

    final report = createReportPenjualanFromJson(res.body);

    if (res.statusCode == 200) {
      return report;
    } else {
      throw Exception('Report not found');
    }
  }

  Future<CreateReportPenjualan> createReportTempo({
    String? productId,
    String? quantitySale,
    String? payment,
    String? paymentTerm,
    String? idTransaksi,
    String? customerId,
    String? userId,
  }) async {
    final res = await http
        .post(Uri.parse("${SharedCode.baseUrl}/createReportPenjualan"), body: {
      "product_id": productId,
      "quantity_sale": quantitySale,
      "payment": payment,
      "payment_term": paymentTerm,
      "id_transaksi": idTransaksi,
      "customer_id": customerId,
      "user_id": userId,
    });

    final report = createReportPenjualanFromJson(res.body);

    if (res.statusCode == 200) {
      return report;
    } else {
      throw Exception('Report not found');
    }
  }

  Future<UpdateStokModel> updateStok({
    String? idProduct,
    String? decrease,
  }) async {
    final res = await http
        .post(Uri.parse("${SharedCode.baseUrl}/updateStock/$idProduct"), body: {
      "decrease": decrease,
    });

    final stok = updateStokModelFromJson(res.body);

    if (res.statusCode == 200) {
      return stok;
    } else {
      throw Exception('Stok not found');
    }
  }

  Future<TerjualModelStok> terjualStok(
      {String? idProduct, String? increase}) async {
    final res = await http.post(
        Uri.parse("${SharedCode.baseUrl}/updatePenjualanCashier/$idProduct"),
        body: {
          "increase": increase,
        });

    final stok = terjualModelStokFromJson(res.body);

    if (res.statusCode == 200) {
      return stok;
    } else {
      throw Exception('Stok not found');
    }
  }
}
