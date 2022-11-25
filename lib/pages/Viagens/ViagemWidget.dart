import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ViagemWidget extends StatefulWidget {
  Map? map;
  ViagemWidget({super.key, this.map});

  @override
  State<ViagemWidget> createState() => _ViagemWidgetState();
}

class _ViagemWidgetState extends State<ViagemWidget> {
  @override
  Widget build(BuildContext context) {
    Map? map = widget.map;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/createViagem',
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Slidable(
          actionPane: const SlidableBehindActionPane(),
          actionExtentRatio: 0.25,
          secondaryActions: [
            IconSlideAction(
              caption: 'Excluir',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () {},
            ),
          ],
          child: Container(
            height: height * 0.18,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: Colors.grey[300],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Viagem para ${map?['destino']}',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            'Data de ida: ${map?['dataInicio']}',
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Data de volta: ${map?['dataFim']}',
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Valor estipulado: R\$ ${map?['orcamento']}',
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Valor já gasto: R\$ 120.00 ',
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
