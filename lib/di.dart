import 'package:jobsin/data/repositories/data_repository.dart';
import 'package:jobsin/domain/repositories/repository.dart';

import 'data/datasources/remote/remote_data_source.dart';
import 'data/datasources/storage/datasources/local_data_storage.dart';
import 'data/repositories/data_source_remote.dart';
import 'data/repositories/data_source_storage.dart';

class DI {
  DI._internal();
  static final DI _instance = DI._internal();
  static DI get instance {
    return _instance;
  }

  // late final DataProvider provider;
  late final Repository repository;
  late final DataSourceRemote _dataSource;
  late final DataSourceStorage _dataStorage;

  static Future<void> setUp() async {
    /// DataSource
    _instance._dataSource = RemoteDataSource();

    /// DataStorage
    _instance._dataStorage = await LocalDataStorage.init();

    /// Repository
    _instance.repository = DataRepository(
      dataSource: _instance._dataSource,
      dataStorage: _instance._dataStorage,
    );

    // /// DataProvider
    // _instance.provider = DataProvider(repository: _instance.repository);
  }
}
