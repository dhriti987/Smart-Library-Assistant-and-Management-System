import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:gnosis/core/exceptions/api_exceptions.dart';
import 'package:gnosis/core/services/api_service.dart';
import 'package:gnosis/models/book_model.dart';

class HomeRepository {
  final ApiService apiService;
  final String baseURL = "library/";
  final String recommendBooksURL = "recommendations/";
  final String topRatedBooksURL = "best-books/";
  final String topRatedBooksByCatagoryURL = "genre/";
  final String newlyLaunchedBooksURL = "best-books/";

  HomeRepository({required this.apiService});

  Future<List<BookModel>> getRecommendedBooks() async {
    final api = apiService.getApi();
    try {
      var response = await api.get(baseURL + recommendBooksURL);
      return BookModel.listFromJson(response.data);
    } on DioException catch (exception) {
      print(exception.response);
      throw ApiException(exception: exception);
    }
  }

  Future<List<BookModel>> getTopRatedBooks() async {
    final api = apiService.getApi();
    try {
      var response = await api.get(baseURL + topRatedBooksURL);
      return BookModel.listFromJson(response.data);
    } on DioException catch (exception) {
      throw ApiException(exception: exception);
    }
  }

  Future<List<BookModel>> getTopRatedBooksByCatagory(String catagory) async {
    final api = apiService.getApi();
    try {
      var response =
          await api.get(baseURL + topRatedBooksByCatagoryURL + catagory);
      return BookModel.listFromJson(response.data);
    } on DioException catch (exception) {
      throw ApiException(exception: exception);
    }
  }

  Future<List<BookModel>> getNewlyLaunchedBooks(String catagory) async {
    final api = apiService.getApi();
    try {
      var response = await api.get(baseURL + newlyLaunchedBooksURL);
      return BookModel.listFromJson(response.data);
    } on DioException catch (exception) {
      throw ApiException(exception: exception);
    }
  }

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
