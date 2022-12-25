import 'package:flutter/material.dart';
import 'package:jobsin/domain/usecases/toggle_company_favorite_status.dart';

import '../../domain/entities/company.dart';

class CompanyItemProvider extends ChangeNotifier {
  final Company company;

  final BuildContext context;
  CompanyItemProvider({
    required this.context,
    required this.company,
    required this.toggleUseCase,
  });

  final ToggleCompanyFavoriteStatus toggleUseCase;

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: SizedBox(height: 50, child: Text(msg))));
  }

  Future<void> toggleFavorite() async {
    final resOrFailure = await toggleUseCase(CompanyFavoriteParams(
      companyId: company.id,
      value: !company.isFavorite,
    ));
    resOrFailure.fold(
      (error) => _showError("Add to favorite error"),
      (value) => company.isFavorite = value,
    );
    notifyListeners();
  }
}
