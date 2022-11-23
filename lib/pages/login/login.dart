import 'package:flutter/material.dart';
import 'package:mygoodtrip/components/button.dart';
import 'package:mygoodtrip/components/field.dart';
import 'package:mygoodtrip/utils/prefs.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController name = TextEditingController();

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
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    //logo with radius
                    Container(
                      width: 200,
                      height: 200,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/logo.png'),
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(height: 24),
                    //field nome with label style and border
                    Field(
                        label: 'Nome completo',
                        hint: 'Digite seu nome',
                        controller: name),
                    const SizedBox(height: 24),
                    Button(
                      text: 'Entrar',
                      onPressed: () async {
                        await setPrefsString('name', name.text).then(
                          (value) => {
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/dashboard', (route) => false)
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    Button(
                        text: 'Voltar',
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: Colors.grey.shade200,
                        textColor: Colors.black),
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
