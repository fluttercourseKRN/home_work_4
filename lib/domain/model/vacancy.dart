class Vacancy {
  String id;
  String companyId;
  String title;
  String description;
  String city;

  Vacancy({
    required this.id,
    required this.companyId,
    required this.title,
    required this.description,
    required this.city,
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
          city == other.city);

  @override
  int get hashCode =>
      id.hashCode ^
      companyId.hashCode ^
      title.hashCode ^
      description.hashCode ^
      city.hashCode;

  @override
  String toString() {
    return 'Vacancy{ id: $id, companyId: $companyId, title: $title, description: $description, city: $city}';
  }

  Vacancy copyWith({
    String? id,
    String? companyId,
    String? title,
    String? description,
    String? city,
  }) {
    return Vacancy(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      title: title ?? this.title,
      description: description ?? this.description,
      city: city ?? this.city,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'companyId': companyId,
      'title': title,
      'description': description,
      'city': city,
    };
  }

  factory Vacancy.fromMap(Map<String, dynamic> map) {
    return Vacancy(
      id: map['id'] as String,
      companyId: map['companyId'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      city: map['city'] as String,
    );
  }
}
