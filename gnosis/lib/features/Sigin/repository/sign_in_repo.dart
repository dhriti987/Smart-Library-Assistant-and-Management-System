import 'package:dio/dio.dart';
import 'package:gnosis/core/exceptions/api_exceptions.dart';
import 'package:gnosis/core/services/api_service.dart';
import 'package:gnosis/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInRepository{
  final ApiService apiService;
  final SharedPreferences pref;
  final signInURL = "authentication/token/";

  SignInRepository({required this.apiService, required this.pref});
  
  Future<void> signIn(String email, String password) async{
    final api = apiService.getApi();
    FormData data = FormData.fromMap({
      "username": email,
      "password": password
    });
    try {
      var response = await api.post(signInURL, data: data);
      await pref.setString("token", response.data["token"]);
      await pref.setString("email", response.data["email"]);
      await pref.setString("name", response.data['username']);
    }on DioException catch (exception) {
      throw ApiException(exception: exception);
    }
  }

  UserModel getUserData(){
    final email = pref.getString("email");
    final name = pref.getString("name");
    if(email == null || name == null){
      throw Exception(["User details Not Found","User Not Logined"]);
    }
    return UserModel(name: name, email: email);
  }

}