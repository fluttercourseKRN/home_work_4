import 'package:flutter/material.dart';
import 'package:jobsin/core/use_case/use_case.dart';

import '../../../domain/usecases/toggle_vacancy_favorite_status.dart';
import '../../models/favorite_toggle.dart';

abstract class FavoriteToggleProvider<T extends FavoriteToggled,
    UseCaseClass extends UseCase> extends ChangeNotifier {
  final T element;

  final BuildContext context;
  FavoriteToggleProvider({
    required this.context,
    required this.element,
    required this.toggleUseCase,
  });

  final UseCaseClass toggleUseCase;

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: SizedBox(height: 50, child: Text(msg))));
  }

  Future<void> toggleFavorite() async {
    final resOrFailure = await toggleUseCase(VacancyFavoriteParams(
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
