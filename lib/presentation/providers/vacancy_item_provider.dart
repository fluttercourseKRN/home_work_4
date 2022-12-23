import 'package:flutter/material.dart';
import 'package:jobsin/di.dart';
import 'package:provider/provider.dart';

import '../../domain/model/vacancy.dart';

class VacancyItemProvider extends ChangeNotifier {
  VacancyItemProvider({
    required this.vacancy,
  });
  factory VacancyItemProvider.read(BuildContext context) =>
      context.read<VacancyItemProvider>();

  factory VacancyItemProvider.watch(BuildContext context) =>
      context.watch<VacancyItemProvider>();

  final Vacancy vacancy;

  void toggleIsFavorite() {
    vacancy.isFavorite = !vacancy.isFavorite;
    final repository = DI.instance.repository;
    if (vacancy.isFavorite) {
      repository.saveVacancyToFavorite(vacancy.id);
    } else {
      repository.deleteVacancyFromFavorite(vacancy.id);
    }
    notifyListeners();
  }
}
