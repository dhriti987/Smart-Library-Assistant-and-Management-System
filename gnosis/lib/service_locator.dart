import 'package:get_it/get_it.dart';
import 'package:gnosis/core/router/router.dart';
import 'package:gnosis/core/services/api_service.dart';
import 'package:gnosis/features/Sigin/bloc/signin_bloc.dart';
import 'package:gnosis/features/Sigin/repository/sign_in_repo.dart';
import 'package:gnosis/features/book_description/bloc/book_description_bloc.dart';
import 'package:gnosis/features/booklist/bloc/book_list_bloc.dart';
import 'package:gnosis/features/categorylist/bloc/category_list_bloc.dart';
import 'package:gnosis/features/categorylist/repository/category_list_repo.dart';
import 'package:gnosis/features/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:gnosis/features/home/bloc/home_bloc.dart';
import 'package:gnosis/features/home_page/bloc/home_page_bloc.dart';
import 'package:gnosis/features/home_page/repository/home_repo.dart';
import 'package:gnosis/features/menu/bloc/menu_bloc.dart';
import 'package:gnosis/features/notes_editor/bloc/notes_editor_bloc.dart';
import 'package:gnosis/features/notes_page/bloc/notes_bloc.dart';
import 'package:gnosis/features/notes_page/repository/notes_repo.dart';
import 'package:gnosis/features/search/bloc/search_bloc.dart';
import 'package:gnosis/features/search/repository/search_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt sl = GetIt.instance;

void setup() {
  sl.registerSingletonAsync<SharedPreferences>(
      () async => await SharedPreferences.getInstance());
  sl.registerSingletonWithDependencies<ApiService>(() => ApiService(pref: sl()),
      dependsOn: [SharedPreferences]);
  sl.registerSingletonWithDependencies<AppRouter>(() => AppRouter(pref: sl()),
      dependsOn: [SharedPreferences]);

  //features
  sl.registerFactory(() => SigninBloc());
  sl.registerFactory(() => HomePageBloc());
  sl.registerFactory(() => HomeBloc());
  sl.registerFactory(() => ForgotPasswordBloc());
  sl.registerFactory(() => BookListBloc());
  sl.registerFactory(() => CategoryListBloc());
  sl.registerFactory(() => NotesBloc());
  sl.registerFactory(() => NotesEditorBloc());
  sl.registerFactory(() => BookDescriptionBloc());
  sl.registerFactory(() => SearchBloc());
  sl.registerFactory(() => MenuBloc());

  //repositories
  sl.registerSingletonWithDependencies<SignInRepository>(
      () => SignInRepository(apiService: sl(), pref: sl()),
      dependsOn: [ApiService, SharedPreferences]);
  sl.registerSingletonWithDependencies<HomeRepository>(
      () => HomeRepository(apiService: sl()),
      dependsOn: [ApiService]);
  sl.registerSingletonWithDependencies<CategoryListRepository>(
    () => CategoryListRepository(apiService: sl()),
    dependsOn: [ApiService]);
  sl.registerSingletonWithDependencies<NotesRepository>(
    () => NotesRepository(apiService: sl()),
    dependsOn: [ApiService]);
  sl.registerSingletonWithDependencies<SearchRepository>(
    () => SearchRepository(apiService: sl()),
    dependsOn: [ApiService]);
}
