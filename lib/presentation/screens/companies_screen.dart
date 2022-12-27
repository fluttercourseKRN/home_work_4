import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/model/enums/companies_sort_element.dart';
import '../providers/companies_provider.dart';
import '../widgets/app_menu.dart';
import '../widgets/app_spinkit.dart';
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
            const AppMenu<CompaniesSortElement>(),
            const Divider(),
            if (companies == null) const Expanded(child: AppSpinkit()),
            if (companies != null)
              Expanded(child: CompaniesList(companies: companies)),
          ],
        );
      },
    );
  }
}
