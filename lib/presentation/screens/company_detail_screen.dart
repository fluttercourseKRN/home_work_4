import 'package:flutter/material.dart';
import 'package:jobsin/domain/entities/company.dart';
import 'package:jobsin/presentation/widgets/app_bar_main.dart';

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
          children: [
            Text(company.name),
            // Expanded(
            //   child: FutureBuilder<List<Vacancy>>(
            //     future: VacanciesProvider.watch(context)
            //         .vacanciesForCompany(company.id),
            //     builder: (context, snapshot) {
            //       if (snapshot.connectionState == ConnectionState.done) {
            //         final vacancies = snapshot.data!;
            //         return VacanciesList(vacancies: vacancies);
            //       }
            //       return const AppSpinkit();
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
