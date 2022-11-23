import 'package:flutter/material.dart';
import 'package:mygoodtrip/components/button.dart';

class Intro extends StatefulWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  void _onPressed() {
    Navigator.pushNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/intro/car.png',
                      width: 300,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Com o My Good Trip você pode criar uma viagem e planejar tudo o que você precisa, desde o roteiro até o orçamento!',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    Button(text: 'Começar', onPressed: _onPressed)
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
