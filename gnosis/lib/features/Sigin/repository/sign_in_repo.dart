import 'package:dio/dio.dart';
import 'package:gnosis/core/exceptions/api_exceptions.dart';
import 'package:gnosis/core/services/api_service.dart';
import 'package:gnosis/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInRepository {
  final ApiService apiService;
  final SharedPreferences pref;
  final signInURL = "authentication/token/";

  SignInRepository({required this.apiService, required this.pref});

  Future<void> signIn(String email, String password) async {
    final api = apiService.getApiWithoutHeader();
    FormData data = FormData.fromMap({"username": email, "password": password});
    try {
      var response = await api.post(signInURL, data: data);
      print(response.data);
      await pref.setString("token", response.data["token"]);
      await pref.setString("email", response.data["email"]);
      await pref.setString("id", response.data["user_id"].toString());
      await pref.setString("name", response.data['username'] ?? "Unkown");
    } on DioException catch (exception) {
      print(exception.response);
      throw ApiException(exception: exception);
    }
  }

  UserModel getUserData() {
    final email = pref.getString("email");
    final name = pref.getString("name");
    final id = pref.getString("id");
    if (email == null || name == null || id == null) {
      throw Exception(["User details Not Found", "User Not Logined"]);
    }
    return UserModel(id: id, name: name, email: email);
  }
}
