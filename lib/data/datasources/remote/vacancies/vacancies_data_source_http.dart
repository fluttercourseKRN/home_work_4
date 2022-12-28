import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jobsin/domain/entities/vacancy.dart';

import '../../../abstractions/vacancies_data_source_remote.dart';
import '../../../models/vacancy_model.dart';
import 'model/vacancy_api_response.dart';

class VacanciesDataSourceHTTP extends VacanciesDataSourceRemote {
  VacanciesDataSourceHTTP({required this.client});

  static const _host = "3.75.134.87";
  static const _basePath = "/flutter/v1/";
  final http.Client client;

  Future<List<VacancyModel>?> _get({required String path}) async {
    final uri = Uri.http(_host, _basePath + path);
    final resp = await client.get(uri);
    if (resp.statusCode == 200) {
      return VacancyApiResponseConverter.convert(jsonDecode(resp.body));
    } else {
      return null;
    }
  }

  @override
  Future<List<VacancyModel>?> getVacanciesList({
    List<int>? fetchOnlyCompaniesId,
  }) async {
    if (fetchOnlyCompaniesId == null) {
      const path = "jobs";
      return _get(path: path);
    } else {
      final companiesList = await Future.wait(fetchOnlyCompaniesId
          .map((companyId) => getVacanciesForCompany(companyId)));
      return [
        for (final companyVacancies in companiesList) ...?companyVacancies
      ];
    }
  }

  @override
  Future<List<VacancyModel>?> getVacanciesForCompany(int companyId) async {
    final path = "companies/$companyId/jobs";
    return _get(path: path);
  }

  Future<bool?> _post({required String path}) async {
    final uri = Uri.http(_host, _basePath + path);
    final resp = await client.post(uri);
    if (resp.statusCode == 200) {
      return true;
    } else {
      return null;
    }
  }

  @override
  Future<void> addVacancy(Vacancy vacancy) {
    // TODO: implement addVacancy
    throw UnimplementedError();
  }

  @override
  Future<void> deleteVacancy(int vacancyId) {
    // TODO: implement deleteVacancy
    throw UnimplementedError();
  }
}
