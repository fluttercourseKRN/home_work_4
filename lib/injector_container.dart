import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/datasources/remote/companies/companies_data_source_http.dart';
import 'data/datasources/remote/vacancies/vacancies_data_source_http.dart';
import 'data/datasources/storage/companies/companies_data_source_spref.dart';
import 'data/datasources/storage/vacancies/vacancies_data_source_spref.dart';
import 'data/models/companies_data_source_remote.dart';
import 'data/models/companies_data_source_storage.dart';
import 'data/models/vacancies_data_source_remote.dart';
import 'data/models/vacancies_data_source_storage.dart';
import 'data/repositories/companies_repository_impl.dart';
import 'data/repositories/vacancies_repository_impl.dart';
import 'domain/repositories/companies_repository.dart';
import 'domain/repositories/vacancies_repository.dart';
import 'domain/usecases/get_vacancies_list.dart';
import 'domain/usecases/toggle_vacancy_favorite_status.dart';

final sl = GetIt.instance;

Future<void> setUp() async {
  /// UseCases /////////////////////////////////////////////////////////////////

  sl.registerLazySingleton(() => GetVacanciesList(sl()));
  sl.registerLazySingleton(() => ToggleVacancyFavoriteStatus(sl()));

  //////////////////////////////////////////////////////////////////////////////
  /// Repositories /////////////////////////////////////////////////////////////

  sl.registerLazySingleton<VacanciesRepository>(
    () => VacanciesRepositoryImpl(
      dataSourceRemote: sl(),
      dataSourceStorage: sl(),
    ),
  );

  sl.registerLazySingleton<CompaniesRepository>(
    () => CompaniesRepositoryImpl(
      dataSourceRemote: sl(),
      dataSourceStorage: sl(),
    ),
  );

  //////////////////////////////////////////////////////////////////////////////
  /// Data Sources /////////////////////////////////////////////////////////////

  // Vacancies
  sl.registerLazySingleton<VacanciesDataSourceRemote>(
      () => VacanciesDataSourceHTTP());
  sl.registerLazySingleton<VacanciesDataSourceStorage>(
      () => VacanciesDataSourceSPref(sl()));
  // Companies
  sl.registerLazySingleton<CompaniesDataSourceRemote>(
      () => CompaniesDataSourceHttp());
  sl.registerLazySingleton<CompaniesDataSourceStorage>(
      () => CompaniesDataSourceSPref(sl()));

  //////////////////////////////////////////////////////////////////////////////
  /// 3-rd Library

  // SharedPreferences
  final sharPref = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharPref);
}
