import 'package:dio/dio.dart';
import 'package:new_camelclub/data/repository/auth_repo.dart';
import 'package:new_camelclub/data/repository/category_repo.dart';

import 'package:new_camelclub/data/repository/language_repo.dart';

import 'package:new_camelclub/data/repository/splash_repo.dart';
import 'package:new_camelclub/provider/auth_provider.dart';
import 'package:new_camelclub/provider/home_provider.dart';

import 'package:new_camelclub/provider/localization_provider.dart';

import 'package:new_camelclub/provider/language_provider.dart';
import 'package:new_camelclub/provider/notifications_provider.dart';
import 'package:new_camelclub/provider/reportsjson_provider.dart';

import 'package:new_camelclub/provider/splash_provider.dart';
import 'package:new_camelclub/provider/theme_provider.dart';
import 'package:new_camelclub/utill/app_constants.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/datasource/remote/dio/dio_client.dart';
import 'data/datasource/remote/dio/logging_interceptor.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton(() => DioClient(AppConstants.BASE_URL, sl(), loggingInterceptor: sl(), sharedPreferences: sl()));

  // Repository
  sl.registerLazySingleton(() => SplashRepo(sharedPreferences: sl(), dioClient: sl()));

  sl.registerLazySingleton(() => LanguageRepo());

  sl.registerLazySingleton(() => AuthRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => CategoryRepo(dioClient: sl()));


  // Provider
  sl.registerFactory(() => ThemeProvider(sharedPreferences: sl()));
  sl.registerFactory(() => SplashProvider(splashRepo: sl(),sharedPreferences: sl()));
  sl.registerFactory(() => LocalizationProvider(sharedPreferences: sl()));
  sl.registerFactory(() => LanguageProvider(languageRepo: sl()));

  sl.registerFactory(() => AuthProvider(authRepo: sl()));
  sl.registerFactory(() => HomeProvider(categoryRepo: sl(),sharedPreferences: sl()));
  sl.registerFactory(() => NotificationsProvider(categoryRepo: sl(),sharedPreferences: sl()));
  sl.registerFactory(() => ReportssProvider(categoryRepo: sl(),sharedPreferences: sl()));


  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
}
