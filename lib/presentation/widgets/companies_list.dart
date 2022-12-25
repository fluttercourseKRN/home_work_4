import 'package:flutter/material.dart';

import '../../domain/entities/company.dart';
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
        return CompanyListTile(company: company);
      },
    );
  }
}
