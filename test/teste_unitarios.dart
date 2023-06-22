//Testes unitários
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:entrega_flutter_2_package/entrega_flutter_2_package.dart';
import 'package:entrega_flutter_2_package/models/album.dart';

void main() {
  group('Pacotes', () {
    int idAleatorio = Random().nextInt(100);
    test('Testar se um álbum é gerado a partir da biblioteca de geração', () {
      Album albumGerado = GeradorAlbuns().gerarAlbum(idAleatorio);
      expect(albumGerado, isA<Album>());
    });

    test('Testar se o id gerado é realmente implementado no álbum gerado', () {
      Album albumGerado = GeradorAlbuns().gerarAlbum(idAleatorio);
      expect(albumGerado.id, idAleatorio);
    });

    test('Testar se a imagem gerada é uma imagem válida', () async {
      Album albumGerado = GeradorAlbuns().gerarAlbum(idAleatorio);
      final response = await http.get(Uri.parse(albumGerado.thumbnailUrl));
      expect(response.statusCode, equals(200));
      String? contentType = response.headers['content-type'];
      expect(contentType, startsWith('image/'));
    });
  });
}