import 'package:entrega_flutter_2/providers/album_provider.dart';
import 'package:entrega_flutter_2/routes/RoutePaths.dart';
import 'package:entrega_flutter_2/screens/album_thumbchange_screen.dart';
import 'package:entrega_flutter_2/screens/list_album_screen.dart';
import 'package:entrega_flutter_2/screens/sign_in_screen.dart';
import 'package:entrega_flutter_2/screens/teste.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        RoutePaths.SIGN_IN_SCREEN: (context) => const SignInScreen(),
        RoutePaths.ALBUM_LIST_SCREEN: (context) => const AlbumListScreen(),
        RoutePaths.ALBUM_THUMBCHANGE_SCREEN: (context) => const ThumbChangeScreen(),
        RoutePaths.TESTE_SCREEN: (context) => Teste()
      },
    ),
    );
  }
}
