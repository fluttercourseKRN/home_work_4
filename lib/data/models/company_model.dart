import 'package:jobsin/domain/entities/company.dart';

class CompanyModel extends Company {
  CompanyModel({
    required super.id,
    required super.name,
    required super.description,
    required super.industry,
    super.isFavorite,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'industry': industry,
      'isFavorite': isFavorite,
    };
  }

  factory CompanyModel.fromMap(Map<String, dynamic> map) {
    return CompanyModel(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      industry: map['industry'] as String,
      isFavorite: map['isFavorite'] as bool,
    );
  }
}
