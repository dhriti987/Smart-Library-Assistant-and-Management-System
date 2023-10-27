import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:gnosis/core/exceptions/api_exceptions.dart';
import 'package:gnosis/core/services/api_service.dart';

class AuthorListRepository{
  final ApiService apiService;

  AuthorListRepository({required this.apiService});

  Future<Uint8List> getImage(String url) async {
    final imageApi = apiService.getImageApi();
    try {
      var response = await imageApi.get(url);
      return response.data;
    } on DioException catch (exception) {
      throw ApiException(exception: exception);
    }
  }
}