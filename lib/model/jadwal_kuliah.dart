class JadwalKuliah {
  final int id;
  final int mataKuliahId;
  final int dosenId;
  final String hari;
  final String jamMulai;
  final String jamSelesai;
  final String ruang;
  final String createdAt;
  final String updatedAt;

  JadwalKuliah({
    required this.id,
    required this.mataKuliahId,
    required this.dosenId,
    required this.hari,
    required this.jamMulai,
    required this.jamSelesai,
    required this.ruang,
    required this.createdAt,
    required this.updatedAt,
  });

  factory JadwalKuliah.fromJson(Map<String, dynamic> json) {
    return JadwalKuliah(
      id: json['id'],
      mataKuliahId: json['mata_kuliah_id'],
      dosenId: json['dosen_id'],
      hari: json['hari'],
      jamMulai: json['jam_mulai'],
      jamSelesai: json['jam_selesai'],
      ruang: json['ruang'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
} 