import 'package:flutter/material.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:transparent_image/transparent_image.dart';

import 'image_viewer_screen.dart';

class AlbumScreen extends StatefulWidget {
  final Album album;
  const AlbumScreen({
    Key? key,
    required this.album,
  }) : super(key: key);

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  List<Medium>? _media;

  @override
  void initState() {
    super.initState();
    initAsync();
  }

  void initAsync() async {
    MediaPage mediaPage = await widget.album.listMedia();
    setState(() {
      _media = mediaPage.items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.album.name ?? "Unnamed Album",
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
        children: [
          ...?_media?.map(
            (medium) => GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ImageViewerScreen(medium: medium),
                ),
              ),
              child: Container(
                color: Colors.grey[300],
                child: Image(
                  fit: BoxFit.cover,
                  image: ThumbnailProvider(
                    mediumId: medium.id,
                    mediumType: medium.mediumType,
                    highQuality: true,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

