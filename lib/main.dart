// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'home_page.dart';
import 'add_post_page.dart';
import 'saved_posts_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MainPage(),
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  List<Map<String, String>> kostList = [];
  List<Map<String, String>> savedPosts = [];

  void _addNewKost(Map<String, String> newKost) {
    setState(() {
      kostList.add(newKost);
    });
  }

  void _saveKost(Map<String, String> kost) {
    setState(() {
      savedPosts.add(kost); // Menambahkan kost ke daftar simpanan
    });
  }

  void _removeKost(Map<String, String> kost) {
    setState(() {
      kostList.remove(kost); // Menghapus kost dari daftar Home
    });
  }

  void _removeSavedKost(Map<String, String> kost) {
    setState(() {
      savedPosts.remove(kost); // Menghapus kost dari daftar Saved
    });
  }

  final List<Widget> _pages = [];

  @override
  Widget build(BuildContext context) {
    _pages.clear(); // Reset pages
    _pages.add(HomePage(kostList: kostList, onSaveKost: _saveKost, onRemoveKost: _removeKost));
    _pages.add(AddPostPage(onPostAdded: _addNewKost));
    _pages.add(SavedPostsPage(savedPosts: savedPosts, onRemoveSavedKost: _removeSavedKost));

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'cari kost',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            prefixIcon: const Icon(Icons.search),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              // Aksi untuk tombol profil
            },
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Saved',
          ),
        ],
        selectedItemColor: Colors.amber[800],
      ),
    );
  }
}
