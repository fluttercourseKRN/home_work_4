import 'package:flutter/material.dart';

import '../../domain/entities/company.dart';
import '../../domain/usecases/toggle_company_favorite_status.dart';

class CompanyItemProvider extends ChangeNotifier {
  CompanyItemProvider({
    required this.context,
    required this.element,
    required this.useCase,
  });

  final BuildContext context;
  final Company element;
  final ToggleCompanyFavoriteStatus useCase;

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: SizedBox(height: 50, child: Text(msg))));
  }

  Future<void> toggleFavorite() async {
    final resOrFailure = await useCase(CompanyFavoriteParams(
      companyId: element.id,
      value: !element.isFavorite,
    ));
    resOrFailure.fold(
      (error) => _showError("Add to favorite error"),
      (value) => element.isFavorite = value,
    );
    notifyListeners();
  }
}
