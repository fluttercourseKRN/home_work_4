import '../../../../models/vacancy_model.dart';

class VacancyApiResponseConverter {
  static List<VacancyModel> convert(Map<String, dynamic> data) {
    final List<VacancyModel> vacancies = [];

    for (final elem in List.from(data["result"])) {
      try {
        final vacancyModel = VacancyModel.fromMap(elem);
        vacancies.add(vacancyModel);
      } catch (e) {
        continue;
      }
    }
    return vacancies;
  }
}
