import 'package:app_crud/Rotas.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:app_crud/model/Usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();

  String _mensagemErro = "";



  _logarUsuario(Usuario usuario){

    FirebaseAuth auth = FirebaseAuth.instance;

    auth.signInWithEmailAndPassword(
        email: usuario.email,
        password: usuario.senha
    ).then((firebaseUser){

      //redireciona para a tela principal
      Navigator.pushNamed(context, Rotas.ROTA_USUARIOS);

    });

  }

  _validarCampos(){
    print('email');
    //Recuperar dados dos campos
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;
    print(email);
    if(email.isNotEmpty && email.contains("@")){
      if(senha.isNotEmpty && senha.length > 6){

        //configura usuario
        Usuario usuario = Usuario();
        usuario.email = email;
        usuario.senha = senha;
        _logarUsuario(usuario);

      }else{
        setState(() {
          _mensagemErro = "Preencha a senha! digite mais de 6 caracteres";
        });
      }
    }else{
      setState(() {
        _mensagemErro = "Preencha o E-mail válido";
      });
    }

  }
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
                      controller: _controllerEmail,
                      autofocus: true,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          labelText: "E-mail",
                          hintText: "fulano@email.com",
                      )
                  ),
                  TextFormField(
                      controller: _controllerSenha,
                      obscureText: true,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          labelText: "Senha",
                          hintText: "Insira a senha",
                      )
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _validarCampos();
                    },
                    child: const Text("Entrar"),
                  ),
                  Padding(padding:  EdgeInsets.only(top: 20),
                    child: Text(_mensagemErro, style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red
                    ),
                    ),
                  ),
                ],
              ),
            )
        ));
  }
}
