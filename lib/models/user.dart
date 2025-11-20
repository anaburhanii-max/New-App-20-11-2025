
enum UserRole {
  superAdmin,
  admin,
  murshid,
  mureed,
}

class AppUser {
  final String id;
  final String name;
  final String email;
  final String phone;
  final UserRole role;
  final bool isApproved;
  final String? murshidId;
  final String? silsilahId;

  AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    this.isApproved = false,
    this.murshidId,
    this.silsilahId,
  });

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      role: UserRole.values.firstWhere((e) => e.toString() == 'UserRole.${map['role']}'),
      isApproved: map['isApproved'] ?? false,
      murshidId: map['murshidId'],
      silsilahId: map['silsilahId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role.toString().split('.').last,
      'isApproved': isApproved,
      'murshidId': murshidId,
      'silsilahId': silsilahId,
    };
  }

  AppUser copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    UserRole? role,
    bool? isApproved,
    String? murshidId,
    String? silsilahId,
  }) {
    return AppUser(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      isApproved: isApproved ?? this.isApproved,
      murshidId: murshidId ?? this.murshidId,
      silsilahId: silsilahId ?? this.silsilahId,
    );
  }
}
