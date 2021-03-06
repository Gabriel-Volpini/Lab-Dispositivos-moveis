import 'package:flutter/material.dart';
import 'package:mvc_app/controllers/item.controller.dart';
import 'package:mvc_app/models/item.model.dart';

class ItemListView extends StatefulWidget {
  @override
  _ItemListViewState createState() => _ItemListViewState();
}

class _ItemListViewState extends State<ItemListView> {
  final _formKey = GlobalKey<FormState>();
  var _itemController = TextEditingController();
  var _itemController2 = TextEditingController();
  var _list = List<Item>();
  var _controller = ItemController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.getAll().then((data) {
        setState(() {
          _list = _controller.list;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Lista de filmes para quarentena'), centerTitle: true),
      body: Scrollbar(
        child: ListView(
          children: [
            for (int i = 0; i < _list.length; i++)
              ListTile(
                title: ListTile(
                  title: Text(_list[i].titulo),
                  subtitle: Text("Indicado por:" + _list[i].pagina),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete_forever,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      _controller.delete(i).then((data) {
                        setState(() {
                          _list = _controller.list;
                        });
                      });
                    },
                  ),
                  leading: Image.network(
                      'https://images.vexels.com/media/users/3/135655/isolated/preview/c751bf3ae9cb8bfa7c2395bc05f2269f-desenhos-animados-de-claquete-by-vexels.png'),
                ),
              ),
          ],
        ),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    controller: _itemController,
                    validator: (s) {
                      if (s.isEmpty)
                        return "Este campo é obrigatório.";
                      else
                        return null;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(labelText: "Nome do filme"),
                  ),
                  TextFormField(
                    controller: _itemController2,
                    validator: (s) {
                      if (s.isEmpty)
                        return "Este campo é obrigatório.";
                      else
                        return null;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(labelText: "Indicado por"),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: new Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: new Text('SALVAR'),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _controller
                        .create(Item(
                      titulo: _itemController.text,
                      pagina: _itemController2.text,
                    ))
                        .then((data) {
                      setState(() {
                        _list = _controller.list;
                        _itemController.text = "";
                        _itemController2.text = "";
                      });
                    });
                    Navigator.of(context).pop();
                  }
                },
              )
            ],
          );
        });
  }
}
