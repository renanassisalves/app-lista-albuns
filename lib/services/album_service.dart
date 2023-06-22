import 'dart:convert';

import 'package:entrega_flutter_2/models/album.dart';
import 'package:entrega_flutter_2/repository/album/album_repository.dart';
import 'package:http/http.dart';

class AlbumsService{
  final AlbumRepository _albumRepository = AlbumRepository();

  Future<List<Album>> list() async {
    try {
      Response response = await _albumRepository.list();
      final json = jsonDecode(response.body);
      return Album.listFromJson(json);
    } catch (err) {
      throw Exception("Problemas ao listar álbuns");
    }
  }
}