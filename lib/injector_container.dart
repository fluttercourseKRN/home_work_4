import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:jobsin/domain/usecases/get_companies_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/abstractions/companies_data_source_remote.dart';
import 'data/abstractions/companies_data_source_storage.dart';
import 'data/abstractions/vacancies_data_source_remote.dart';
import 'data/abstractions/vacancies_data_source_storage.dart';
import 'data/datasources/remote/companies/companies_data_source_http.dart';
import 'data/datasources/remote/vacancies/vacancies_data_source_http.dart';
import 'data/datasources/storage/companies/companies_data_source_spref.dart';
import 'data/datasources/storage/vacancies/vacancies_data_source_spref.dart';
import 'data/repositories/companies_repository_impl.dart';
import 'data/repositories/vacancies_repository_impl.dart';
import 'domain/repositories/companies_repository.dart';
import 'domain/repositories/vacancies_repository.dart';
import 'domain/usecases/get_vacancies_list.dart';
import 'domain/usecases/toggle_company_favorite_status.dart';
import 'domain/usecases/toggle_vacancy_favorite_status.dart';

final sl = GetIt.instance;

Future<void> setUp() async {
  /// UseCases /////////////////////////////////////////////////////////////////

  sl.registerLazySingleton(() => GetVacanciesList(sl()));
  sl.registerLazySingleton(() => GetCompaniesList(sl()));
  sl.registerLazySingleton(() => ToggleVacancyFavoriteStatus(sl()));
  sl.registerLazySingleton(() => ToggleCompanyFavoriteStatus(sl()));

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
      () => VacanciesDataSourceHTTP(client: sl()));
  sl.registerLazySingleton<VacanciesDataSourceStorage>(
      () => VacanciesDataSourceSPref(sl()));
  // Companies
  sl.registerLazySingleton<CompaniesDataSourceRemote>(
      () => CompaniesDataSourceHttp(client: sl()));
  sl.registerLazySingleton<CompaniesDataSourceStorage>(
      () => CompaniesDataSourceSPref(sl()));

  //////////////////////////////////////////////////////////////////////////////
  /// 3-rd Library

  // Dio
  final httpClient = Dio();
  sl.registerLazySingleton(() => httpClient);

  // SharedPreferences
  final sharPref = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharPref);
}
