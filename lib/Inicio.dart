import 'package:app_crud/Rotas.dart';
import 'package:flutter/material.dart';

class Inicio extends StatefulWidget {

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Início"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Rotas.ROTA_LOGIN);
                },
                child: const Text('Login'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Rotas.ROTA_CADASTRO);
                },
                child: const Text('Cadastro'),
              ),

            ],
          ),
        )
    );
  }
}