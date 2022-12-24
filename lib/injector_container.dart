import 'package:get_it/get_it.dart';
import 'package:jobsin/data/datasources/remote/data_source_remote_http.dart';
import 'package:jobsin/data/models/data_source_remote.dart';
import 'package:jobsin/data/models/data_source_storage.dart';
import 'package:jobsin/domain/repositories/repository.dart';
import 'package:jobsin/domain/usecases/get_vacancies_list.dart';

import 'data/datasources/storage/data_source_storege_sp.dart';
import 'data/repositories/data_repository.dart';

final sl = GetIt.instance;

Future<void> setUp() async {
  ///UseCases
  sl.registerLazySingleton(() => GetVacanciesList(sl()));

  ///Repository
  sl.registerLazySingleton<Repository>(
    () => DataRepository(
      dataSourceRemote: sl(),
      dataSourceStorage: sl(),
    ),
  );

  ///Data Sources
  sl.registerLazySingleton<DataSourceRemote>(() => DataSourceRemoteHttp());
  final dataStorage = await DataSourceStorageSP.init();
  sl.registerLazySingleton<DataSourceStorage>(() => dataStorage);
}
