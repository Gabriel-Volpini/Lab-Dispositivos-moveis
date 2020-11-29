import 'dart:convert';

import 'package:cadastro/widgets/KeyValue.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateScreen extends StatefulWidget {
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  TextEditingController cepController = TextEditingController();
  TextEditingController localidadeController = TextEditingController();
  TextEditingController bairroController = TextEditingController();
  TextEditingController logradouroController = TextEditingController();
  TextEditingController ufController = TextEditingController();

  bool isSearch = false;

  void consultaCep() async {
    http.Response dataFromAPI =
        await http.get("https://viacep.com.br/ws/${cepController.text}/json/");

    Map<String, dynamic> response = json.decode(dataFromAPI.body);

    setState(() {
      localidadeController.text = response["localidade"];
      bairroController.text = response["bairro"];
      logradouroController.text = response["logradouro"];
      ufController.text = response["uf"];
      isSearch = true;
    });
  }

  void salvaItem() async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    await db.collection("Localização").add({
      "localidade": localidadeController.text,
      "bairro": bairroController.text,
      "logradouro": logradouroController.text,
      "uf": ufController.text,
    });

    return Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar cep'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Cep',
                ),
                controller: cepController,
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                width: 400,
                child: RaisedButton(
                  color: Colors.blueAccent,
                  child: Text(
                    'Pesquisar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                  onPressed: consultaCep,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              KeyValue('Localidade', localidadeController.text, isSearch),
              SizedBox(
                height: 5,
              ),
              KeyValue('Bairro', bairroController.text, isSearch),
              SizedBox(
                height: 5,
              ),
              KeyValue('Logradouro', logradouroController.text, isSearch),
              SizedBox(
                height: 5,
              ),
              KeyValue('Uf', ufController.text, isSearch),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                width: 400,
                child: isSearch
                    ? RaisedButton(
                        color: Colors.blueAccent,
                        child: Text(
                          'Salvar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                        onPressed: salvaItem,
                      )
                    : Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
