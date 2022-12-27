import 'package:flutter/material.dart';

import '../../domain/entities/vacancy.dart';
import '../../domain/usecases/toggle_vacancy_favorite_status.dart';

class VacancyItemProvider extends ChangeNotifier {
  VacancyItemProvider({
    required this.context,
    required this.element,
    required this.useCase,
  });

  final BuildContext context;
  final Vacancy element;
  final ToggleVacancyFavoriteStatus useCase;

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: SizedBox(height: 50, child: Text(msg))));
  }

  Future<void> toggleFavorite() async {
    final resOrFailure = await useCase(VacancyFavoriteParams(
      vacancyId: element.id,
      value: !element.isFavorite,
    ));
    resOrFailure.fold(
      (error) => _showError("Add to favorite error"),
      (value) => element.isFavorite = value,
    );
    notifyListeners();
  }
}
