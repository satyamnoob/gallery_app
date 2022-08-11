import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_app/screens/photos_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_gallery/photo_gallery.dart';

import 'explore_screen.dart';
import 'videos_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Album>? imageAlbums;
  List<Album>? videoAlbums;
  int _pageIndex = 0;
  List<Widget> pages = [];

  @override
  void initState() {
    super.initState();
    initAsync();
  }

  void initAsync() async {
    if (await _promptPermissionSetting()) {
      List<Album> albumsImg = await PhotoGallery.listAlbums(
        mediumType: MediumType.image,
      );
      List<Album> albumsVideo = await PhotoGallery.listAlbums(
        mediumType: MediumType.video,
      );
      setState(() {
        imageAlbums = albumsImg;
        videoAlbums = albumsVideo;
      });
      pages = [
        PhotosScreen(albums: imageAlbums),
        VideosScreen(albums: videoAlbums),
        const ExploreScreen(),
      ];
    }
  }

  Future<bool> _promptPermissionSetting() async {
    if (Platform.isIOS &&
            await Permission.storage.request().isGranted &&
            await Permission.photos.request().isGranted ||
        Platform.isAndroid && await Permission.storage.request().isGranted) {
      return true;
    }
    return false;
  }

  void _onItemTapped(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0x00ffffff),
        selectedFontSize: 18,
        selectedIconTheme: const IconThemeData(
          color: Colors.amberAccent,
          size: 30,
        ),
        selectedItemColor: Colors.amberAccent,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        currentIndex: _pageIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        unselectedIconTheme: const IconThemeData(
          color: Colors.white,
          size: 20,
        ),
        unselectedItemColor: Colors.white,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: 'Photos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_camera_back),
            label: 'Videos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Explore',
          ),
        ],
      ),
      body: pages[_pageIndex],
    );
  }
}
