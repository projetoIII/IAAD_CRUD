import 'package:app_crud/Rotas.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Login"),
        ),
        body: Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                      autofocus: true,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          labelText: "E-mail",
                          hintText: "fulano@email.com",
                      )
                  ),
                  TextFormField(
                      autofocus: true,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          labelText: "Senha",
                          hintText: "Insira a senha",
                      )
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Rotas.ROTA_USUARIOS);
                    },
                    child: const Text("Entrar"),
                  ),
                ],
              ),
            )
        ));
  }
}
