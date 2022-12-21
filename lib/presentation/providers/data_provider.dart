import 'package:flutter/material.dart';
import 'package:jobsin/domain/model/vacancy.dart';
import 'package:jobsin/domain/repositories/repository.dart';
import 'package:provider/provider.dart';

import '../../domain/model/company.dart';

class DataProvider with ChangeNotifier {
  DataProvider({required this.repository});

  factory DataProvider.read(BuildContext context) =>
      context.read<DataProvider>();

  factory DataProvider.watch(BuildContext context) =>
      context.watch<DataProvider>();

  Repository repository;

  Future<List<Company>> get companies async {
    final companies = await repository.getCompanies();
    return [...companies];
  }

  Future<List<Vacancy>> get vacancies async {
    final vacancies = await repository.getVacancies();

    return [...vacancies];
  }

  Future<List<Vacancy>> vacanciesForCompany(int companyId) async {
    final vacancies = await repository.getVacanciesForCompany(companyId);
    return [...vacancies];
  }
}
