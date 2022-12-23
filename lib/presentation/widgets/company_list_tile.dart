import 'package:flutter/material.dart';
import 'package:jobsin/presentation/providers/company_item_provider.dart';
import 'package:jobsin/presentation/widgets/favorite_button.dart';

import '../screens/company_detail_screen.dart';

class CompanyListTile extends StatelessWidget {
  const CompanyListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final company = CompanyItemProvider.watch(context).company;
    return ListTile(
      title: Text(company.name),
      subtitle: Text(company.industry),
      trailing: FavoriteButton(
        value: company.isFavorite,
        onTap: () => CompanyItemProvider.read(context).toggleIsFavorite(),
      ),
      onTap: () => Navigator.of(context).pushNamed(
        CompanyDetailScreen.route,
        arguments: company,
      ),
    );
  }
}
