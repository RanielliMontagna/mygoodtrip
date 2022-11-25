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
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar viagem'),
        backgroundColor: Color(0xFF3F5AA6),
      ),
      body: SafeArea(
        child: Container(
          color: Color(0xFF3F5AA6),
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
                                  children: [
                                    Text(
                                      '   Preencha os campos para \ncriação de uma nova Viagem',
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                                  decoration: InputDecoration(
                                      labelText: 'Destino',
                                      hintText: 'Florianópolis',
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
                                      padding: EdgeInsets.all(2),
                                      child: InkWell(
                                        child: Icon(Icons.date_range),
                                        onTap: () async {
                                          DateTimeRange? period = await showDateRangePicker(
                                            context: context,
                                            firstDate: DateTime(2022),
                                            lastDate: DateTime(2100),
                                            helpText: 'Selecione um período.',
                                            builder: ((context, child) => Theme(
                                                  data: ThemeData().copyWith(
                                                    colorScheme: ColorScheme.light(
                                                      primary: Color(0xFF3F5AA6),
                                                      onPrimary: Colors.white,
                                                    ),
                                                  ),
                                                  child: child!,
                                                )),
                                          );
                                          if (period == null) return;
                                          setState(() {
                                            dateFinal = DateFormat('yyyy-MM-dd').format(period.end).toString();
                                            dateInit = DateFormat('yyyy-MM-dd').format(period.start).toString();
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
                                  initialValue: dateFinal ?? null,
                                  decoration: InputDecoration(
                                      labelText: 'Data retorno',
                                      hintText: '01/01/2022',
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.all(2),
                                        child: InkWell(
                                          child: Icon(Icons.date_range),
                                          onTap: () async {
                                            DateTimeRange? period = await showDateRangePicker(
                                              context: context,
                                              firstDate: DateTime(1900),
                                              lastDate: DateTime(2100),
                                              helpText: 'Selecione um período.',
                                              builder: ((context, child) => Theme(
                                                    data: ThemeData().copyWith(
                                                      colorScheme: ColorScheme.light(
                                                        primary: Color(0xFF3F5AA6),
                                                        onPrimary: Colors.white,
                                                      ),
                                                    ),
                                                    child: child!,
                                                  )),
                                            );
                                            if (period == null) return;
                                            setState(() {
                                              dateFinal = DateFormat('yyyy-MM-dd').format(period.end).toString();
                                              dateInit = DateFormat('yyyy-MM-dd').format(period.start).toString();
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
                                  decoration: InputDecoration(
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
                                    var viagem = Map();
                                    viagem['destino'] = destino;
                                    viagem['dataInicio'] = dateInit;
                                    viagem['dataFim'] = dateFinal;
                                    viagem['orcamento'] = orcamento?.replaceAll('R\$', '').replaceAll('.', '').replaceAll(',', '.').replaceAll(' ', '');
                                    print(viagem);
                                    ViagensRepository.insertViagens(viagem);

                                    Navigator.of(context).pop();
                                  },
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                InkWell(
                                  child: Text(
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
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    double value = double.parse(newValue.text);

    final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");

    String newText = formatter.format(value / 100);

    return newValue.copyWith(text: newText, selection: TextSelection.collapsed(offset: newText.length));
  }
}
