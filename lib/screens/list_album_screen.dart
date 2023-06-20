import 'package:entrega_flutter_2/providers/album_provider.dart';
import 'package:entrega_flutter_2/services/album_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/album_list_item.dart';
import '../models/album.dart';

class AlbumListScreen extends StatefulWidget {
  const AlbumListScreen({Key? key}) : super(key: key);

  @override
  State<AlbumListScreen> createState() => _AlbumListScreenState();
}

class _AlbumListScreenState extends State<AlbumListScreen> {
  @override
  Widget build(BuildContext context) {
    final albumProvider = Provider.of<AlbumProvider>(context);
    List<Widget> _generateListAlbums(List<Album> albumsList) {
      final favoriteList = albumProvider.favoriteList;
      albumsList.asMap().forEach((key, value) {
        if (favoriteList.contains(value.id)) {
          albumsList[key].setFavorite(true);
        }
      });
      return albumsList
          .map<Widget>(
            (album) => AlbumListItem(
              album: album,
            ),
          )
          .toList();
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Lista de albuns")),
      body: FutureBuilder(
        future: albumProvider.listarAlbuns(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Erro ao consultar dados: ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            final list = snapshot.data;
            if (list != null && list.isNotEmpty) {
              return ListView(
                children: _generateListAlbums(list),
              );
            } else {
              return const Center(
                child: Text("Nenhum produto cadastrado."),
              );
            }
          } else {
            return const Center(
              child: Text("Nenhum produto cadastrado."),
            );
          }
        },
      ),
    );
  }
}
