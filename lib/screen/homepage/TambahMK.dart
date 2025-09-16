import 'package:academic_mobile/service/api_service.dart';
import 'package:academic_mobile/model/mata_kuliah.dart';
import 'package:flutter/material.dart';

class TambahMKPage extends StatefulWidget {
  const TambahMKPage({super.key});

  @override
  State<TambahMKPage> createState() => _TambahMKPageState();
}

class _TambahMKPageState extends State<TambahMKPage> {
  final ApiService apiService = ApiService();
  Set<int> selectedMK = {};

  final List<String> prodiList = ['Sistem Informasi', 'Teknik Informatika'];
  String selectedProdi = 'Sistem Informasi';
  int selectedSemester = 2;
  bool isLoading = false;
  List<MataKuliah> mataKuliahList = [];

  @override
  void initState() {
    super.initState();
    fetchMatakuliah();
  }

  Future<void> fetchMatakuliah() async {
    setState(() { isLoading = true; });
    try {
      final data = await apiService.fetchMatakuliahBySemesterProdi(
        semester: selectedSemester,
        programStudi: selectedProdi,
      );
      mataKuliahList = data.map((e) => MataKuliah(
        id: e['id'],
        kode: e['kode'],
        nama: e['nama'] ?? e['mata_kuliah'] ?? '',
        sks: e['sks'] is int ? e['sks'] : int.tryParse(e['sks'].toString()) ?? 0,
        semester: e['semester'] is int ? e['semester'] : int.tryParse(e['semester'].toString()) ?? 0,
        kelas: e['kelas'] ?? '-',
      )).toList();
    } catch (e) {
      // handle error
      mataKuliahList = [];
    }
    setState(() { isLoading = false; });
  }

  void _submitAmbilMK() async {
    try {
      await apiService.ambilMatakuliah(selectedMK.toList());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Berhasil mengambil mata kuliah!')),
      );
      setState(() {
        selectedMK.clear();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal: $e')),
      );
    }
  }

  // Fungsi untuk mengelompokkan MK per semester
  Map<int, List<MataKuliah>> groupBySemester(List<MataKuliah> list) {
    final map = <int, List<MataKuliah>>{};
    for (var mk in list) {
      map.putIfAbsent(mk.semester, () => []).add(mk);
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 45, 51, 87),
      appBar: AppBar(
        title: const Text("Tambah MK"),
        backgroundColor: const Color.fromARGB(255, 45, 51, 87),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            )),
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            "Detail kartu rencana studi",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: selectedProdi,
                  decoration: const InputDecoration(
                    labelText: 'Program Study',
                    border: OutlineInputBorder(),
                  ),
                  items: prodiList.map((prodi) => DropdownMenuItem(
                    value: prodi,
                    child: Text(prodi),
                  )).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedProdi = value!;
                    });
                    fetchMatakuliah();
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DropdownButtonFormField<int>(
                  value: selectedSemester,
                  decoration: const InputDecoration(
                    labelText: 'Semester',
                    border: OutlineInputBorder(),
                  ),
                  items: List.generate(8, (i) => DropdownMenuItem(
                    value: i + 1,
                    child: Text('Semester ${i + 1}'),
                  )),
                  onChanged: (value) {
                    setState(() {
                      selectedSemester = value!;
                    });
                    fetchMatakuliah();
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView(
                    children: [
                      ExpansionTile(
                        title: Text('Paket Semester $selectedSemester'),
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columns: const [
                                DataColumn(label: Text('Pilih')),
                                DataColumn(label: Text('No')),
                                DataColumn(label: Text('Kode MK')),
                                DataColumn(label: Text('Mata Kuliah')),
                                DataColumn(label: Text('Sks')),
                                DataColumn(label: Text('Smt')),
                                DataColumn(label: Text('Kelas')),
                              ],
                              rows: List.generate(mataKuliahList.length, (index) {
                                final mk = mataKuliahList[index];
                                return DataRow(
                                  selected: selectedMK.contains(mk.id),
                                  cells: [
                                    DataCell(Checkbox(
                                      value: selectedMK.contains(mk.id),
                                      onChanged: (val) {
                                        setState(() {
                                          if (val == true) {
                                            selectedMK.add(mk.id);
                                          } else {
                                            selectedMK.remove(mk.id);
                                          }
                                        });
                                      },
                                    )),
                                    DataCell(Text((index + 1).toString())),
                                    DataCell(Text(mk.kode)),
                                    DataCell(Text(mk.nama)),
                                    DataCell(Text(mk.sks.toString())),
                                    DataCell(Text(mk.semester.toString())),
                                    DataCell(Text(mk.kelas)),
                                  ],
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
          ElevatedButton(
            onPressed: selectedMK.isEmpty ? null : _submitAmbilMK,
            child: Text('Ambil Mata Kuliah'),
          ),
        ]),
      ),
    );
  }
}
