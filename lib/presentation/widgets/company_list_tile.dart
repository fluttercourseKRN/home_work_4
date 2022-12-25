import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/company_item_provider.dart';
import '../screens/company_detail_screen.dart';
import 'favorite_button.dart';

class CompanyListTile extends StatelessWidget {
  const CompanyListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CompanyItemProvider>(
      builder: (context, companyItem, child) {
        return ListTile(
          title: Text(companyItem.element.name),
          subtitle: Text(companyItem.element.industry),
          trailing: FavoriteButton(
            value: companyItem.element.isFavorite,
            onTap: () => companyItem.toggleFavorite(),
          ),
          onTap: () => Navigator.of(context).pushNamed(
            CompanyDetailScreen.route,
            arguments: companyItem.element,
          ),
        );
      },
    );
  }
}
