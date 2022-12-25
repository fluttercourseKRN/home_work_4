import 'package:flutter/material.dart';

import '../../domain/entities/company.dart';
import '../screens/company_detail_screen.dart';
import 'favorite_button.dart';

class CompanyListTile extends StatelessWidget {
  const CompanyListTile({
    Key? key,
    required this.company,
  }) : super(key: key);

  final Company company;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(company.name),
      subtitle: Text(company.industry),
      trailing: FavoriteButton(
        value: company.isFavorite,
        onTap: () {},
      ),
      onTap: () => Navigator.of(context).pushNamed(
        CompanyDetailScreen.route,
        arguments: company,
      ),
    );
  }
}
