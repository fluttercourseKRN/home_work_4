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
          title: Row(
            children: [
              Text(companyItem.element.name),
              if (companyItem.element.isOwner)
                Icon(
                  Icons.house_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
            ],
          ),
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
