import 'package:flutter/material.dart';
import 'package:jobsin/domain/model/company.dart';
import 'package:jobsin/domain/model/vacancy.dart';
import 'package:jobsin/presentation/providers/data_provider.dart';
import 'package:jobsin/presentation/widgets/app_spinkit.dart';
import 'package:jobsin/presentation/widgets/vacancies_list.dart';

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
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Text(company.name),
            Expanded(
              child: FutureBuilder<List<Vacancy>>(
                future:
                    DataProvider.watch(context).vacanciesForCompany(company.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final vacancies = snapshot.data!;
                    return VacanciesList(vacancies: vacancies);
                  }
                  return const AppSpinkit();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
