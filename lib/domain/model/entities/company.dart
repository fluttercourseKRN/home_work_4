class Company {
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
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Company &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          industry == other.industry &&
          isFavorite == other.isFavorite);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      industry.hashCode ^
      isFavorite.hashCode;

  @override
  String toString() {
    return 'Company{ id: $id, name: $name, description: $description, industry: $industry, isFavorite: $isFavorite}';
  }

  Company copyWith(
      {int? id,
      String? name,
      String? description,
      String? industry,
      bool? isFavorite}) {
    return Company(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      industry: industry ?? this.industry,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'industry': industry,
      'isFavorite': isFavorite,
    };
  }

  factory Company.fromMap(Map<String, dynamic> map) {
    return Company(
        id: map['id'] as int,
        name: map['name'] as String,
        description: map['description'] as String,
        industry: map['industry'] as String,
        isFavorite: map['isFavorite'] as bool);
  }
}
