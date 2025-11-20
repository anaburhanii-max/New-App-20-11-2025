class Silsilah {
  final String id;
  final String name;
  final String description;
  final String? adminId;
  final List<String> members;

  Silsilah({
    required this.id,
    required this.name,
    this.description = '',
    this.adminId,
    this.members = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'adminId': adminId,
      'members': members,
    };
  }

  factory Silsilah.fromMap(Map<String, dynamic> map, String id) {
    return Silsilah(
      id: id,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      adminId: map['adminId'],
      members: List<String>.from(map['members'] ?? []),
    );
  }

  Silsilah copyWith({
    String? id,
    String? name,
    String? description,
    String? adminId,
    List<String>? members,
  }) {
    return Silsilah(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      adminId: adminId ?? this.adminId,
      members: members ?? this.members,
    );
  }
}
