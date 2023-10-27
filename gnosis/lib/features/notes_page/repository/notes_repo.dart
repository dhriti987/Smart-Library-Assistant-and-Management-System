import 'package:dio/dio.dart';
import 'package:gnosis/core/exceptions/api_exceptions.dart';
import 'package:gnosis/core/services/api_service.dart';
import 'package:gnosis/features/Sigin/repository/sign_in_repo.dart';
import 'package:gnosis/models/notes_model.dart';
import 'package:gnosis/models/user_model.dart';
import 'package:gnosis/service_locator.dart';

class NotesRepository{
  final ApiService apiService;

  final String baseURL = "notes/";
  final String createOrListNoteURL = "user-notes/";
  final String getUpdateDeleteURL = "edit-notes/";

  NotesRepository({required this.apiService});

  Future<NotesModel> createNewNote(String title) async{
    final UserModel userModel = sl.get<SignInRepository>().getUserData();
    final api = apiService.getApi();
    try {
      var response = await api.post(baseURL+createOrListNoteURL, data: {'title':title, 'user':int.parse(userModel.id)});
      print(response.data);
      return NotesModel.fromJson(response.data);
    } on DioException catch (exception) {
      print(exception.response);
      throw ApiException(exception: exception);
    }
  }

  Future<List<NotesModel>> getAllNotes() async{
    final api = apiService.getApi();
    try {
      var response = await api.get(baseURL+createOrListNoteURL);
      return NotesModel.listFromJson(response.data);
    } on DioException catch (exception){
      throw ApiException(exception: exception);
    }
    
  }

  Future<void> deleteNote(int id) async{
    final api = apiService.getApi();
    try {
      await api.delete("$baseURL$getUpdateDeleteURL$id");

    }on DioException catch (exception){
      throw ApiException(exception: exception);
    }
  }

  Future<NotesModel> updateNote(int id, String content) async{
    final api = apiService.getApi();
    try {
      var response = await api.patch("$baseURL$getUpdateDeleteURL$id", data: {'content':content});
      return NotesModel.fromJson(response.data);
    } on DioException catch (exception) {
      throw ApiException(exception: exception);
    }
  }
}