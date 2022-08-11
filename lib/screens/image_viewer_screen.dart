import 'package:flutter/material.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:transparent_image/transparent_image.dart';

class ImageViewerScreen extends StatefulWidget {
  final Medium medium;
  const ImageViewerScreen({
    Key? key,
    required this.medium,
  }) : super(key: key);

  @override
  State<ImageViewerScreen> createState() => _ImageViewerScreenState();
}

class _ImageViewerScreenState extends State<ImageViewerScreen> {
  @override
  Widget build(BuildContext context) {
    DateTime? date = widget.medium.creationDate ?? widget.medium.modifiedDate;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back),
          ),
          title: date != null ? Text(date.toLocal().toString()) : null,
        ),
        body: Container(
          alignment: Alignment.center,
          child: FadeInImage(
            fit: BoxFit.cover,
            placeholder: MemoryImage(kTransparentImage),
            image: PhotoProvider(mediumId: widget.medium.id),
          ),
        ),
      ),
    );
  }
}
