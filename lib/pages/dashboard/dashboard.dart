import 'package:flutter/material.dart';
import 'package:mygoodtrip/pages/Viagens/list_viagens.dart';
import 'package:mygoodtrip/pages/dashboard/home.dart';
import 'package:mygoodtrip/shared/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
  void onLoad(BuildContext context) {}
}

Future<dynamic> _getPrefs() async {
  var prefs = await SharedPreferences.getInstance();
  return prefs;
}

class _DashboardState extends State<Dashboard> {
  String? name;

  @override
  void initState() {
    super.initState();
    widget.onLoad(context);
    _getPrefs();
    SharedPreferences.getInstance().then((prefs) {
      setState(() => prefs = prefs);
      setState(() {
        name = prefs.getString('name');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: RouteGenerator.generateRoute,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 0, 74, 173),
            elevation: 0,
            toolbarHeight: 0,
          ),
          bottomNavigationBar: menu(),
          body: Container(
            color: Colors.white,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Home(
                    name: name ?? '',
                  ),
                  ListViagens(),
                  const Icon(Icons.directions_bike),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget menu() {
  return Container(
    color: const Color.fromARGB(255, 0, 74, 173),
    child: const TabBar(
      physics: NeverScrollableScrollPhysics(),
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white70,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorPadding: EdgeInsets.all(5.0),
      indicatorColor: Colors.blue,
      tabs: [
        Tab(
          text: "Home",
          icon: Icon(Icons.home),
        ),
        Tab(
          text: "Viagens",
          icon: Icon(Icons.wallet_travel),
        ),
        Tab(
          text: "Relatórios",
          icon: Icon(Icons.insert_chart_outlined_outlined),
        ),
      ],
    ),
  );
}
