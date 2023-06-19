

import 'package:entrega_flutter_2/models/album.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

import '../services/album_service.dart';

class AlbumProvider with ChangeNotifier {
 final albumList = [];
 List<int> favoriteList = [];
 final uid = FirebaseAuth.instance.currentUser?.uid;
 final _albumService = AlbumsService();

 AlbumProvider() {
  listarfavoritos().then((value) {
   try {
    favoriteList = List<int>.from(value);
   } catch (error) {
    favoriteList = [];
   }
  });
 }

 Future<List<Album>> listarAlbuns() async {
  return _albumService.list();
 }

 Future<List<dynamic>> listarfavoritos() async {
  DatabaseReference ref = FirebaseDatabase.instance.ref("users/$uid/favorites");
  List<dynamic> favoriteList = [];
  try {
   DataSnapshot snapshot = await ref.get();

   if (snapshot.value != null) {
    favoriteList = snapshot.value as List<dynamic>;

    print("Lista de favoritos: $favoriteList");
    return favoriteList;
   } else {
    print("Lista de favoritos não encontrada.");
   }
  } catch (error) {
   print("Erro ao ler lista de favoritos: $error");
  }
  return favoriteList;
 }

 Future<bool> adicionarNovoFavorito(int idFavorito) async {
  DatabaseReference ref = FirebaseDatabase.instance.ref("users/$uid/favorites");

  try {
   DataSnapshot snapshot = await ref.get();
   List<dynamic> favoriteList = [];

   if (snapshot.value != null) {
    if (snapshot.value is List) {
     favoriteList = List<dynamic>.from(snapshot.value as List<dynamic>);
    } else {
     favoriteList.add(snapshot.value);
    }
   }

   favoriteList.add(idFavorito);

   await ref.set(favoriteList);

   print("Novo favorito adicionado com sucesso.");
   return true;
  } catch (error) {
   print("Erro ao adicionar novo favorito: $error");
   return false;
  }
 }

 Future<bool> removerFavorito(int idFavorito) async {
  DatabaseReference ref = FirebaseDatabase.instance.ref("users/$uid/favorites");

  try {
   DataSnapshot snapshot = await ref.get();
   List<dynamic> favoriteList = [];

   if (snapshot.value != null) {
    if (snapshot.value is List) {
     favoriteList = List<dynamic>.from(snapshot.value as List<dynamic>);
    } else {
     favoriteList.add(snapshot.value);
    }
   }

   favoriteList.remove(idFavorito);

   await ref.set(favoriteList);

   print("Favorito removido com sucesso.");
   return true;
  } catch (error) {
   print("Erro ao remover favorito: $error");
   return false;
  }
 }
}