import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/company.dart';
import '../../injector_container.dart';
import '../providers/company_item_provider.dart';
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
          key: ValueKey(company.id),
          create: (context) => CompanyItemProvider(
            context: context,
            element: company,
            useCase: sl(),
          ),
          child: const CompanyListTile(),
        );
      },
    );
  }
}
