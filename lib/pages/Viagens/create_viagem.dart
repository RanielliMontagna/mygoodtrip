import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';
import 'package:mygoodtrip/components/button.dart';
import 'package:mygoodtrip/repository/viagens_repository.dart';

class CreateViagem extends StatefulWidget {
  const CreateViagem({super.key});

  @override
  State<CreateViagem> createState() => _CreateViagemState();
}

class _CreateViagemState extends State<CreateViagem> {
  String? dateFinal;
  String? dateInit;
  String? destino;
  String? orcamento;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar viagem'),
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
                                      'Preencha os campos para \ncria????o de uma nova Viagem',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.05,
                                ),
                                TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      destino = value;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                      labelText: 'Destino',
                                      hintText: 'Florian??polis',
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
                                      dateInit = value;
                                    });
                                  },
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    TextInputMask(
                                      mask: '99/99/9999',
                                      reverse: false,
                                    ),
                                  ],
                                  decoration: InputDecoration(
                                    labelText: 'Data ida',
                                    hintText: '01/01/2022',
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: InkWell(
                                        child: const Icon(Icons.date_range),
                                        onTap: () async {
                                          DateTimeRange? period =
                                              await showDateRangePicker(
                                            context: context,
                                            firstDate: DateTime(2022),
                                            lastDate: DateTime(2100),
                                            helpText: 'Selecione um per??odo.',
                                            builder: ((context, child) => Theme(
                                                  data: ThemeData().copyWith(
                                                    colorScheme:
                                                        const ColorScheme.light(
                                                      primary:
                                                          Color(0xFF3F5AA6),
                                                      onPrimary: Colors.white,
                                                    ),
                                                  ),
                                                  child: child!,
                                                )),
                                          );
                                          if (period == null) return;
                                          setState(() {
                                            dateFinal = DateFormat('yyyy-MM-dd')
                                                .format(period.end)
                                                .toString();
                                            dateInit = DateFormat('yyyy-MM-dd')
                                                .format(period.start)
                                                .toString();
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      dateFinal = value;
                                    });
                                  },
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    TextInputMask(
                                      mask: '99/99/9999',
                                      reverse: false,
                                    ),
                                  ],
                                  initialValue: dateFinal,
                                  decoration: InputDecoration(
                                      labelText: 'Data retorno',
                                      hintText: '01/01/2022',
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.all(2),
                                        child: InkWell(
                                          child: const Icon(Icons.date_range),
                                          onTap: () async {
                                            DateTimeRange? period =
                                                await showDateRangePicker(
                                              context: context,
                                              firstDate: DateTime(1900),
                                              lastDate: DateTime(2100),
                                              helpText: 'Selecione um per??odo.',
                                              builder: ((context, child) =>
                                                  Theme(
                                                    data: ThemeData().copyWith(
                                                      colorScheme:
                                                          const ColorScheme
                                                              .light(
                                                        primary:
                                                            Color(0xFF3F5AA6),
                                                        onPrimary: Colors.white,
                                                      ),
                                                    ),
                                                    child: child!,
                                                  )),
                                            );
                                            if (period == null) return;
                                            setState(() {
                                              dateFinal =
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(period.end)
                                                      .toString();
                                              dateInit =
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(period.start)
                                                      .toString();
                                            });
                                          },
                                        ),
                                      )),
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                TextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      orcamento = value;
                                    });
                                  },
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    CurrencyInputFormatter(),
                                  ],
                                  decoration: const InputDecoration(
                                      labelText: 'Valor planejado',
                                      hintText: 'R\$ 2.000,00',
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.all(2),
                                        child: Icon(Icons.attach_money),
                                      )),
                                ),
                                SizedBox(
                                  height: height * 0.10,
                                ),
                                Button(
                                  text: 'Salvar Viagem',
                                  onPressed: () {
                                    var viagem = {};
                                    viagem['destino'] = destino;
                                    viagem['dataInicio'] = dateInit;
                                    viagem['dataFim'] = dateFinal;
                                    viagem['orcamento'] = orcamento
                                        ?.replaceAll('R\$', '')
                                        .replaceAll('.', '')
                                        .replaceAll(',', '.')
                                        .replaceAll(' ', '');
                                    ViagensRepository.insertViagens(viagem);
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
