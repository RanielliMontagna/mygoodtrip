import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final String name;
  Home({super.key, required this.name});

  String title = 'Home';
  @override
  State<Home> createState() => _HomeState();
  void onLoad(BuildContext context) {}
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    String? nome = widget.name;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Container(
        color: const Color.fromARGB(255, 0, 74, 173),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.1,
                    ),
                    Container(
                      width: width * 0.8,
                      height: height * 0.4,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/logo.png'),
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Bem vindo ${nome}! ",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
