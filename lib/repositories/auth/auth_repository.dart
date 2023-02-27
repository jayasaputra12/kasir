import 'package:kasir/common/shared_code.dart';
import 'package:kasir/repositories/auth/base_auth_repository.dart';

import '../../model/auth/auth_model.dart';
import 'package:http/http.dart' as http;

class AuthRepository implements BaseAuthRepository {
  @override
  Future<AuthModel> login(
      {required String email, required String password}) async {
    Map<String, dynamic> data = {'email': email, 'password': password};
    final res =
        await http.post(Uri.parse("${SharedCode.baseUrl}/login"), body: data);

    final auth = authModelFromJson(res.body);

    if (res.statusCode == 200) {
      if (auth.data!.user!.role == "kasir") {
        return auth;
      } else {
        throw Exception('Anda bukan karyawan kasir');
      }
    } else {
      throw Exception('User not found');
    }
  }
}
