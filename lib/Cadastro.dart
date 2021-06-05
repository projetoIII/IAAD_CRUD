import 'package:app_crud/Rotas.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'model/Usuario.dart';

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {

  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();

  String _mensagemErro = "";

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  _cadastrarUsuarioAuthentication(Usuario usuario){

    FirebaseAuth auth = FirebaseAuth.instance;

    auth.createUserWithEmailAndPassword(
        email: usuario.email,
        password: usuario.senha
    ).then((firebaseUser){

      //redireciona para a tela principal
      Navigator.pushNamed(context, Rotas.ROTA_LOGIN);


    });

  }

  _validarCampos(){

    //Recuperar dados dos campos
    String nome = _controllerNome.text;
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if(email.isNotEmpty && email.contains("@")){
      if(senha.isNotEmpty && senha.length > 6){

        Usuario usuario = Usuario();
        usuario.nome = nome;
        usuario.email = email;
        usuario.senha = senha;
        //salva na colecao
        CollectionReference<Map<String, dynamic>> _users;
        _users = FirebaseFirestore.instance.collection('usuarios');
        _users.add(
            {
              'nome': nome,
              'email': email,
              'senha': senha,
            }
        );
        //salva o usuário no authentication
        _cadastrarUsuarioAuthentication(usuario);

      }else{
        setState(() {
          _mensagemErro = "A senha deve ter mais de 6 caracteres";
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
          title: Text("Cadastro"),
        ),
        body: Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                      controller: _controllerNome,
                      autofocus: true,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        labelText: "Nome",
                        hintText: "Fulano de Tal",
                      )
                  ),TextFormField(
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
                    onPressed: ()  {
                      _validarCampos();
                    },
                    child: const Text("Cadastrar"),
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
