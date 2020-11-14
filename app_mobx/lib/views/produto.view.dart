import 'package:app_mobx/controllers/produto.controller.dart';
import 'package:app_mobx/models/produto.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../app_status.dart';

class ProdutoListView extends StatefulWidget {
  @override
  _ProdutoListViewState createState() => _ProdutoListViewState();
}

class _ProdutoListViewState extends State<ProdutoListView> {
  final _formKey = GlobalKey<FormState>();
  var _itemController = TextEditingController();
  ProdutoController _controller = null;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _controller.getAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    _controller = Provider.of<ProdutoController>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Lista de Compromissos'), centerTitle: true),
      body: Scrollbar(
        child: Observer(builder: (_) {
          if (_controller.status == AppStatus.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (_controller.status == AppStatus.success) {
            return ListView(
              children: [
                for (int i = 0; i < _controller.list.length; i++)
                  ListTile(
                      leading: Image.network(
                          'https://image.freepik.com/vetores-gratis/calendario-com-relogio-enquanto-espera-evento-agendado-icone-simbolo-isolado-plana-dos-desenhos-animados_101884-758.jpg'),
                      title: CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: _controller.list[i].concluido
                            ? Text(
                                _controller.list[i].nome,
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough),
                              )
                            : Text(_controller.list[i].nome),
                        value: _controller.list[i].concluido,
                        secondary: IconButton(
                          icon: Icon(
                            Icons.delete,
                            size: 20.0,
                            color: Colors.red[900],
                          ),
                          onPressed: () async {
                            await _controller.delete(i);
                          },
                        ),
                        onChanged: (c) async {
                          Produto edited = _controller.list[i];
                          edited.concluido = c;
                          await _controller.update(i, edited);
                        },
                      )),
              ],
            );
          } else {
            return Text("Erro");
          }
        }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _displayDialog(context),
      ),
    );
  }

  _displayDialog(context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Form(
              key: _formKey,
              child: TextFormField(
                controller: _itemController,
                validator: (s) {
                  if (s.isEmpty)
                    return "Digite o seu compromisso.";
                  else
                    return null;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: "Compromisso"),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: new Text('Cancelar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: new Text('Salvar'),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _controller.create(
                        Produto(nome: _itemController.text, concluido: false));
                    _itemController.text = "";
                    Navigator.of(context).pop();
                  }
                },
              )
            ],
          );
        });
  }
}
