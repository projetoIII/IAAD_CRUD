import 'package:flutter/material.dart';

class ListaUsuarios extends StatefulWidget {
  @override
  _ListaUsuariosState createState() => _ListaUsuariosState();
}

class _ListaUsuariosState extends State<ListaUsuarios> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Usuários"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {

                  showDialog(
                      context: context,
                      builder: (context){
                        return AlertDialog(
                          title: Text("Editar usuário"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              TextField(
                                autofocus: true,
                                decoration: InputDecoration(
                                    labelText: "Nome",
                                    hintText: "Novo nome"
                                ),
                              ),
                              TextField(
                                decoration: InputDecoration(
                                    labelText: "E-mail",
                                    hintText: "Novo e-mail"
                                ),
                              ),
                              TextField(
                                decoration: InputDecoration(
                                    labelText: "Senha",
                                    hintText: "Nova senha"
                                ),
                              )
                            ],
                          ),
                          actions: <Widget>[
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("Cancelar"),
                            ),
                            ElevatedButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              child: Text("Atualizar"),
                            )
                          ],
                        );
                      }
                  );

                },
                child: const Text('aqui'),
              ),

              //não consegui fazer essa lista, mas quando a pessoa que for fzr conseguir
              //adicionar a funcionalidade acima no onPress

              // ListView.builder(
              //     padding: const EdgeInsets.all(16),
              //     // itemCount:
              //     itemBuilder: (BuildContext context, int i) {
              //       return ListTile(
              //         title: Text("Nome do usuario"),
              //         subtitle: Text("E-mail"),
              //       );
              //     })
            ],
          ),
        )
    );
  }
}
