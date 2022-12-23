import 'package:flutter/material.dart';
import 'package:jobsin/presentation/widgets/companies_list.dart';

import '../../domain/model/entities/company.dart';
import '../../domain/model/sort_element.dart';
import '../providers/data_provider.dart';
import '../widgets/app_menu.dart';
import '../widgets/app_spinkit.dart';

class CompaniesScreen extends StatelessWidget {
  const CompaniesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppMenu(
          currentSortField: DataProvider.watch(context).companiesSortField,
          onSortFieldChange: (SortElement value) =>
              DataProvider.read(context).setCompaniesSortField(value),
          isOn: DataProvider.watch(context).companiesShowFavoriteOnly,
          switchChange: (bool value) =>
              DataProvider.read(context).toggleVacanciesShowFavoriteOnly(),
        ),
        const Divider(),
        Expanded(
          child: FutureBuilder<List<Company>>(
            future: DataProvider.watch(context).companies,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final companies = snapshot.data!;
                return CompaniesList(companies: companies);
              }
              return const AppSpinkit();
            },
          ),
        ),
      ],
    );
    ;
  }
}
