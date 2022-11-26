import 'package:flutter/material.dart';
import 'package:mygoodtrip/pages/Viagens/ListViagens.dart';
import 'package:mygoodtrip/pages/dashboard/Home.dart';
import 'package:mygoodtrip/repository/viagens_repository.dart';
import 'package:mygoodtrip/shared/routes.dart';
import 'package:mygoodtrip/utils/prefs.dart';
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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return MaterialApp(
      onGenerateRoute: RouteGenerator.generateRoute,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 0, 74, 173),
            title: Text("Home"),
          ),
          bottomNavigationBar: menu(),
          body: Container(
            color: Colors.white,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: TabBarView(
                children: [
                  Container(
                    child: Home(
                      name: name!,
                    ),
                  ),
                  Container(child: ListViagens()),
                  Container(child: Icon(Icons.directions_bike)),
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
    color: Color.fromARGB(255, 0, 74, 173),
    child: TabBar(
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
