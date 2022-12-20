class Company {
  String id;
  String name;
  String description;
  String industry;

  Company({
    required this.id,
    required this.name,
    required this.description,
    required this.industry,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Company &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          industry == other.industry);

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ description.hashCode ^ industry.hashCode;

  @override
  String toString() {
    return 'Company{ id: $id, name: $name, description: $description, industry: $industry}';
  }

  Company copyWith({
    String? id,
    String? name,
    String? description,
    String? industry,
  }) {
    return Company(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      industry: industry ?? this.industry,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'industry': industry,
    };
  }

  factory Company.fromMap(Map<String, dynamic> map) {
    return Company(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      industry: map['industry'] as String,
    );
  }
}
