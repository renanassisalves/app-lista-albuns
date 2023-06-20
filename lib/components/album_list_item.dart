import 'package:entrega_flutter_2/models/album.dart';
import 'package:entrega_flutter_2/routes/RoutePaths.dart';
import 'package:entrega_flutter_2/screens/album_thumbchange_screen.dart';
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
  late String imageUrl;

  @override
  void initState() {
    super.initState();
    final thumbnailUrl = widget.album.thumbnailUrl;

    setState(() {
      imageUrl = thumbnailUrl;
      print("inicio: $thumbnailUrl");
    });
  }

  void fetchImageUrl() async {
    try {
      final firebaseStorage = FirebaseStorage.instance;
      final reference = firebaseStorage.ref("albums/${widget.album.id}.jpg");
      final value = await reference.getDownloadURL();
      setState(() {
        imageUrl = value;
      });
    } catch (ignored) {}
  }

  @override
  Widget build(BuildContext context) {
    fetchImageUrl();
    // var imageUrl = widget.album.thumbnailUrl;
    final albumProvider = Provider.of<AlbumProvider>(context);
    return ListTile(
      leading: SizedBox(
        height: 100,
        width: 100,
        child: Image.network(imageUrl),
      ),
      title: Text(widget.album.title),
      subtitle: Text(widget.album.url),
      trailing: Column(
        children: [
          Wrap(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: const EdgeInsets.all(4),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.red,
                  disabledForegroundColor: Colors.transparent,
                ),
                onPressed: () {
                  setState(() {
                    widget.album.toggleFavorite();
                    if (widget.album.favorite) {
                      albumProvider.adicionarNovoFavorito(widget.album.id);
                    } else {
                      albumProvider.removerFavorito(widget.album.id);
                    }
                  });
                },
                child: widget.album.favorite
                    ? const Icon(Icons.favorite)
                    : const Icon(Icons.favorite_border),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: const EdgeInsets.all(4),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                    disabledForegroundColor: Colors.transparent,
                  ),
                  onPressed: () {
                    albumProvider.setAlbumSelecionado(widget.album);
                    Navigator.of(context)
                        .pushNamed(RoutePaths.ALBUM_THUMBCHANGE_SCREEN);
                  },
                  child: const Icon(Icons.image)),
            ],
          ),
        ],
      ),
    );
  }
}
