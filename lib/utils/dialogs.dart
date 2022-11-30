import 'package:flutter/material.dart';

class Dialogs {
  static showAlertDialog(BuildContext context, String mensagem) {
    // configura o button
    Widget okButton = ElevatedButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // configura o AlertDialog
    AlertDialog alerta = AlertDialog(
      title: const Text("Alerta"),
      content: Text(mensagem),
      actions: [
        okButton,
      ],
    );
    // exibe o dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

  static showConfirmDialog(
      BuildContext context, String mensagem, Function simFunction) {
    Widget naoButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey,
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
      child: const Text("Cancelar"),
    );
    Widget simButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
        simFunction();
      },
      child: const Text("Confirmar"),
    );
    //configura o AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Confirmação"),
      content: Text(mensagem),
      actions: [
        simButton,
        naoButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
