import 'package:flutter/cupertino.dart';
import 'package:mygoodtrip/pages/Eventos/create_evento.dart';
import 'package:mygoodtrip/pages/Eventos/eventos_list.dart';
import 'package:mygoodtrip/pages/Viagens/create_viagem.dart';
import 'package:mygoodtrip/pages/Viagens/list_viagens.dart';
import 'package:mygoodtrip/pages/dashboard/dashboard.dart';
import 'package:mygoodtrip/pages/intro/intro.dart';
import 'package:mygoodtrip/pages/login/login.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return CupertinoPageRoute(builder: (_) => const Login());
      case '/dashboard':
        return CupertinoPageRoute(builder: (_) => const Dashboard());
      case '/intro':
        return CupertinoPageRoute(builder: (_) => const Intro());
      case '/viagens':
        return CupertinoPageRoute(builder: (_) => ListViagens());
      case '/createViagem':
        return CupertinoPageRoute(builder: (_) => const CreateViagem());
      // case '/createEvento':
      //   return CupertinoPageRoute(builder: (_) => const CreateEvento());
      default:
        return CupertinoPageRoute(builder: (_) => const Intro());
    }
  }
}
