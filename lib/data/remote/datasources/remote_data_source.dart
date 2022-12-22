import 'package:dio/dio.dart';
import 'package:jobsin/data/repositories/data_repository.dart';

import '../model/company_api_response.dart';
import '../model/vacancy_api_response.dart';

class RemoteDataSource extends DataSource {
  static const _host = "3.75.134.87";
  static const _basePath = "/flutter/v1/";
  final _client = Dio();

  @override
  Future<CompanyApiResponse?> getCompanies() async {
    const path = "companies";
    final uri = Uri.http(_host, _basePath + path);
    final resp = await _client.getUri(uri);
    if (resp.statusCode == 200) {
      return CompanyApiResponse.fromJson(resp.data);
    } else {
      return null;
    }
  }

  @override
  Future<VacancyApiResponse?> getVacancies() async {
    const path = "jobs";
    final uri = Uri.http(_host, _basePath + path);
    final resp = await _client.getUri(uri);
    if (resp.statusCode == 200) {
      return VacancyApiResponse.fromJson(resp.data);
    } else {
      return null;
    }
  }

  @override
  Future<VacancyApiResponse?> getVacanciesForCompany(int companyId) async {
    final path = "companies/$companyId/jobs";
    final uri = Uri.http(_host, _basePath + path);
    final resp = await _client.getUri(uri);
    if (resp.statusCode == 200) {
      return VacancyApiResponse.fromJson(resp.data);
    } else {
      return null;
    }
  }

  @override
  void post() {
    const path = "companies";

    final params = {"": null};
    final uri = Uri.http(_host, _basePath + path, params);
    _client.postUri(uri);
  }
}
