import 'package:dio/dio.dart';
import 'package:jobsin/data/models/companies_data_source_remote.dart';
import 'package:jobsin/data/models/company_model.dart';

import 'model/company_api_response.dart';

class CompaniesDataSourceHttp extends CompaniesDataSourceRemote {
  CompaniesDataSourceHttp({required this.client});
  static const _host = "3.75.134.87";
  static const _basePath = "/flutter/v1/";
  final Dio client;

  Future<List<CompanyModel>?> _get({required String path}) async {
    final uri = Uri.http(_host, _basePath + path);
    final resp = await client.getUri(uri);
    if (resp.statusCode == 200) {
      return CompanyApiResponseConverter.convert(resp.data);
    } else {
      return null;
    }
  }

  @override
  Future<List<CompanyModel>?> getCompanies() async {
    const path = "companies";
    return _get(path: path);
  }
}
