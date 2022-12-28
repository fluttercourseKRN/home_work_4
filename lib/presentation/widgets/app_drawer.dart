import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jobsin/domain/entities/vacancy.dart';
import 'package:jobsin/presentation/providers/companies_provider.dart';
import 'package:jobsin/presentation/screens/company_edit_screen.dart';
import 'package:jobsin/presentation/screens/vacancy_edit_screen.dart';
import 'package:jobsin/presentation/widgets/app_bar_main.dart';
import 'package:jobsin/presentation/widgets/app_spinkit.dart';
import 'package:jobsin/presentation/widgets/delete_icon_button.dart';
import 'package:jobsin/presentation/widgets/edit_icon_button.dart';

import '../providers/vacancies_provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const AppBarMain(automaticallyImplyLeading: false),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.building,
              size: 32,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: const Text(
              'Add Company',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                // color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            onTap: () =>
                Navigator.of(context).pushNamed(CompanyEditScreen.route),
          ),
          const MyCompaniesExpansionTile(),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.fileSignature,
              size: 32,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: const Text(
              'Add Vacancy',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                // color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            onTap: () =>
                Navigator.of(context).pushNamed(VacancyEditScreen.route),
          ),
          const MyVacanciesExpansionTile(),
        ],
      ),
    );
  }
}

class MyVacanciesExpansionTile extends StatelessWidget {
  const MyVacanciesExpansionTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text('My vacancies'),
      children: [
        FutureBuilder<List<Vacancy>>(
          future: VacanciesProvider.watch(context).getMyVacancies(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final vacancies = snapshot.data!;
              return ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: vacancies.length,
                itemBuilder: (context, index) {
                  final vacancy = vacancies[index];
                  return ListTile(
                    leading: Icon(
                      Icons.house_outlined,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        EditIconButton(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              VacancyEditScreen.route,
                              arguments: vacancy,
                            );
                          },
                        ),
                        DeleteIconButton(
                          onTap: () => VacanciesProvider.read(context)
                              .deleteVacancy(vacancy.id),
                        ),
                      ],
                    ),
                    title: Text(vacancy.title),
                    subtitle: Text(vacancy.city),
                  );
                },
              );
            } else {
              return const AppSpinkit();
            }
          },
        )
      ],
    );
  }
}

class MyCompaniesExpansionTile extends StatelessWidget {
  const MyCompaniesExpansionTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text('My companies'),
      children: [
        FutureBuilder(
          future: CompaniesProvider.watch(context).getMyCompanies(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final companies = snapshot.data!;
              return ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: companies.length,
                itemBuilder: (context, index) {
                  final company = companies[index];
                  return ListTile(
                    leading: Icon(
                      Icons.house_outlined,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        EditIconButton(
                          onTap: () => Navigator.of(context).pushNamed(
                            CompanyEditScreen.route,
                            arguments: company,
                          ),
                        ),
                        DeleteIconButton(
                          onTap: () {
                            CompaniesProvider.read(context)
                                .deleteCompany(company.id);
                          },
                        ),
                      ],
                    ),
                    title: Text(company.name),
                    subtitle: Text(company.industry),
                  );
                },
              );
            } else {
              return const AppSpinkit();
            }
          },
        )
      ],
    );
  }
}
