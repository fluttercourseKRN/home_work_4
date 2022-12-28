import 'package:flutter/material.dart';
import 'package:jobsin/presentation/providers/companies_provider.dart';
import 'package:jobsin/presentation/widgets/delete_icon_button.dart';
import 'package:provider/provider.dart';

import '../providers/company_item_provider.dart';
import '../screens/company_detail_screen.dart';
import 'favorite_icon_button.dart';

class CompanyListTile extends StatelessWidget {
  const CompanyListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CompanyItemProvider>(
      builder: (context, companyItem, child) {
        final favoriteButton = FavoriteIconButton(
          value: companyItem.element.isFavorite,
          onTap: () => companyItem.toggleFavorite(),
        );
        final deleteButton = DeleteIconButton(
          onTap: () => CompaniesProvider.read(context)
              .deleteCompany(companyItem.element.id),
        );
        return ListTile(
          title: Row(
            children: [
              if (companyItem.element.isOwner)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.house_outlined,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              Flexible(
                child: Text(
                  companyItem.element.name,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          subtitle: Text(companyItem.element.industry),
          trailing: companyItem.element.isOwner ? deleteButton : favoriteButton,
          onTap: () => Navigator.of(context).pushNamed(
            CompanyDetailScreen.route,
            arguments: companyItem.element,
          ),
        );
      },
    );
  }
}
