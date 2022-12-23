import 'package:flutter/material.dart';
import 'package:jobsin/domain/model/entities/company.dart';

import '../screens/company_detail_screen.dart';

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
        return ListTile(
          title: Text(company.name),
          onTap: () => Navigator.of(context).pushNamed(
            CompanyDetailScreen.route,
            arguments: company,
          ),
        );
      },
    );
  }
}
