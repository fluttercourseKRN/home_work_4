import '../../domain/entities/vacancy.dart';
import 'favorite_toggle.dart';

class VacancyPresentation extends Vacancy implements FavoriteToggled {
  VacancyPresentation({
    required super.id,
    required super.companyId,
    required super.title,
    required super.description,
    required super.city,
    super.isFavorite,
  });

  VacancyPresentation.fromVacancy(Vacancy vacancy)
      : this(
          title: vacancy.title,
          description: vacancy.description,
          city: vacancy.city,
          companyId: vacancy.companyId,
          id: vacancy.id,
          isFavorite: vacancy.isFavorite,
        );
}
