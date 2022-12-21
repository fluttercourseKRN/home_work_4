import 'package:jobsin/domain/model/vacancy.dart';

class VacancyApiResponse {
  final List<Vacancy> vacancies = [];
  VacancyApiResponse.fromJson(Map<String, dynamic> data) {
    for (final elem in List.from(data["result"])) {
      vacancies.add(
        Vacancy(
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
