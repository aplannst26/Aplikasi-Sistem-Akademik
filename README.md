# 📱 Aplikasi Sistem Akademik Mobile

Aplikasi mobile untuk sistem akademik yang memudahkan mahasiswa dalam mengakses informasi akademik, jadwal kuliah, KRS, KHS, dan fitur-fitur lainnya.

## 🚀 Fitur Utama

- **🔐 Autentikasi**: Login dan registrasi mahasiswa
- **📊 Dashboard**: Halaman utama dengan informasi penting
- **📅 Jadwal Kuliah**: Lihat jadwal kuliah harian dan mingguan
- **📝 KRS (Kartu Rencana Studi)**: Kelola mata kuliah yang diambil
- **📈 KHS (Kartu Hasil Studi)**: Lihat nilai dan IPK
- **👤 Biodata**: Kelola informasi pribadi mahasiswa
- **🆔 KTM**: Kartu Tanda Mahasiswa digital
- **📢 Pengumuman**: Informasi penting dari kampus
- **📤 Upload Tugas**: Kirim tugas dan file
- **✅ Absensi**: Presensi kehadiran kuliah
- **📋 Pengajuan Cuti**: Ajukan cuti akademik
- **ℹ️ Informasi**: Informasi umum kampus

## 🛠️ Teknologi yang Digunakan

- **Flutter**: Framework untuk pengembangan aplikasi mobile
- **Dart**: Bahasa pemrograman utama
- **Material Design**: UI/UX design system
- **HTTP**: Untuk komunikasi dengan API
- **Shared Preferences**: Penyimpanan data lokal

## 📋 Persyaratan Sistem

- **Flutter SDK**: Versi 3.0 atau lebih baru
- **Dart SDK**: Versi 2.17 atau lebih baru
- **Android**: API level 21 (Android 5.0) atau lebih baru
- **iOS**: iOS 11.0 atau lebih baru
- **Internet Connection**: Untuk sinkronisasi data

## 🔧 Instalasi dan Setup

### 1. Clone Repository
```bash
git clone https://github.com/aplannst26/Aplikasi-Sistem-Akademik.git
cd Aplikasi-Sistem-Akademik
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Konfigurasi API
Edit file `lib/service/api_service.dart` dan sesuaikan dengan endpoint API Anda:
```dart
class ApiService {
  static const String baseUrl = 'YOUR_API_BASE_URL';
  // Sesuaikan dengan URL API Anda
}
```

### 4. Run Aplikasi
```bash
# Untuk Android
flutter run

# Untuk iOS (hanya di macOS)
flutter run -d ios

