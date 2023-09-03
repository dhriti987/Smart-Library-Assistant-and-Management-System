import 'package:dio/dio.dart';

class ApiException implements Exception{
  final DioException exception;

  ApiException({required this.exception});
  List<String> call(){
    print(exception.response);
    print(exception.type);
    switch (exception.type) {
      case DioExceptionType.connectionError:
        return ["Conectivity Error","Could not Connect to the Server, Please Check Your Internet Connection."];
      default:
        return ["Error", "Unknown Error occured."];
    }
  }
}