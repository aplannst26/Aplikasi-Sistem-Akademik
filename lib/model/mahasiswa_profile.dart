class MahasiswaProfile {
  final int id;
  final int userId;
  final String nim;
  final String fakultas;
  final String programStudi;
  final int semester;
  final String tahunMasuk;
  final String? status;
  final int? dosenWaliId;
  final String createdAt;
  final String updatedAt;
  final User user;

  MahasiswaProfile({
    required this.id,
    required this.userId,
    required this.nim,
    required this.fakultas,
    required this.programStudi,
    required this.semester,
    required this.tahunMasuk,
    required this.status,
    required this.dosenWaliId,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory MahasiswaProfile.fromJson(Map<String, dynamic> json) {
    return MahasiswaProfile(
      id: json['id'],
      userId: json['user_id'],
      nim: json['nim'],
      fakultas: json['fakultas'],
      programStudi: json['program_studi'],
      semester: json['semester'],
      tahunMasuk: json['tahun_masuk'].toString(),
      status: json['status'],
      dosenWaliId: json['dosen_wali_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final int id;
  final String username;
  final String namaLengkap;
  final String role;
  final String email;

  User({
    required this.id,
    required this.username,
    required this.namaLengkap,
    required this.role,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      namaLengkap: json['nama_lengkap'],
      role: json['role'],
      email: json['email'],
    );
  }
} 