import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mygoodtrip/pages/Viagens/viagem_widget.dart';
import 'package:mygoodtrip/repository/viagens_repository.dart';

class ListViagens extends StatefulWidget {
  ListViagens({super.key});

  String title = 'Viagem';

  @override
  State<ListViagens> createState() => _ListViagensState();
}

class _ListViagensState extends State<ListViagens> {
  List viagens = [];

  void getViagens() async {
    List<Map?>? map = await ViagensRepository.getViagens();
    setState(() {
      viagens = map ?? [];
    });
  }

  @override
  void initState() {
    super.initState();
    getViagens();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color.fromARGB(255, 0, 74, 173),
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
                    child: viagens.isNotEmpty
                        ? CarouselSlider.builder(
                            itemCount: viagens.length,
                            itemBuilder: (BuildContext context, int itemIndex,
                                    int pageViewIndex) =>
                                ViagemWidget(
                                    map: viagens[itemIndex],
                                    getViagens: getViagens),
                            options: CarouselOptions(
                              height: height * 0.5,
                              enableInfiniteScroll: false,
                              disableCenter: false,
                              viewportFraction: 0.8,
                              enlargeCenterPage: true,
                            ),
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          )),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).pushNamed('/createViagem') as String?;
          getViagens();
        },
        backgroundColor: Colors.blue[800],
        child: const Icon(Icons.add),
      ),
    );
  }
}
