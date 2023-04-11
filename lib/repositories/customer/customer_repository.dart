import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:kasir/common/shared_code.dart';
import 'package:kasir/model/customer/create_customer_model.dart';
import 'package:kasir/model/customer/get_customer_model.dart';
import 'package:kasir/repositories/customer/base_customer_repositories.dart';
import 'package:http/http.dart' as http;

class CustomerRepository implements BaseCustomerRepositories {
  @override
  Future<CreateCustomerModel> createCustomer(
      {required String nama,
      required String nohp,
      required String alamat,
      required File photoKtp,
      required String limitMoney}) async {
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
    };

    var request = http.MultipartRequest(
        'POST', Uri.parse('${SharedCode.baseUrl}/createDataCustomer'))
      ..fields.addAll({
        'name_customer': nama,
        'phone': nohp,
        'address': alamat,
        'activate':'aktif',
        'limit_money': limitMoney,
      })
      ..files
          .add(await http.MultipartFile.fromPath('photo_ktp', photoKtp.path));

    var response = await request.send();
    debugPrint('response ${response.statusCode}');
    debugPrint('fields ${request.fields}');
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);

    CreateCustomerModel createCustomerModel =
        createCustomerModelFromJson(responseString);

    if (response.statusCode == 200) {
      return createCustomerModel;
    } else {
      throw Exception('Gagal membuat customer');
    }
  }

  Future<GetCustomerModel> getCustomer() async {
    var response = await http.get(Uri.parse('${SharedCode.baseUrl}/getDataCustomer'));

    if (response.statusCode == 200) {
      GetCustomerModel getCustomerModel = getCustomerModelFromJson(response.body);
      return getCustomerModel;
    } else {
      throw Exception('Gagal mendapatkan data customer');
    }
  }
}
