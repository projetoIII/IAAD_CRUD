import 'package:app_crud/Cadastro.dart';
import 'package:app_crud/Inicio.dart';
import 'package:app_crud/ListaUsuarios.dart';
import 'package:app_crud/Login.dart';
import 'package:flutter/material.dart';

class Rotas {

  static const String ROTA_INICIO = "/inicio";
  static const String ROTA_LOGIN = "/login";
  static const String ROTA_CADASTRO = "/cadastro";
  static const String ROTA_USUARIOS = "/usuarios";

  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch(settings.name){
      case ROTA_INICIO:
        return MaterialPageRoute(
            builder: (_) => Inicio()
        );
      case ROTA_LOGIN:
        return MaterialPageRoute(
            builder: (_) => Login()
        );
      case ROTA_CADASTRO:
        return MaterialPageRoute(
            builder: (_) => Cadastro()
        );
      case ROTA_USUARIOS:
        return MaterialPageRoute(
            builder: (_) => ListaUsuarios()
        );
      default:
        return MaterialPageRoute(
            builder: (_) => Inicio()
        );
    }

  }

}