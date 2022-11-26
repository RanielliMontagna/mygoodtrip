import 'package:flutter/material.dart';

class EventosList extends StatefulWidget {
  const EventosList({super.key});

  @override
  State<EventosList> createState() => _EventosListState();
}

class _EventosListState extends State<EventosList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eventos'),
        backgroundColor: Color.fromARGB(255, 0, 74, 173),
      ),
    );
  }
}
