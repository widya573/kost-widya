// ignore_for_file: library_private_types_in_public_api, no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPostPage extends StatefulWidget {
  final Function(Map<String, String>) onPostAdded;

  const AddPostPage({super.key, required this.onPostAdded});

  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  XFile? _image;

  void _savePost() {
    String name = _nameController.text;
    String price = _priceController.text;
    String address = _addressController.text;
    String phone = _phoneController.text;

    if (name.isNotEmpty && price.isNotEmpty && address.isNotEmpty && phone.isNotEmpty) {
      Map<String, String> newKost = {
        'namaKost': name,
        'hargaKost': price,
        'alamatKost': address,
        'nomorHP': phone,
        'imagePath': _image?.path ?? '', // Menambahkan foto kost
      };

      widget.onPostAdded(newKost); // Kirim data ke halaman utama

      _nameController.clear();
      _priceController.clear();
      _addressController.clear();
      _phoneController.clear();
      setState(() {
        _image = null; // Reset gambar
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Postingan kost berhasil disimpan!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Mohon isi semua kolom.")),
      );
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Postingan Kost'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input field for Nama Kost
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nama Kost',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            // Input field for Harga Kost
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(
                labelText: 'Harga Kost (per bulan)',
                border: OutlineInputBorder(),
                hintText: 'Masukkan harga dalam rupiah',
                prefixIcon: Icon(Icons.attach_money),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),

            // Input field for Alamat Kost
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: 'Alamat Kost/Link Map',
                border: OutlineInputBorder(),
                hintText: 'Masukkan alamat atau link Google Maps',
              ),
            ),
            const SizedBox(height: 10),

            // Input field for Nomor HP Pemilik
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Nomor HP Pemilik',
                border: OutlineInputBorder(),
                hintText: 'Masukkan nomor HP',
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 10),

            // Upload Image Button
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Upload Foto Kost'),
            ),
            const SizedBox(height: 10),

            // Foto kost display
            _image == null
                ? const Text('No image selected.')
                : Image.file(File(_image!.path)),

            const SizedBox(height: 20),

            // Simpan button
            ElevatedButton(
              onPressed: _savePost,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              child: const Text('Simpan Postingan'),
            ),
          ],
        ),
      ),
    );
  }
}
