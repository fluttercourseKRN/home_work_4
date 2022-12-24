import 'package:equatable/equatable.dart';

class Company with EquatableMixin {
  int id;
  String name;
  String description;
  String industry;
  bool isFavorite;

  Company({
    required this.id,
    required this.name,
    required this.description,
    required this.industry,
    this.isFavorite = false,
  });

  @override
  List<Object?> get props => [id, name, description, industry, isFavorite];
}
