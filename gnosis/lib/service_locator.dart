import 'package:get_it/get_it.dart';
import 'package:gnosis/core/router/router.dart';
import 'package:gnosis/core/services/api_service.dart';
import 'package:gnosis/features/Sigin/bloc/signin_bloc.dart';
import 'package:gnosis/features/Sigin/repository/sign_in_repo.dart';
import 'package:gnosis/features/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:gnosis/features/home/bloc/home_bloc.dart';
import 'package:gnosis/features/home_page/bloc/home_page_bloc.dart';
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

  //repositories
  sl.registerSingletonWithDependencies<SignInRepository>(
      () => SignInRepository(apiService: sl(), pref: sl()),
      dependsOn: [ApiService, SharedPreferences]);
}
