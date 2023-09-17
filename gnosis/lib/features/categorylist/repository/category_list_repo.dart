import 'package:dio/dio.dart';
import 'package:gnosis/core/exceptions/api_exceptions.dart';
import 'package:gnosis/core/services/api_service.dart';
import 'package:gnosis/models/book_model.dart';

class CategoryListRepository {
  final ApiService apiService;
  final String baseURL = "library/";
  final String booksByCatagoryURL = "genre/";
  final String categoryListURL = "all-categories/";

  CategoryListRepository({required this.apiService});

  Future<List<BookModel>> getBooksByCategory(String category) async{
    final api = apiService.getApi();
    try {
      var response = api.get(baseURL + booksByCatagoryURL + category);
      return response.then((value) => BookModel.listFromJson(value.data));
    } on DioException catch (exception) {
      throw ApiException(exception: exception);
    }
  }
  Future<List<String>> getCategories()  async{
    final api = apiService.getApi();
    try {
      var response = await api.get(baseURL + categoryListURL);
      return (response.data as List).cast<String>();
    } on DioException catch (exception) {
      throw ApiException(exception: exception);
    }
  }
}
