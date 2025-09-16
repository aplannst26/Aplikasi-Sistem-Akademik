import 'dart:io';
import 'dart:convert'; // Added for jsonDecode
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:academic_mobile/screen/welcomescreen/LoginScreen.dart';
import 'package:academic_mobile/model/mahasiswa_profile.dart';
import 'package:academic_mobile/service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http; // Added for http

class ProfilePage extends StatefulWidget {
  final String? googleName;
  const ProfilePage({Key? key, this.googleName}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _profileImage;
  File? _imageFile;
  bool _isLoading = false;
  String? _photoUrl;

  String getFullPhotoUrl(String? photoUrl) {
    if (photoUrl == null) return 'assets/images.png';
    if (photoUrl.startsWith('http')) return photoUrl;

    String base = apiService.baseUrl;
    if (base.endsWith('/')) base = base.substring(0, base.length - 1);
    if (base.endsWith('/api')) {
      base = base.substring(0, base.length - 4);
    }
    String path = photoUrl;
    if (path.startsWith('/')) path = path.substring(1);

    if (path.startsWith('storage/')) {
      return '$base/$path';
    } else {
      return '$base/storage/$path';
    }
  }

  final ApiService apiService = ApiService();

  // Controllers for all fields
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();
  final TextEditingController _fakultasController = TextEditingController();
  final TextEditingController _prodiController = TextEditingController();
  final TextEditingController _semesterController = TextEditingController();
  final TextEditingController _tahunMasukController = TextEditingController();

  MahasiswaProfile? _profile;

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    setState(() { _isLoading = true; });
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');
      final baseUrl = apiService.baseUrl;
      final response = await http.get(
        Uri.parse('$baseUrl/mahasiswa/profile'),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _photoUrl = data['photo'] ?? data['photo_url'];
          _profile = MahasiswaProfile.fromJson(data); // Assuming MahasiswaProfile can parse the full response
          _namaController.text = _profile!.user.namaLengkap;
          _emailController.text = _profile!.user.email;
          _nimController.text = _profile!.nim;
          _fakultasController.text = _profile!.fakultas;
          _prodiController.text = _profile!.programStudi;
          _semesterController.text = _profile!.semester.toString();
          _tahunMasukController.text = _profile!.tahunMasuk.toString();
        });
      }
    } catch (e) {
      // handle error jika perlu
    } finally {
      setState(() { _isLoading = false; });
    }
  }

  void _handleSaveProfile() async {
    try {
      await apiService.updateMahasiswaProfile(
        namaLengkap: _namaController.text,
        email: _emailController.text,
        nim: _nimController.text,
        fakultas: _fakultasController.text,
        prodi: _prodiController.text,
        semester: _semesterController.text,
        tahunMasuk: _tahunMasukController.text,
      );
      Fluttertoast.showToast(msg: 'Profil berhasil disimpan');
    } catch (e) {
      Fluttertoast.showToast(msg: 'Gagal simpan profil: $e');
    }
  }

  Future<void> _pickAndUploadPhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    final baseUrl = apiService.baseUrl;

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/mahasiswa/profile/photo'),
    );
    request.headers['Authorization'] = 'Bearer $token';
    request.files.add(await http.MultipartFile.fromPath('photo', pickedFile.path));

    var response = await request.send();
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: 'Foto profil berhasil diupload');
      await _fetchProfile(); // fetch ulang profile agar foto terbaru
    } else {
      Fluttertoast.showToast(msg: 'Gagal upload foto');
    }
  }

  Widget _buildTextField(TextEditingController controller, String label, {bool enabled = true}) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_profile == null && widget.googleName == null) {
      return const Center(child: Text('Gagal memuat data profile'));
    }
    return Scaffold(
      backgroundColor: const Color.fromRGBO(45, 51, 87, 1),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.logout, color: Colors.white),
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.remove('access_token');
                      await GoogleSignIn().signOut(); // Tambahkan logout Google
                      if (mounted) {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                          (Route<dynamic> route) => false,
                        );
                      }
                    },
                  ),
                  const Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: ClipOval(
                    child: _photoUrl != null
                        ? Image.network(getFullPhotoUrl(_photoUrl), fit: BoxFit.cover)
                        : Image.asset(
                            'assets/images.png',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.grey,
                                child: Icon(Icons.person, size: 60, color: Colors.white),
                              );
                            },
                          ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: _pickAndUploadPhoto,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(blurRadius: 2, color: Colors.black26)],
                      ),
                      padding: EdgeInsets.all(8),
                      child: Icon(Icons.edit, color: Color.fromRGBO(45, 51, 87, 1)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Text(
              widget.googleName ?? _namaController.text,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(45, 51, 87, 1),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                ),
                child: ListView(
                  children: [
                    _buildTextField(_namaController, 'Nama Lengkap'),
                    const SizedBox(height: 24),
                    _buildTextField(_emailController, 'Email'),
                    const SizedBox(height: 24),
                    _buildTextField(_nimController, 'NIM'),
                    const SizedBox(height: 24),
                    _buildTextField(_fakultasController, 'Fakultas'),
                    const SizedBox(height: 24),
                    _buildTextField(_prodiController, 'Program Studi'),
                    const SizedBox(height: 24),
                    _buildTextField(_semesterController, 'Semester'),
                    const SizedBox(height: 24),
                    _buildTextField(_tahunMasukController, 'Tahun Masuk'),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: _handleSaveProfile,
                      child: Text('Simpan'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
