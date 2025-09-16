import 'package:flutter/material.dart';
import 'package:academic_mobile/service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PengumumanPage extends StatefulWidget {
  const PengumumanPage({Key? key}) : super(key: key);

  @override
  State<PengumumanPage> createState() => _PengumumanPageState();
}

class _PengumumanPageState extends State<PengumumanPage> {
  final ApiService apiService = ApiService();
  late Future<List<Map<String, dynamic>>> _futurePengumuman;

  @override
  void initState() {
    super.initState();
    _futurePengumuman = apiService.getPengumumanMahasiswa();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengumuman'),
        backgroundColor: const Color(0xFF2D3357),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _futurePengumuman,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Gagal memuat pengumuman'));
          }
          final pengumumanList = snapshot.data ?? [];
          if (pengumumanList.isEmpty) {
            return Center(child: Text('Belum ada pengumuman.'));
          }
          return ListView.builder(
            itemCount: pengumumanList.length,
            itemBuilder: (context, index) {
              final item = pengumumanList[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(item['judul'] ?? '-'),
                  subtitle: Text(item['isi'] ?? '-'),
                  trailing: Text(item['created_at']?.substring(0, 10) ?? ''),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
