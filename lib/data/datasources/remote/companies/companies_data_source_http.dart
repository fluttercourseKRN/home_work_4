import 'package:http/http.dart' as http;
import 'package:jobsin/data/abstractions/companies_data_source_remote.dart';
import 'package:jobsin/data/datasources/remote/remote_helper.dart';
import 'package:jobsin/data/models/company_model.dart';
import 'package:jobsin/domain/entities/company.dart';

import 'model/company_api_response.dart';

class CompaniesDataSourceHttp extends CompaniesDataSourceRemote {
  CompaniesDataSourceHttp({required this.client});

  static const _host = "3.75.134.87";
  static const _basePath = "/flutter/v1/";
  final http.Client client;
  late final RemoteHelper _helper = RemoteHelper(
    client: client,
    basePath: _basePath,
    host: _host,
  );

  @override
  Future<List<CompanyModel>?> getCompanies() async {
    const path = "companies";
    final result = await _helper.get(path: path);
    if (result != null) {
      return CompanyApiResponseConverter.convert(result);
    }
    return null;
  }

  @override
  Future<int> addCompany(Company company) async {
    const path = "companies";
    final param = {
      'name': company.name,
      'description': company.description,
      'industry': company.industry,
    };
    final response = await _helper.post(path: path, param: param);

    return response?['id'];
  }

  @override
  Future<bool> deleteCompany(int companyId) async {
    final path = 'companies/$companyId';
    final result = await _helper.delete(path: path);
    print(result);
    return false;
  }
}
