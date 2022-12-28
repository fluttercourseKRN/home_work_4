import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/company.dart';
import '../../injector_container.dart';
import '../providers/vacancies_provider.dart';
import '../widgets/app_bar_main.dart';
import '../widgets/info_card.dart';
import '../widgets/label_value.dart';
import 'vacancies_screen.dart';

class CompanyDetailScreen extends StatelessWidget {
  const CompanyDetailScreen({
    Key? key,
    required this.company,
  }) : super(key: key);

  static const route = 'company_detail_screen';
  final Company company;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarMain(),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InfoCard(
                items: [
                  LabelValue(
                    label: 'Company name: ',
                    text: company.name,
                  ),
                  LabelValue(
                    label: 'Industry: ',
                    text: company.industry,
                  ),
                  LabelValue(
                    label: 'Description: ',
                    text: company.description,
                  ),
                ],
              ),
            ),
            ExpansionTile(
              title: const Text("Company vacancies:"),
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                  child: ChangeNotifierProvider<VacanciesProvider>(
                    create: (context) => VacanciesProvider(
                      context: context,
                      useCaseGetVacanciesList: sl(),
                      useCaseAddVacancy: sl(),
                      useCaseDeleteVacancy: sl(),
                      useCaseGetMyVacancies: sl(),
                      useCaseGetMyCompanies: sl(),
                      fetchOnlyCompaniesId: [company.id],
                    ),
                    child: const VacanciesScreen(showMenu: false),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
