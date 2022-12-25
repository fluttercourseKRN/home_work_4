import 'package:dio/dio.dart';
import 'package:jobsin/data/models/companies_data_source_remote.dart';
import 'package:jobsin/data/models/company_model.dart';

import 'model/company_api_response.dart';

class CompaniesDataSourceHttp extends CompaniesDataSourceRemote {
  static const _host = "3.75.134.87";
  static const _basePath = "/flutter/v1/";
  final _client = Dio();

  @override
  Future<List<CompanyModel>?> getCompanies() async {
    const path = "companies";
    final uri = Uri.http(_host, _basePath + path);
    final resp = await _client.getUri(uri);
    if (resp.statusCode == 200) {
      return CompanyApiResponseConverter.convert(resp.data);
    } else {
      return null;
    }
  }
}
