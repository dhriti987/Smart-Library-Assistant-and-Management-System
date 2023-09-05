import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  final SharedPreferences pref;

  ApiService( {required this.pref});

  BaseOptions getApiOptions() {
    final token = pref.getString("token")?? "";
    final apiOptions = BaseOptions(
      baseUrl: dotenv.env['SERVER_URL'] ?? "http://127.0.0.1:8000",
      connectTimeout: const Duration(seconds: 5),
      headers: {
        "Authorization": "Token $token"
      }
    );
    return apiOptions;
  }

  BaseOptions getApiOptionsWithoutHeader() {
    final apiOptions = BaseOptions(
      baseUrl: dotenv.env['SERVER_URL'] ?? "http://127.0.0.1:8000",
      connectTimeout: const Duration(seconds: 5),
    );
    return apiOptions;
  }

  BaseOptions getImageApiOptions(){
    return BaseOptions(
    responseType: ResponseType.bytes,
    headers: Map.from({
      'Accept': '*/*',
      'User-Agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36'
    }));
  }

  Dio getApi(){
    return Dio(getApiOptions());
  }
  Dio getApiWithoutHeader(){
    return Dio(getApiOptionsWithoutHeader());
  }
  Dio getImageApi(){
    return Dio(getImageApiOptions());
  }

}
