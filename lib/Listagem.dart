import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

///Implementação da classe usuário com seus (definição de atributos
///e métodos necessários para o App.
class Usuario extends Comparable<Usuario> {
  String id;
  String email;
  String nome;
  String senha;

  ///Construtor da classe
  Usuario();

  ///Sobrescrição do método para customizar a conversão de um objeto desta
  ///classe para String
  @override
  String toString() {
    return '${this.email}';
  }

  ///Compara dois pares de palavras.
  ///Retorna:
  ///-1 se [a] for menor que [b];
  ///0 se [a] for igual [b];
  ///1 se [a] for maior que [b];
  @override
  int compareTo(Usuario that) {
    int result = this.nome.toLowerCase().compareTo(that.nome.toLowerCase());
    return result;
  }

  ///Converte um objeto JSON para um objeto do tipo [Usuario].
  Usuario.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    email = json['email'];
    nome = json['nome'];
    senha = json['senha'];
  }

  ///Converte um objeto JSON para um objeto do tipo [Usuario].
  Map<String, dynamic> toJson() => {
        'email': email,
        'nome': nome,
        'senha': senha,
      };
}

///Controlador do módulo de usuarios.
class UsuarioController {
  ///CollectionReference -> Objeto usado para adicionar documentos, pegar a referência
  ///de um documento e consultar documentos
  CollectionReference<Map<String, dynamic>> _users;

  ///Construtor da classe.
  UsuarioController() {
    _initListagem();
  }

  ///Inicializa a lista com os usuarios.
  void _initListagem() {
    /// Define um CollectionReference (users) que faz referência à coleção
    /// firestore.
    _users = FirebaseFirestore.instance.collection('usuarios');
  }

  ///Cria um usuário a partir do snapshot (visão momentânea do banco de dados)
  ///do documento.
  Usuario _criarUsuario(DocumentSnapshot<Map<String, dynamic>> e) {
    Usuario result = Usuario.fromJson(e.data());
    result.id = e.id;
    return result;
  }

  ///Retorna uma lista com todos os pares de palavras cadastrados.
  ///Esta lista não pode ser modificada. Ou seja, não é possível inserir ou
  ///remover elementos diretamente na lista.
  Future<Iterable<Usuario>> getAll() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _users.get();
    return snapshot.docs.map((e) => _criarUsuario(e));
  }

  ///Retorna o par de palavras pelo [id], ou [null] caso não exista nenhum par
  ///com o [id] informado.
  Future<Usuario> getById(String id) async {
    if (id == null) return null;

    DocumentSnapshot doc = await _users.doc(id).get();
    return _criarUsuario(doc);
  }

  ///Retorna uma lista de pares de palavras, onde os elementos da lista respeitam
  ///a condição representada pela função passada como parâmetro. Caso a função
  ///passada seja [null], retorna todos os elementos.
  Future<Iterable<Usuario>> getByFilter() async {
    Iterable<Usuario> result = await getAll();
    return List.unmodifiable(result);
  }

  Future delete(Usuario lista) {
    return _users.doc(lista.id).delete();
  }
}

void _showMessage(BuildContext context, String text) {
  final snackBar = SnackBar(
    content: Text(text),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

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
              color: Colors.green,
              fontSize: 16.0,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    ),
  );
}

///Página inicial que apresenta o [BottomNavigationBar], onde cada
///[BottomNavigationBarItem] é uma página do tipo [WordPairListPage].
class ListagemUsuarios extends StatefulWidget {
  ///Nome da rota referente à página Home.
  static const routeName = 'usuarios';

  ///Cria o estado da página Home.
  @override
  _ListagemUsuariosState createState() => _ListagemUsuariosState();
}

///O estado equivalente ao [StatefulWidget] [HomePage].
class _ListagemUsuariosState extends State<ListagemUsuarios> {
  ///Constroi a tela do [HomePage], incluindo um [BottomNavigationBar]
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DSI App (BSI UFRPE)'),
      ),
      body: UsuariosLista(),
    );
  }
}

///Página que apresenta a listagem de palavras.
class UsuariosLista extends StatefulWidget {
  ///Construtor da classe
  UsuariosLista();

  ///Método responsável por criar o objeto estado.
  @override
  _UsuariosListaState createState() => _UsuariosListaState();
}

///Esta classe é o estado da classe [WordPairListPage].
class _UsuariosListaState extends State<UsuariosLista> {
  ///Método getter para retornar os itens. Os itens são ordenados utilizando a
  ///ordenação definida na classe [DSIWordPair].
  /// https://dart.dev/guides/language/language-tour#getters-and-setters
  Future<Iterable<Usuario>> get items {
    FutureOr<Iterable<Usuario>> result;
    result = UsuarioController().getAll();

    return result;
  }

  ///Constroi a listagem de itens.
  ///Note que é dobrada a quantidade de itens, para que a cada índice par, se
  ///inclua um separador ([Divider]) na listagem.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: items,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _buildError(context);
        }

        if (snapshot.connectionState == ConnectionState.done) {
          var wordPairs = snapshot.data;
          return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: wordPairs.length * 2,
              itemBuilder: (BuildContext _context, int i) {
                if (i.isOdd) {
                  return Divider();
                }
                final int index = i ~/ 2;
                return _buildRow(
                    context, index + 1, wordPairs.elementAt(index));
              });
        }

        return _buildLoading(context);
      },
    );
  }

  ///Constroi uma linha da listagem a partir do par de palavras e do índice.
  Widget _buildRow(BuildContext context, int index, Usuario user) {
    return Dismissible(
      key: Key(user.toString()),
      background: Container(
          color: Colors.red,
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.delete,
                color: Colors.white,
              )
            ],
          )),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        setState(() {
          UsuarioController().delete(user).then((value) {
            _showMessage(context, 'A operação foi realizada com sucesso.');
            setState(() {});
          }).onError((error, stackTrace) {
            _showMessage(context, 'A operação não foi realizada.');
          });
        });
      },
      confirmDismiss: (DismissDirection direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Confirmação"),
              content: const Text("Tem certeza que deseja deletar esse item?"),
              actions: <Widget>[
                TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text("Sim")),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("Não"),
                ),
              ],
            );
          },
        );
      },
      child: ListTile(
        title: Text('$index. ${(user)}'),
        //onTap: () => _updateWordPair(context, wordPair),
      ),
    );
  }
}
