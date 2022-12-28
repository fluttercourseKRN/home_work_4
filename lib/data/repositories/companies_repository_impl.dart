import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../domain/entities/company.dart';
import '../../domain/model/enums/companies_sort_element.dart';
import '../../domain/repositories/companies_repository.dart';
import '../abstractions/companies_data_source_remote.dart';
import '../abstractions/companies_data_source_storage.dart';

class CompaniesRepositoryImpl extends CompaniesRepository {
  final CompaniesDataSourceRemote dataSourceRemote;
  final CompaniesDataSourceStorage dataSourceStorage;

  CompaniesRepositoryImpl({
    required this.dataSourceRemote,
    required this.dataSourceStorage,
  });

  @override
  Future<Either<Failure, List<Company>>> getCompaniesList({
    required bool favoritesOnly,
    required CompaniesSortElement sortElement,
  }) async {
    final companies = await dataSourceRemote.getCompanies();
    if (companies == null) {
      return Left(ServerFailure());
    } else {
      var result = await _setFavoriteCompany(companies);
      result = await _setMyCompany(result);
      result = _companiesFavoriteFilter(result, favoritesOnly);
      result = _sortCompanies(result, sortElement);

      return Right(result);
    }
  }

  @override
  Future<Either<Failure, bool>> saveCompanyToFavorite(int companyId) async {
    try {
      await dataSourceStorage.saveCompanyToFavorite(companyId);
      return const Right(true);
    } catch (e) {
      return Left(StorageFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteCompanyFromFavorite(int companyId) async {
    try {
      await dataSourceStorage.deleteCompanyFromFavorite(companyId);
      return const Right(false);
    } catch (e) {
      return Left(StorageFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> addCompany(Company company) async {
    final int companyId;
    try {
      companyId = await dataSourceRemote.addCompany(company);
    } catch (e) {
      return Left(ServerFailure());
    }
    try {
      await dataSourceStorage.addCompany(companyId);
    } catch (e) {
      return Left(StorageFailure());
    }
    return const Right(true);
  }

  @override
  Future<Either<Failure, bool>> deleteCompany(int companyId) async {
    final bool remoteDelete;
    try {
      remoteDelete = await dataSourceRemote.deleteCompany(companyId);
    } catch (e) {
      return Left(ServerFailure());
    }
    if (remoteDelete) {
      try {
        await dataSourceStorage.deleteCompany(companyId);
        return const Right(true);
      } catch (e) {
        return Left(StorageFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Company>>> getMyCompanies() async {
    final List<int> myCompanyIds;
    try {
      myCompanyIds = await _getMyCompaniesIds();
    } catch (e) {
      return Left(StorageFailure());
    }
    try {
      final result = await dataSourceRemote.getCompanies();
      if (result != null) {
        return Right(result);
      } else {
        return Left(ServerFailure());
      }
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}

/// Helpers
extension HelpersPart on CompaniesRepositoryImpl {
  List<Company> _sortCompanies(
    List<Company> companies,
    CompaniesSortElement sortElement,
  ) {
    switch (sortElement) {
      case CompaniesSortElement.none:
        break;
      case CompaniesSortElement.name:
        companies.sort((a, b) => a.name.compareTo(b.name));
        break;
      case CompaniesSortElement.industry:
        companies.sort((a, b) => a.industry.compareTo(b.industry));
        break;
    }
    return [...companies];
  }

  List<Company> _companiesFavoriteFilter(
    List<Company> companies,
    bool favoritesOnly,
  ) {
    if (favoritesOnly) {
      return [...companies.where((company) => company.isFavorite == true)];
    } else {
      return [...companies];
    }
  }

  Future<List<Company>> _setFavoriteCompany(List<Company> companies) async {
    final favoriteIds = await _getFavoriteCompaniesIds();
    for (final company in companies) {
      if (favoriteIds.contains(company.id)) {
        company.isFavorite = true;
      }
    }
    return [...companies];
  }

  Future<List<Company>> _setMyCompany(List<Company> companies) async {
    final myCompanyIds = await _getMyCompaniesIds();
    for (final company in companies) {
      if (myCompanyIds.contains(company.id)) {
        company.isOwner = true;
      }
    }
    return [...companies];
  }

  Future<List<int>> _getFavoriteCompaniesIds() async {
    return await dataSourceStorage.getFavoriteCompanies();
  }

  Future<List<int>> _getMyCompaniesIds() async {
    return await dataSourceStorage.getMyCompanies();
  }
}
