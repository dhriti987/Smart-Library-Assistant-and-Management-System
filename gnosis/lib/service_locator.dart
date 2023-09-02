import 'package:get_it/get_it.dart';
import 'package:gnosis/core/router/router.dart';
import 'package:gnosis/core/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt sl = GetIt.instance;

void setup(){
  sl.registerSingletonAsync<SharedPreferences>(() async => await SharedPreferences.getInstance());
  sl.registerSingletonWithDependencies<ApiService>(() => ApiService(pref: sl()), dependsOn: [SharedPreferences]);
  sl.registerSingletonWithDependencies<AppRouter>(()=> AppRouter(pref: sl()), dependsOn: [SharedPreferences]);
}