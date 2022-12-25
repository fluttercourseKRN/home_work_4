import 'package:dio/dio.dart';

import '../../../models/vacancies_data_source_remote.dart';
import '../../../models/vacancy_model.dart';
import 'model/vacancy_api_response.dart';

class VacanciesDataSourceHTTP extends VacanciesDataSourceRemote {
  static const _host = "3.75.134.87";
  static const _basePath = "/flutter/v1/";
  final _client = Dio();

  @override
  Future<List<VacancyModel>?> getVacanciesList() async {
    const path = "jobs";
    final uri = Uri.http(_host, _basePath + path);
    final resp = await _client.getUri(uri);
    if (resp.statusCode == 200) {
      return VacancyApiResponseConverter.convert(resp.data);
    } else {
      return null;
    }
  }

  @override
  Future<List<VacancyModel>?> getVacancies() async {
    const path = "jobs";
    final uri = Uri.http(_host, _basePath + path);
    final resp = await _client.getUri(uri);
    if (resp.statusCode == 200) {
      return VacancyApiResponseConverter.convert(resp.data);
    } else {
      return null;
    }
  }

  @override
  Future<List<VacancyModel>?> getVacanciesForCompany(int companyId) async {
    final path = "companies/$companyId/jobs";
    final uri = Uri.http(_host, _basePath + path);
    final resp = await _client.getUri(uri);
    if (resp.statusCode == 200) {
      return VacancyApiResponseConverter.convert(resp.data);
    } else {
      return null;
    }
  }
}
