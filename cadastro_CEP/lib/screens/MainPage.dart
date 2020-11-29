import 'package:cadastro/screens/CreateScreen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var snapshot =
      FirebaseFirestore.instance.collection("Localização").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meu programer'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateScreen()))),
      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: snapshot,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) =>
                    (ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (BuildContext context, int idx) {
                          var doc = snapshot.data.docs[idx];
                          return ListTile(
                            title: Text(
                                "${doc.data()['logradouro']} - ${doc.data()['bairro']}"),
                            subtitle: Text(
                                "${doc.data()['localidade']} - ${doc.data()['uf']}"),
                          );
                        }))),
      ),
    );
  }
}
