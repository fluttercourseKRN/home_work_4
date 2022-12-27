import 'package:equatable/equatable.dart';

class Vacancy with EquatableMixin {
  int id;
  int companyId;
  String title;
  String description;
  String city;
  bool isFavorite;
  bool isOwner;

  Vacancy({
    required this.id,
    required this.companyId,
    required this.title,
    required this.description,
    required this.city,
    required this.isFavorite,
    required this.isOwner,
  });

  @override
  List<Object?> get props => [
        id,
        companyId,
        title,
        description,
        city,
        isFavorite,
        isOwner,
      ];
}
