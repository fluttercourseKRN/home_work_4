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
