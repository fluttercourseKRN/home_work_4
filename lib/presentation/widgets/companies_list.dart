import 'package:flutter/material.dart';
import 'package:jobsin/domain/entities/company.dart';
import 'package:jobsin/presentation/providers/company_item_provider.dart';
import 'package:provider/provider.dart';

import 'company_list_tile.dart';

class CompaniesList extends StatelessWidget {
  const CompaniesList({
    Key? key,
    required this.companies,
  }) : super(key: key);

  final List<Company> companies;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: companies.length,
      itemBuilder: (context, index) {
        final company = companies[index];
        return ChangeNotifierProvider(
          create: (context) => CompanyItemProvider(company: company),
          child: const CompanyListTile(),
        );
      },
    );
  }
}
