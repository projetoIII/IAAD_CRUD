import 'package:app_crud/Rotas.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Listagem.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(DadosApp());
}

///Classe principal que representa o App.
///O uso do widget do tipo Stateful evita a reinicialização do Firebase
///cada vez que o App é reconstruído.
class DadosApp extends StatefulWidget {
  ///Cria o estado do app.
  @override
  _DadosAppState createState() => _DadosAppState();
}

///O estado do app.
class _DadosAppState extends State<DadosApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  ///Constrói o App a partir do FutureBuilder, após o carregamento do Firebase.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _buildError(context);
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return _buildApp(context);
        }

        return _buildLoading(context);
      },
    );
  }

  ///Constroi o componente que apresenta o erro no carregamento do Firebase.
  Widget _buildError(context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Center(
        child: Text(
          'Erro ao carregar os dados do App.\n'
          'Tente novamente mais tarde.',
          style: TextStyle(
            color: Colors.red,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  ///Constrói o componente de load.
  Widget _buildLoading(context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Center(
        child: Row(
          children: <Widget>[
            CircularProgressIndicator(),
            Text(
              'carregando...',
              style: TextStyle(
                color: Colors.red,
                fontSize: 16.0,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///Constrói o App e suas configurações.
  Widget _buildApp(context) {
    return MaterialApp(
        home: HomePage(),
        theme: ThemeData(appBarTheme: AppBarTheme(color: Color(0xFFEF5350))),
        initialRoute: "/",
        onGenerateRoute: Rotas.generateRoute,
        debugShowCheckedModeBanner: false);
  }
}
