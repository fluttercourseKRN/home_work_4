import 'package:jobsin/data/remote/datasources/remote_data_source.dart';
import 'package:jobsin/data/repositories/data_repository.dart';
import 'package:jobsin/data/storage/datasources/local_data_storage.dart';
import 'package:jobsin/domain/repositories/repository.dart';
import 'package:jobsin/presentation/providers/data_provider.dart';

class DI {
  DI._internal();
  static final DI _instance = DI._internal();
  static DI get instance {
    return _instance;
  }

  late final DataProvider provider;
  late final DataSource _dataSource;
  late final DataStorage _dataStorage;
  late final Repository _repository;

  static Future<void> setUp() async {
    /// DataSource
    _instance._dataSource = RemoteDataSource();

    /// DataStorage
    _instance._dataStorage = await LocalDataStorage.init();

    /// Repository
    _instance._repository = DataRepository(
      dataSource: _instance._dataSource,
      dataStorage: _instance._dataStorage,
    );

    /// DataProvider
    _instance.provider = DataProvider(repository: _instance._repository);
  }
}
