import 'dart:io';

import 'package:flutter/material.dart';

class SavedPostsPage extends StatelessWidget {
  final List<Map<String, String>> savedPosts;
  final Function(Map<String, String>) onRemoveSavedKost;

  const SavedPostsPage({
    super.key,
    required this.savedPosts,
    required this.onRemoveSavedKost,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Posts'),
        backgroundColor: Colors.orange,
      ),
      body: savedPosts.isEmpty
          ? const Center(child: Text('Tidak ada kost yang disimpan.'))
          : ListView.builder(
              itemCount: savedPosts.length,
              itemBuilder: (context, index) {
                final kost = savedPosts[index];
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
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => onRemoveSavedKost(kost), // Menghapus kost dari saved posts
                    ),
                    leading: kost['imagePath'] == '' 
                        ? const Icon(Icons.image_not_supported) 
                        : Image.file(File(kost['imagePath']!)),
                  ),
                );
              },
            ),
    );
  }
}
