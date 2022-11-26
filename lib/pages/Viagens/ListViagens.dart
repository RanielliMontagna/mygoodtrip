import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mygoodtrip/pages/Viagens/ViagemWidget.dart';
import 'package:mygoodtrip/repository/viagens_repository.dart';

class ListViagens extends StatefulWidget {
  ListViagens({super.key});

  String title = 'Viagem';
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
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Color.fromARGB(255, 0, 74, 173),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.01,
                ),
                const Text(
                  'Viagens',
                  style: TextStyle(fontSize: 40, color: Colors.white),
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
                          child: CircularProgressIndicator(color: Colors.white),
                        );
                      } else {
                        return CarouselSlider.builder(
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) => ViagemWidget(map: data[itemIndex]),
                          options: CarouselOptions(
                            height: height * 0.5,
                            enableInfiniteScroll: false,
                            disableCenter: false,
                            viewportFraction: 0.8,
                            enlargeCenterPage: true,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
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
    );
  }
}
