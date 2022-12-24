import 'package:jobsin/data/repositories/data_repository.dart';
import 'package:jobsin/domain/repositories/repository.dart';

import 'data/datasources/remote/data_source_remote_http.dart';
import 'data/datasources/storage/data_source_storege_sp.dart';
import 'data/models/data_source_remote.dart';
import 'data/models/data_source_storage.dart';

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
    _instance._dataSource = DataSourceRemoteHttp();

    /// DataStorage
    _instance._dataStorage = await DataSourceStorageSP.init();

    /// Repository
    _instance.repository = DataRepository(
      dataSourceRemote: _instance._dataSource,
      dataSourceStorage: _instance._dataStorage,
    );

    // /// DataProvider
    // _instance.provider = DataProvider(repository: _instance.repository);
  }
}
