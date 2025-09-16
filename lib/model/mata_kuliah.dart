class MataKuliah {
  final int id;
  final String kode;
  final String nama;
  final int sks;
  final int semester;
  final String kelas;

  MataKuliah({
    required this.id,
    required this.kode,
    required this.nama,
    required this.sks,
    required this.semester,
    required this.kelas,
  });

  factory MataKuliah.fromJson(Map<String, dynamic> json) {
    return MataKuliah(
      id: json['id'],
      kode: json['kode'],
      nama: json['mata_kuliah'],
      sks: json['sks'],
      semester: json['semester'],
      kelas: json['kelas'],
    );
  }
}