# Untuk Web
flutter run -d web
```

## 📱 Cara Menggunakan Aplikasi

### 🔐 Login dan Registrasi

1. **Buka Aplikasi**
   - Jalankan aplikasi di perangkat Anda
   - Anda akan melihat halaman welcome

2. **Registrasi (Untuk Pengguna Baru)**
   - Klik tombol "Daftar" atau "Register"
   - Isi formulir dengan data yang valid:
     - Nama lengkap
     - NIM (Nomor Induk Mahasiswa)
     - Email
     - Password
   - Klik "Daftar" untuk menyelesaikan registrasi

3. **Login**
   - Masukkan NIM dan password
   - Klik "Masuk" atau "Login"
   - Tunggu proses autentikasi selesai

### 🏠 Dashboard Utama

Setelah login berhasil, Anda akan masuk ke dashboard utama yang berisi:

- **Profil Mahasiswa**: Informasi singkat tentang Anda
- **Jadwal Hari Ini**: Mata kuliah yang akan berlangsung hari ini
- **Pengumuman Terbaru**: Informasi penting dari kampus
- **Menu Navigasi**: Akses ke semua fitur aplikasi

### 📅 Menggunakan Jadwal Kuliah

1. **Akses Jadwal**
   - Dari dashboard, klik menu "Jadwal Kuliah"
   - Atau dari menu utama, pilih "Jadwal"

2. **Lihat Jadwal**
   - Jadwal ditampilkan dalam format mingguan
   - Warna berbeda untuk setiap mata kuliah
   - Tap pada mata kuliah untuk detail lebih lanjut

3. **Detail Mata Kuliah**
   - Nama mata kuliah
   - Dosen pengajar
   - Ruang kelas
   - Waktu kuliah

### 📝 Mengelola KRS (Kartu Rencana Studi)

1. **Akses KRS**
   - Dari menu utama, pilih "KRS"
   - Lihat mata kuliah yang sudah terdaftar

2. **Tambah Mata Kuliah**
   - Klik tombol "Tambah Mata Kuliah"
   - Pilih mata kuliah dari daftar yang tersedia
   - Konfirmasi penambahan

3. **Hapus Mata Kuliah**
   - Tap pada mata kuliah yang ingin dihapus
   - Konfirmasi penghapusan

### 📈 Melihat KHS (Kartu Hasil Studi)

1. **Akses KHS**
   - Dari menu utama, pilih "KHS"
   - Lihat nilai semester yang sudah ada

2. **Detail Nilai**
   - Tap pada semester untuk melihat detail
   - Lihat nilai per mata kuliah
   - Cek IPK dan SKS

### 👤 Mengelola Biodata

1. **Akses Biodata**
   - Dari menu utama, pilih "Biodata"
   - Lihat informasi pribadi Anda

2. **Edit Informasi**
   - Klik tombol "Edit" atau ikon pensil
   - Ubah informasi yang diperlukan
   - Simpan perubahan

### 🆔 KTM Digital

1. **Akses KTM**
   - Dari menu utama, pilih "KTM"
   - Lihat kartu tanda mahasiswa digital

2. **Informasi KTM**
   - Nama lengkap
   - NIM
   - Program studi
   - Foto mahasiswa

### 📢 Pengumuman

1. **Lihat Pengumuman**
   - Dari dashboard atau menu "Pengumuman"
   - Scroll untuk melihat semua pengumuman

2. **Detail Pengumuman**
   - Tap pada pengumuman untuk membaca lengkap
   - Lihat tanggal dan waktu pengumuman

### 📤 Upload Tugas

1. **Akses Upload Tugas**
   - Dari menu utama, pilih "Upload Tugas"
   - Lihat daftar tugas yang tersedia

2. **Upload File**
   - Pilih mata kuliah
   - Pilih file dari perangkat
   - Tambahkan catatan jika diperlukan
   - Klik "Upload"

### ✅ Absensi

1. **Akses Absensi**
   - Dari menu utama, pilih "Absensi"
   - Lihat status kehadiran

2. **Absen Masuk**
   - Klik tombol "Absen Masuk"
   - Tunggu konfirmasi berhasil

### 📋 Pengajuan Cuti

1. **Akses Pengajuan Cuti**
   - Dari menu utama, pilih "Pengajuan Cuti"
   - Lihat status pengajuan sebelumnya

2. **Ajukan Cuti Baru**
   - Klik "Ajukan Cuti"
   - Isi formulir pengajuan:
     - Alasan cuti
     - Tanggal mulai dan selesai
     - Lampiran dokumen (opsional)
   - Submit pengajuan

### ℹ️ Informasi Kampus

1. **Akses Informasi**
   - Dari menu utama, pilih "Informasi"
   - Lihat informasi umum kampus

2. **Kategori Informasi**
   - Kontak kampus
   - Alamat dan lokasi
   - Jam operasional
   - Informasi penting lainnya

## 🔧 Troubleshooting

### Masalah Umum dan Solusi

1. **Aplikasi Tidak Bisa Login**
   - Pastikan koneksi internet stabil
   - Cek NIM dan password
   - Restart aplikasi

2. **Data Tidak Muncul**
   - Cek koneksi internet
   - Refresh halaman (pull to refresh)
   - Logout dan login kembali

3. **Upload Tugas Gagal**
   - Pastikan file tidak terlalu besar
   - Cek koneksi internet
   - Pastikan format file sesuai

4. **Jadwal Tidak Update**
   - Refresh halaman
   - Cek koneksi internet
   - Hubungi admin jika masalah berlanjut

## 📞 Kontak dan Support

- **Email**: aplannst41@gmail.com
- **GitHub**: [aplannst26](https://github.com/aplannst26)
- **Repository**: [Aplikasi-Sistem-Akademik](https://github.com/aplannst26/Aplikasi-Sistem-Akademik)

## 📄 Lisensi

Aplikasi ini dibuat untuk keperluan akademik. Silakan gunakan dengan bijak dan sesuai dengan peraturan kampus.

## 🤝 Kontribusi

Kontribusi sangat diterima! Silakan:
1. Fork repository ini
2. Buat branch fitur baru
3. Commit perubahan Anda
4. Push ke branch
5. Buat Pull Request

---

**Dibuat dengan ❤️ menggunakan Flutter**