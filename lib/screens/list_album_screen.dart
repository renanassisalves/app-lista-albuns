import 'package:entrega_flutter_2/services/album_service.dart';
import 'package:flutter/material.dart';

import '../components/album_list_item.dart';
import '../models/album.dart';

class AlbumListScreen extends StatefulWidget {
  AlbumListScreen({Key? key}) : super(key: key);

  @override
  State<AlbumListScreen> createState() => _AlbumListScreenState();
}

class _AlbumListScreenState extends State<AlbumListScreen> {
  final _albumService = AlbumsService();
  @override
  Widget build(BuildContext context) {
    List<Widget> _generateListAlbums(List<Album> albums) {
      return albums
          .map<Widget>((album) => AlbumListItem(album: album,))
          .toList();
    }
    return Scaffold(
      appBar: AppBar(
          title: const Text("Lista de albuns")
      ),
      body: Padding(padding: const EdgeInsets.all(10),
        child: FutureBuilder(
          future: _albumService.list(),
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
        )
      ),
        bottomNavigationBar: BottomNavigationBar(items: const [
          BottomNavigationBarItem(
            label: "Adicionar novo item",
              icon: Icon(Icons.add)
          ),
          BottomNavigationBarItem(
            label: "Teste",
              icon: Icon(Icons.add_alert_sharp)),
        ]),
    );
  }
}
