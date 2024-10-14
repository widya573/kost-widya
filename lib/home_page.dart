import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, String>> kostList;
  final Function(Map<String, String>) onSaveKost;
  final Function(Map<String, String>) onRemoveKost;

  const HomePage({
    super.key,
    required this.kostList,
    required this.onSaveKost,
    required this.onRemoveKost,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Kost'),
        backgroundColor: Colors.orange,
      ),
      body: kostList.isEmpty
          ? const Center(child: Text('Belum ada postingan kost.'))
          : ListView.builder(
              itemCount: kostList.length,
              itemBuilder: (context, index) {
                final kost = kostList[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(kost['namaKost'] ?? 'Nama Kost'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Alamat: ${kost['alamatKost']}'),
                        Text('Nomor HP: ${kost['nomorHP']}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.bookmark),
                          onPressed: () => onSaveKost(kost), // Menyimpan kost
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => onRemoveKost(kost), // Menghapus kost
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
