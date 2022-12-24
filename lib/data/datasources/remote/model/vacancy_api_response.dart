import '../../../models/vacancy_model.dart';

class VacancyApiResponse {
  final List<VacancyModel> vacancies = [];
  VacancyApiResponse.fromJson(Map<String, dynamic> data) {
    for (final elem in List.from(data["result"])) {
      vacancies.add(
        VacancyModel(
          id: elem['id'],
          companyId: elem['companyId'],
          title: elem['title'],
          city: elem['city'],
          description: elem['description'],
        ),
      );
    }
  }
}
