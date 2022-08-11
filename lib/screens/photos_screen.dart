
import 'package:flutter/material.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:transparent_image/transparent_image.dart';

import 'album_screen.dart';

class PhotosScreen extends StatefulWidget {
  final albums;
  const PhotosScreen({Key? key, required this.albums}) : super(key: key);

  @override
  State<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  @override
  Widget build(BuildContext context) {
    List<Album>? albums = widget.albums;
    return LayoutBuilder(
      builder: (context, constraints) {
        double gridWidth = (constraints.maxWidth - 20) / 3;
        double gridHeight = gridWidth + 33;
        double ratio = gridWidth / gridHeight;
        return Container(
          padding: const EdgeInsets.all(5),
          child: GridView.count(
            crossAxisCount: 3,
            childAspectRatio: ratio,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            children: [
              ...?albums?.map(
                (album) => GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return AlbumScreen(album: album);
                      },
                    ),
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          color: Colors.grey[300],
                          height: gridWidth,
                          width: gridWidth,
                          child: FadeInImage(
                            fit: BoxFit.cover,
                            placeholder: MemoryImage(kTransparentImage),
                            image: AlbumThumbnailProvider(
                              albumId: album.id,
                              mediumType: album.mediumType,
                              highQuality: true,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(left: 2.0),
                        child: Text(
                          album.name ?? "Unnamed Album",
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            height: 1.2,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(left: 2.0),
                        child: Text(
                          '(${album.count.toString()})',
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            height: 1.2,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
