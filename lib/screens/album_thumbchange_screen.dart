import 'dart:io';

import 'package:entrega_flutter_2/routes/RoutePaths.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../providers/album_provider.dart';

class ThumbChangeScreen extends StatefulWidget {
  const ThumbChangeScreen({Key? key}) : super(key: key);
  @override
  State<ThumbChangeScreen> createState() => _ThumbChangeScreenState();
}

class _ThumbChangeScreenState extends State<ThumbChangeScreen> {
  File? image;
  @override
  Widget build(BuildContext context) {
    void alterarImagem() async {
      final picker = ImagePicker();

      final pickImage = await picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 50,
          maxWidth: 200,
      );

      if (pickImage != null) {
        setState(() {
          image = File(pickImage.path);
        });
      }
    }

    final albumProvider = Provider.of<AlbumProvider>(context);
    final albumSelecionado = albumProvider.getAlbumSelecionado();

    void salvarImagem() {
      final firebaseStorage = FirebaseStorage.instance;
      final reference = firebaseStorage.ref("albums/${albumSelecionado.id}.jpg");
      final upload = reference.putFile(image!);
      upload.whenComplete(() {
        print("Upload realizado com sucesso.");
        Navigator.of(context).pushNamedAndRemoveUntil(RoutePaths.ALBUM_LIST_SCREEN, (route) => false);
      });
      upload.catchError((error, stackTrace) {
        print("Upload falhou: $error");
      });
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Alteração de imagem de álbum")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              Text("Alterando imagem do álbum id ${albumSelecionado.id}"),
              image == null?
              Image.network(albumSelecionado.thumbnailUrl):
              Image.file(image!),
              const Text("Imagem atual"),
              Center(child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
                const SizedBox(width: 5,),
                ElevatedButton(onPressed: () => alterarImagem(), child: const Text("Alterar")),
                const SizedBox(width: 5,),
                ElevatedButton(onPressed: () => salvarImagem(), child: const Text("Salvar"))
              ],)
              )
            ],
          ),
        ),
      ),
    );
  }
}
