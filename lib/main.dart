import 'package:entrega_flutter_2/providers/album_provider.dart';
import 'package:entrega_flutter_2/routes/RoutePaths.dart';
import 'package:entrega_flutter_2/screens/album_create_screen.dart';
import 'package:entrega_flutter_2/screens/list_album_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const Aplicativo());
}

class Aplicativo extends StatelessWidget {
  const Aplicativo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => AlbumProvider(),
    child: MaterialApp(
      title: "Lista de Albuns",
      debugShowCheckedModeBanner: false,
      routes: {
        RoutePaths.ALBUM_LIST_SCREEN: (context) => AlbumListScreen(),
        RoutePaths.ALBUM_CREATE_SCREEN: (context) => const AlbumCreateScreen()
      },
    ),
    );
  }
}
