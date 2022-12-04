import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mygoodtrip/pages/Eventos/eventos_list.dart';
import 'package:mygoodtrip/repository/eventos_repository.dart';
import 'package:mygoodtrip/repository/viagens_repository.dart';
import 'package:mygoodtrip/utils/dialogs.dart';

class ViagemWidget extends StatefulWidget {
  Map? map;
  Function getViagens;

  ViagemWidget({super.key, this.map, required this.getViagens});

  @override
  State<ViagemWidget> createState() => _ViagemWidgetState();
}


class _ViagemWidgetState extends State<ViagemWidget> {
  @override
  Widget build(BuildContext context) {
    Map? map = widget.map;
    Argumentos argumento = Argumentos(widget.map!['id']);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
        MaterialPageRoute(builder: (context) => EventosList(idViagem: widget.map!['id'],),));

      },
      onLongPress: () {
        //open a dilog for delete
        Dialogs.showConfirmDialog(context, 'Deseja realmente excluir a viagem?',
            () async {
          ViagensRepository viagensRepository = ViagensRepository();
          await viagensRepository.deleteViagens(widget.map!['id']);
          widget.getViagens();
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0),
        child: Container(
          height: height * 0.18,
          decoration: const BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Color.fromARGB(255, 92, 225, 230),
                  blurRadius: 3.0,
                  offset: Offset(0.0, 0.75))
            ],
            borderRadius: BorderRadius.all(Radius.circular(50)),
            color: Color.fromARGB(255, 0, 74, 173),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: width * 0.4,
                        height: height * 0.2,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/logo.png'),
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: height * 0.1),
                          Expanded(
                            child: Center(
                              child: AutoSizeText(
                                'Viagem para ${map?['destino']}',
                                maxLines: 1,
                                presetFontSizes: [25, 20, 14],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                minFontSize: 5,
                                maxFontSize: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Data de ida: ${map?['dataInicio']}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Data de volta: ${map?['dataFim']}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Valor estipulado: R\$ ${map?['orcamento']}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Valor já gasto: R\$ 120.00 ',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class Argumentos {
  int? idViagem;
  Argumentos(this.idViagem);
}