import '../../../../models/vacancy_model.dart';

class VacancyApiResponseConverter {
  static List<VacancyModel> convert(Map<String, dynamic> data) {
    final List<VacancyModel> vacancies = [];

    for (final elem in List.from(data["result"])) {
      try {
        final vacancyModel = VacancyModel(
          id: elem['id'],
          companyId: elem['companyId'],
          title: elem['title'],
          city: elem['city'],
          description: elem['description'],
        );
        vacancies.add(vacancyModel);
      } catch (e) {
        continue;
      }
    }
    return vacancies;
  }
}
