import 'package:dio/dio.dart';
import 'package:gnosis/core/exceptions/api_exceptions.dart';
import 'package:gnosis/core/services/api_service.dart';
import 'package:gnosis/models/book_model.dart';

class SearchRepository {
    final ApiService apiService;
    final String baseURL = "library/";
    final String searchURL = 'searchBooks/';
    final String resolveQueryURL = 'resolver-query/';

  SearchRepository({required this.apiService});

  Future<List<BookModel>> search(String searchQuery) async{
    final api = apiService.getApi();

    try {
      var response = await api.get(baseURL+searchURL,queryParameters: {"q":searchQuery});
      return BookModel.listFromJson(response.data);    
    }on DioException catch (exception) {
      throw ApiException(exception: exception);
    }
  }

  Future<Map<String,dynamic>> resolveQuery(String query) async{
    final api = apiService.getApi();
    print(query);
    try {
      var response = await api.post(baseURL+resolveQueryURL,data: FormData.fromMap({"text":query}));
      return response.data;
    }on DioException catch (exception) {
      print(exception.response);
      throw ApiException(exception: exception);
    }
  }

}