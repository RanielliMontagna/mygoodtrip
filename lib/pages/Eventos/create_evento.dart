import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';
import 'package:mygoodtrip/components/button.dart';
import 'package:mygoodtrip/repository/eventos_repository.dart';
import 'package:mygoodtrip/repository/viagens_repository.dart';

class CreateEvento extends StatefulWidget {
  final int? idViagem;
  const CreateEvento({super.key, required this.idViagem});

  @override
  State<CreateEvento> createState() => _CreateViagemState();
}

class _CreateViagemState extends State<CreateEvento> {
  String? descricao;
  List<String> modosPagamentos = [
    'Cartão de crédito',
    'cartão de débito',
    'PIX',
    'Dinheiro vivo'
  ];
  String? modoPagamento;
  String? valor;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Evento'),
        backgroundColor: const Color.fromARGB(255, 0, 74, 173),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Form(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: height * 0.05,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      '   Preencha os campos para \ncriação de um novo evento',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.05,
                                ),
                                TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      descricao = value;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                      labelText: 'Descrição',
                                      hintText: 'Aluguel Airbnb',
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.all(2),
                                        child: Icon(Icons.add_location_alt),
                                      )),
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      valor = value;
                                    });
                                  },
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    CurrencyInputFormatter(),
                                  ],
                                  decoration: const InputDecoration(
                                      labelText: 'Valor',
                                      hintText: 'R\$ 500,00',
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.all(2),
                                        child: Icon(Icons.attach_money),
                                      )),
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Column(
                                  children: [
                                    DropdownButton<String>(
                                      isExpanded: true,
                                      value: modoPagamento ??
                                          modosPagamentos.first,
                                      icon: const Icon(Icons.arrow_downward),
                                      elevation: 16,
                                      style:
                                          const TextStyle(color: Colors.black),
                                      underline: Container(
                                        height: 2,
                                        color: Colors.blue,
                                      ),
                                      onChanged: (String? value) {
                                        // This is called when the user selects an item.
                                        setState(() {
                                          modoPagamento = value!;
                                        });
                                      },
                                      items: modosPagamentos
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.10,
                                ),
                                Button(
                                  text: 'Salvar Evento',
                                  onPressed: () {
                                    var evento = {};
                                    evento['descricao'] = descricao;
                                    evento['viagem'] = widget.idViagem;
                                    evento['valor'] = valor;
                                    evento['data'] =
                                        DateFormat('dd/MM/yyyy HH:mm')
                                            .format(DateTime.now());
                                    evento['modoPagamento'] =
                                        modoPagamento ?? modosPagamentos.first;
                                    EventosRepository.insertEventos(evento);
                                    Navigator.of(context).pop();
                                  },
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                InkWell(
                                  child: const Text(
                                    'Voltar',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    double value = double.parse(newValue.text);

    final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");

    String newText = formatter.format(value / 100);

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}
