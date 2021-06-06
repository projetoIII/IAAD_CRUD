import 'package:flutter/material.dart';

class AtualizarCadastro extends StatefulWidget {
  static const routeName = '/wordpair/update';

  ///Construtor da classe
  AtualizarCadastro();

  ///Cria o estado da página de atualização de palavras.
  @override
  _AtualizarCadastroState createState() => _AtualizarCadastroState();
}

///Esta classe é o estado da classe que atualiza os pares de palavras.
class _AtualizarCadastroState extends State<AtualizarCadastro> {
  final _formKey = GlobalKey<FormState>();

  ////DSIWordPairController _controller = DSIWordPairController();
  //DSIWordPair _wordPair;
  String _newFirst;
  String _newSecond;

  ///Método responsável por criar a tela de atualização do par de palavras.
  @override
  Widget build(BuildContext context) {
    //_wordPair = ModalRoute.of(context).settings.arguments;
    //if (_wordPair == null) {
    //_wordPair = DSIWordPair();
    //}
    return Scaffold(
      appBar: AppBar(
        title: Text('DSI App (BSI UFRPE)'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(30, 0, 30, 80),
          child: _buildForm(context),
        ),
      ),
    );
  }

  ///Método utilizado para criar o corpo da tela de atualização do par de palavras.
  _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Wrap(
        alignment: WrapAlignment.center,
        runSpacing: 16.0,
        children: <Widget>[
          TextFormField(
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: 'Nome',
            ),
            validator: (String value) {
              return value.isEmpty ? 'Palavra inválida.' : null;
            },
            onSaved: (newValue) => _newFirst = newValue,
            //initialValue: _wordPair.first,
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: 'Email',
            ),
            validator: (String value) {
              return value.isEmpty ? 'Palavra inválida.' : null;
            },
            onSaved: (newValue) => _newSecond = newValue,
            //initialValue: _wordPair.second,
          ),
          TextFormField(
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Senha',
              ),
              validator: (String value) {
                return value.isEmpty ? 'Palavra inválida.' : null;
              },
              onSaved: (newValue) => _newSecond = newValue,
              obscureText: true
              //initialValue: _wordPair.second,
              ),
          SizedBox(
            width: double.infinity,
          ),
          //ElevatedButton(
          //child: Text('Salvar'),
          //style: ButtonStyle(
          //shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          //RoundedRectangleBorder(
          //borderRadius: BorderRadius.circular(18.0),
          //),
          //),
          //),
          //onPressed: print('Hi'),
          //),
        ],
      ),
    );
  }
}
