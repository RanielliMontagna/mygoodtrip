import 'package:flutter/material.dart';
import 'package:mygoodtrip/pages/Viagens/ViagemWidget.dart';
import 'package:mygoodtrip/repository/viagens_repository.dart';

class ListViagens extends StatefulWidget {
  ListViagens({super.key});
  @override
  State<ListViagens> createState() => _ListViagensState();
}

Future<List<Map?>?> getViagens() async {
  List<Map?>? map = await ViagensRepository.getViagens();
  return map;
}

class _ListViagensState extends State<ListViagens> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.01,
                ),
                const Text(
                  'Viagens',
                  style: TextStyle(fontSize: 40),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Expanded(
                  child: FutureBuilder(
                    future: getViagens(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      List<Map?>? data = snapshot.data;
                      if (data == null) {
                        return const Center(
                          child: CircularProgressIndicator(color: Color(0xFF303349)),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: data.length,
                          padding: const EdgeInsets.all(8),
                          itemBuilder: (context, index) => ViagemWidget(map: data[index]),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/createViagem');
          },
          backgroundColor: Colors.blue[800],
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
