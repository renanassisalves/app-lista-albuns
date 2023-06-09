import 'package:entrega_flutter_2/models/album.dart';
import 'package:flutter/material.dart';

class AlbumListItem extends StatelessWidget {
  const AlbumListItem({Key? key, required this.album}) : super(key: key);
  final Album album;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(album.thumbnailUrl),
      title: Text(album.title),
      subtitle: Text(album.url),
    );
  }
}
