import 'package:app_crud/Inicio.dart';
import 'package:app_crud/Rotas.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
      home: Inicio(),
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              color: Color(0xFFEF5350)
          )
      ),
      initialRoute: "/",
      onGenerateRoute: Rotas.generateRoute,
      debugShowCheckedModeBanner: false
  ));
}