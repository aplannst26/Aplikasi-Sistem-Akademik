import 'dart:convert';
import 'package:academic_mobile/model/mata_kuliah.dart';
import 'package:http/http.dart' as http;
import 'package:academic_mobile/model/mahasiswa_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:academic_mobile/model/jadwal_kuliah.dart';
import 'dart:io';

class ApiService {
  final String baseUrl = 'https://be6ff9e9949c.ngrok-free.app/api';

  Future<List<MataKuliah>> getMataKuliah() async {
    final response = await http.get(
      Uri.parse('$baseUrl/mata-kuliah'),
      headers: {'Accept': 'application/json'},
    );
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => MataKuliah.fromJson(e)).toList();
    } else {
      throw Exception('Gagal memuat data mata kuliah');
    }
  }

  Future<void> ambilMatakuliah(List<int> mataKuliahIds) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    final response = await http.post(
      Uri.parse('$baseUrl/mahasiswa/krs'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'mata_kuliah_ids': mataKuliahIds}),
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Gagal mengambil mata kuliah: ${response.body}');
    }
  }

  Future<List<Map<String, dynamic>>> getKRS() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    final response = await http.get(
      Uri.parse('$baseUrl/mahasiswa/krs'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Gagal memuat data KRS: ${response.body}');
    }
  }

  Future<List<Map<String, dynamic>>> getKHS() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    final response = await http.get(
      Uri.parse('$baseUrl/mahasiswa/khs'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Gagal memuat data KHS: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> registerUser({
    required String username,
    required String email,
    required String nim,
    required String name,
    required String phone,
    required String password,
    required String fakultas,
    required String programStudi,
    required String semester,
    required String tahunMasuk,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'username': username,
        'email': email,
        'nim': nim,
        'password': password,
        'password_confirmation': password,
        'role': 'mahasiswa',
        'nama_lengkap': name,
        'fakultas': fakultas,
        'program_studi': programStudi,
        'phone': phone,
        'semester': semester,
        'tahun_masuk': tahunMasuk,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Gagal mendaftar: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Gagal login: ${response.body}');
    }
  }

  Future<MahasiswaProfile> getMahasiswaProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    final response = await http.get(
      Uri.parse('$baseUrl/mahasiswa/profile'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return MahasiswaProfile.fromJson(data);
    } else {
      throw Exception('Gagal memuat data profile: ${response.body}');
    }
  }

  Future<List<JadwalKuliah>> getJadwalKuliah() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    final response = await http.get(
      Uri.parse('$baseUrl/mahasiswa/jadwal'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => JadwalKuliah.fromJson(e)).toList();
    } else {
      throw Exception('Gagal memuat jadwal kuliah: ${response.body}');
    }
  }

  Future<void> updateMahasiswaProfile({
    required String namaLengkap,
    required String email,
    required String nim,
    required String fakultas,
    required String prodi,
    required String semester,
    required String tahunMasuk,
    String? jenisKelamin,
    String? ttl,
    String? nomorHp,
    String? alamat,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    final body = {
      'nama_lengkap': namaLengkap,
      'email': email,
      'nim': nim,
      'fakultas': fakultas,
      'program_studi': prodi,
      'semester': semester,
      'tahun_masuk': tahunMasuk,
    };
    if (jenisKelamin != null) body['jenis_kelamin'] = jenisKelamin;
    if (ttl != null) body['ttl'] = ttl;
    if (nomorHp != null) body['nomor_hp'] = nomorHp;
    if (alamat != null) body['alamat'] = alamat;
    final response = await http.put(
      Uri.parse('$baseUrl/mahasiswa/profile'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Gagal update profil:  [${response.body}');
    }
  }

  Future<List<Map<String, dynamic>>> fetchMatakuliahBySemesterProdi({
    required int semester,
    required String programStudi,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    final url = Uri.parse('$baseUrl/mahasiswa/matakuliah?semester=$semester&program_studi=$programStudi');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      // Jika response Anda: { "data": [...] }
      return List<Map<String, dynamic>>.from(jsonData['data']);
    } else {
      throw Exception('Gagal memuat data matakuliah');
    }
  }

  Future<Map<String, dynamic>> uploadTugasMahasiswa({
    required int krsId,
    required File file,
    String? judul,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/mahasiswa/upload-tugas'),
    );
    request.headers['Authorization'] = 'Bearer $token';
    request.fields['krs_id'] = krsId.toString();
    if (judul != null && judul.isNotEmpty) {
      request.fields['judul'] = judul;
    }
    request.files.add(await http.MultipartFile.fromPath('file', file.path));
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Gagal upload tugas: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> absenMahasiswa({
    required int krsId,
    required String tanggal,
    required String status,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    var body = {
      'krs_id': krsId.toString(),
      'tanggal': tanggal,
      'status': status,
    };
    final response = await http.post(
      Uri.parse('$baseUrl/mahasiswa/absensi'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Gagal absen: ${response.body}');
    }
  }

  Future<List<Map<String, dynamic>>> getPengumumanMahasiswa() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    final response = await http.get(
      Uri.parse('$baseUrl/mahasiswa/pengumuman'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      throw Exception('Gagal mengambil pengumuman: ${response.body}');
    }
  }
  
}
