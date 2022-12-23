class Vacancy {
  int id;
  int companyId;
  String title;
  String description;
  String city;
  bool isFavorite;

  Vacancy({
    required this.id,
    required this.companyId,
    required this.title,
    required this.description,
    required this.city,
    this.isFavorite = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Vacancy &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          companyId == other.companyId &&
          title == other.title &&
          description == other.description &&
          city == other.city &&
          isFavorite == other.isFavorite);

  @override
  int get hashCode =>
      id.hashCode ^
      companyId.hashCode ^
      title.hashCode ^
      description.hashCode ^
      city.hashCode ^
      isFavorite.hashCode;

  @override
  String toString() {
    return 'Vacancy{ id: $id, companyId: $companyId, title: $title, description: $description, city: $city, isFavorite $isFavorite}';
  }

  Vacancy copyWith({
    int? id,
    int? companyId,
    String? title,
    String? description,
    String? city,
    bool? isFavorite,
  }) {
    return Vacancy(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      title: title ?? this.title,
      description: description ?? this.description,
      city: city ?? this.city,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

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

  factory Vacancy.fromMap(Map<String, dynamic> map) {
    return Vacancy(
        id: map['id'] as int,
        companyId: map['companyId'] as int,
        title: map['title'] as String,
        description: map['description'] as String,
        city: map['city'] as String,
        isFavorite: map['isFavorite'] as bool);
  }
}
