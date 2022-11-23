import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mygoodtrip/shared/routes.dart';
import 'package:mygoodtrip/utils/prefs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final name = await getPrefsString('name');

  runApp(MyApp(isLogged: name != ''));
}

class MyApp extends StatelessWidget {
  final bool isLogged;

  const MyApp({
    super.key,
    required this.isLogged,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
      statusBarBrightness: Brightness.light, // For iOS (dark icons)
    ));

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
        title: 'My Good Trip',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
        ),
        initialRoute: isLogged ? '/dashboard' : '/intro',
        onGenerateRoute: RouteGenerator.generateRoute);
  }
}
