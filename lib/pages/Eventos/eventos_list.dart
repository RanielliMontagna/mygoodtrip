import 'package:flutter/material.dart';
import 'package:flutter_timeline/flutter_timeline.dart';
import 'package:flutter_timeline/timeline.dart';
import 'package:flutter_timeline/timeline_theme.dart';
import 'package:flutter_timeline/timeline_theme_data.dart';
import 'package:mygoodtrip/pages/Eventos/create_evento.dart';
import 'package:mygoodtrip/pages/Viagens/viagem_widget.dart';
import 'package:mygoodtrip/repository/eventos_repository.dart';
import 'package:mygoodtrip/repository/viagens_repository.dart';
import 'package:mygoodtrip/utils/dialogs.dart';

class EventosList extends StatefulWidget {
  final int? idViagem;
  const EventosList({super.key, this.idViagem});
  @override
  State<EventosList> createState() => _EventosListState();
}

class _EventosListState extends State<EventosList> {
  late List<Map?> viagem;
  List<TimelineEventDisplay> events = [];

  void getViagens() async {
    List<Map?>? map = await ViagensRepository.getViagem(widget.idViagem);
    setState(() {
      viagem = map ?? [];
      print(viagem);
    });
  }

  getEventos() async {
    List<Map?>? map = await EventosRepository.getEventos(widget.idViagem);
    print(map);
    setState(() {
      events.clear();
      for (var element in map!) {
        print(element);
        events.add(TimelineEventDisplay(
            child: GestureDetector(
              child: TimelineEventCard(
                title: Text(element!['descricao']),
                content: Text("Pagamento de ${element['valor']} no ${element['modoPagamento']}"),
              ),
              onLongPress: () {
                Dialogs.showConfirmDialog(context, 'Deseja realmente excluir o evento?', () async {
                  ViagensRepository viagensRepository = ViagensRepository();
                  await EventosRepository.deleteEventos(element['id']);
                  getEventos();
                });
              },
            ),
            indicator: TimelineDots.of(context).circleIcon));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getViagens();
    events.clear;
    getEventos();
  }

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) {
      events.add(TimelineEventDisplay(
          child: TimelineEventCard(
            title: Text("Criação da Viagem"),
            content: Text("Criação da Viagem para ${viagem[0]!['destino']}"),
          ),
          indicator: TimelineDots.of(context).circleIcon));
    }
    ;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eventos'),
        backgroundColor: const Color.fromARGB(255, 0, 74, 173),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.01,
              ),
              Card(
                child: SizedBox(
                  height: height * 0.15,
                  width: width * 0.9,
                  child: Column(
                    children: [
                      Text(
                        viagem[0]!['destino'].toString(),
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: height * 0.005,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: width * 0.03,
                          ),
                          Text("Data de ida:"),
                          SizedBox(
                            width: width * 0.01,
                          ),
                          Text(viagem[0]!['dataInicio'].toString()),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: width * 0.03,
                          ),
                          Text("Data de volta:"),
                          SizedBox(
                            width: width * 0.01,
                          ),
                          Text(viagem[0]!['dataFim'].toString()),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: width * 0.03,
                          ),
                          Text("Orçamento:"),
                          SizedBox(
                            width: width * 0.01,
                          ),
                          Text('R\$${viagem[0]!['orcamento'].toString()}'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 0.02,
              ),
              Card(
                child: Expanded(
                  child: SizedBox(
                    width: width * 0.9,
                    child: Column(
                      children: [
                        TimelineTheme(
                          data: TimelineThemeData(lineColor: Colors.blueAccent),
                          child: Timeline(
                            indicatorSize: 56,
                            events: events,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
        MaterialPageRoute(builder: (context) => CreateEvento(idViagem: viagem[0]!['id']),));
          getEventos();
        },
        backgroundColor: Colors.blue[800],
        child: const Icon(Icons.add),
      ),
    );
  }
}
