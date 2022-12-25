import 'package:flutter/material.dart';

import '../../domain/entities/company.dart';
import '../../domain/usecases/toggle_vacancy_favorite_status.dart';

class CompanyItemProvider extends ChangeNotifier {
  final Company company;

  final BuildContext context;
  CompanyItemProvider({
    required this.context,
    required this.company,
    required this.toggleUseCase,
  });

  final ToggleVacancyFavoriteStatus toggleUseCase;

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: SizedBox(height: 50, child: Text(msg))));
  }

  Future<void> toggleFavorite() async {
    final resOrFailure = await toggleUseCase(VacancyFavoriteParams(
      vacancyId: company.id,
      value: !company.isFavorite,
    ));
    resOrFailure.fold(
      (error) => _showError("Add to favorite error"),
      (value) => company.isFavorite = value,
    );
    notifyListeners();
  }
}
