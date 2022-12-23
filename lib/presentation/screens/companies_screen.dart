import 'package:flutter/material.dart';
import 'package:jobsin/presentation/widgets/companies_list.dart';

import '../../domain/model/entities/company.dart';
import '../providers/data_provider.dart';
import '../widgets/app_spinkit.dart';

class CompaniesScreen extends StatelessWidget {
  const CompaniesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Company>>(
      future: DataProvider.watch(context).companies,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final companies = snapshot.data!;
          return CompaniesList(companies: companies);
        }
        return const AppSpinkit();
      },
    );
    ;
  }
}
