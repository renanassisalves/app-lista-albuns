import 'package:entrega_flutter_2/models/album.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/album_provider.dart';

class AlbumListItem extends StatefulWidget {
  const AlbumListItem({Key? key, required this.album}) : super(key: key);
  final Album album;

  @override
  State<AlbumListItem> createState() => _AlbumListItemState();
}

class _AlbumListItemState extends State<AlbumListItem> {
  @override
  Widget build(BuildContext context) {
    final albumProvider = Provider.of<AlbumProvider>(context);
    return ListTile(
      leading: Image.network(widget.album.thumbnailUrl),
      title: Text(widget.album.title),
      subtitle: Text(widget.album.url),
      trailing:  ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: Size.zero,
            padding: const EdgeInsets.all(4),
            backgroundColor: Colors.white,
            disabledBackgroundColor: Colors.transparent,
            foregroundColor: Colors.red,
            disabledForegroundColor: Colors.transparent,
        ),
        onPressed: (){
        setState(() {
          widget.album.toggleFavorite();
          if (widget.album.favorite) {
            albumProvider.adicionarNovoFavorito(widget.album.id);
          } else {
            albumProvider.removerFavorito(widget.album.id);
          }
        });
      },
        child: widget.album.favorite?
      const Icon(Icons.favorite):
      const Icon(Icons.favorite_border),
      ),
    );
  }
}
