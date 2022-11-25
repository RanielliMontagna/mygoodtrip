import 'package:flutter/cupertino.dart';
import 'package:mygoodtrip/pages/Viagens/CreateViagem.dart';
import 'package:mygoodtrip/pages/Viagens/ListViagens.dart';
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
      default:
        return CupertinoPageRoute(builder: (_) => const Intro());
    }
  }
}
