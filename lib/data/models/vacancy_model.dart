import 'package:jobsin/domain/entities/vacancy.dart';

class VacancyModel extends Vacancy {
  VacancyModel({
    required super.id,
    required super.companyId,
    required super.title,
    required super.description,
    required super.city,
    super.isFavorite,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'companyId': companyId,
      'title': title,
      'description': description,
      'city': city,
      'isFavorite': isFavorite,
    };
  }

  factory VacancyModel.fromMap(Map<String, dynamic> map) {
    return VacancyModel(
      id: map['id'] as int,
      companyId: map['companyId'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      city: map['city'] as String,
      isFavorite: map['isFavorite'] as bool,
    );
  }
}
