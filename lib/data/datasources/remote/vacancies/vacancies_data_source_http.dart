import 'package:http/http.dart' as http;
import 'package:jobsin/domain/entities/vacancy.dart';

import '../../../abstractions/vacancies_data_source_remote.dart';
import '../../../models/vacancy_model.dart';
import '../remote_helper.dart';
import 'model/vacancy_api_response.dart';

class VacanciesDataSourceHTTP extends VacanciesDataSourceRemote {
  VacanciesDataSourceHTTP({required this.client});

  static const _host = "3.75.134.87";
  static const _basePath = "/flutter/v1/";
  final http.Client client;
  late final RemoteHelper _helper = RemoteHelper(
    client: client,
    basePath: _basePath,
    host: _host,
  );

  @override
  Future<List<VacancyModel>?> getVacancies({
    List<int>? fetchOnlyCompaniesId,
  }) async {
    if (fetchOnlyCompaniesId == null) {
      const path = "jobs";
      final result = await _helper.get(path: path);
      if (result != null) {
        return VacancyApiResponseConverter.convert(result);
      } else {
        return null;
      }
    } else {
      final companiesList = await Future.wait(fetchOnlyCompaniesId
          .map((companyId) => getVacanciesForCompany(companyId)));
      return [
        for (final companyVacancies in companiesList) ...?companyVacancies
      ];
    }
  }

  Future<List<VacancyModel>?> getVacanciesForCompany(int companyId) async {
    final path = "companies/$companyId/jobs";
    final result = await _helper.get(path: path);
    if (result != null) {
      return VacancyApiResponseConverter.convert(result);
    } else {
      return null;
    }
  }

  @override
  Future<int> addVacancy(Vacancy vacancy) async {
    const path = "jobs";
    final param = {
      'title': vacancy.title,
      'description': vacancy.description,
      'city': vacancy.city,
      'companyId': vacancy.companyId,
    };
    final response = await _helper.post(path: path, param: param);
    return response?['id'];
  }

  @override
  Future<int> deleteVacancy(int vacancyId) async {
    final path = "jobs/$vacancyId";
    final response = await _helper.delete(path: path);
    return response?['id'];
  }
}
