import '../../domain/usecases/toggle_vacancy_favorite_status.dart';
import '../models/vacancy_presentation.dart';
import 'abstract/favarite_togle_provider.dart';

class VacancyItemProvider extends FavoriteToggleProvider<VacancyPresentation,
    ToggleVacancyFavoriteStatus> {
  VacancyItemProvider({
    required super.context,
    required super.element,
    required super.toggleUseCase,
  });
}

// import 'package:flutter/material.dart';
//
// import '../../domain/entities/vacancy.dart';
// import '../../domain/usecases/toggle_vacancy_favorite_status.dart';
//
// class VacancyItemProvider extends ChangeNotifier {
//   final Vacancy vacancy;
//
//   final BuildContext context;
//   VacancyItemProvider({
//     required this.context,
//     required this.vacancy,
//     required this.toggleUseCase,
//   });
//
//   final ToggleVacancyFavoriteStatus toggleUseCase;
//
//   void _showError(String msg) {
//     ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: SizedBox(height: 50, child: Text(msg))));
//   }
//
//   Future<void> toggleFavorite() async {
//     final resOrFailure = await toggleUseCase(VacancyFavoriteParams(
//       vacancyId: vacancy.id,
//       value: !vacancy.isFavorite,
//     ));
//     resOrFailure.fold(
//           (error) => _showError("Add to favorite error"),
//           (value) => vacancy.isFavorite = value,
//     );
//     notifyListeners();
//   }
// }
