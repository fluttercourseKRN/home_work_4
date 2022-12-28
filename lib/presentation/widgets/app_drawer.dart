import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jobsin/presentation/providers/companies_provider.dart';
import 'package:jobsin/presentation/screens/company_edit_screen.dart';
import 'package:jobsin/presentation/screens/vacancy_edit_screen.dart';
import 'package:jobsin/presentation/widgets/app_bar_main.dart';
import 'package:jobsin/presentation/widgets/app_spinkit.dart';

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
          ExpansionTile(
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
                          trailing: IconButton(
                            onPressed: () => CompaniesProvider.read(context)
                                .deleteCompany(company.id),
                            icon: const Icon(Icons.delete_outline),
                            color: Theme.of(context).colorScheme.error,
                          ),
                          title: Text(company.name),
                          subtitle: Text(company.industry),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              CompanyEditScreen.route,
                              arguments: company,
                            );
                          },
                        );
                      },
                    );
                  } else {
                    return const AppSpinkit();
                  }
                },
              )
            ],
          ),
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
        ],
      ),
    );
  }
}
