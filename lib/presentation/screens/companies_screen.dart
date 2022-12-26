import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/companies_provider.dart';
import '../widgets/app_menu.dart';
import '../widgets/companies_list.dart';

class CompaniesScreen extends StatelessWidget {
  const CompaniesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CompaniesProvider>(
      builder: (context, companiesProvider, child) {
        final companies = companiesProvider.companies;

        return Column(
          children: [
            AppMenu(menuController: companiesProvider),
            const Divider(),
            Expanded(child: CompaniesList(companies: companies)),
          ],
        );
      },
    );
  }
}
