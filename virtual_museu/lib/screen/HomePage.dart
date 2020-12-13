import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:virtual_museu/screen/ImageView.dart';
import 'package:virtual_museu/screen/FavoritesView.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart' as p;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var fotos = [];
  var info;

  Future<void> getDataFromAPI() async {
    var response = await http.get(
        "https://api.harvardartmuseums.org/image?apikey=YOUR_API_KEY_HERE");
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var newFotos = jsonResponse['records'];

      for (final f in newFotos) {
        f['isEnable'] = false;
      }

      setState(() {
        fotos = newFotos;
        info = jsonResponse['info'];
      });
    }
  }

  Future<void> goToNextPage() async {
    var response = await http.get(info['next']);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var newFotos = jsonResponse['records'];

      for (final f in newFotos) {
        f['isEnable'] = false;
      }

      setState(() {
        fotos = newFotos;
        info = jsonResponse['info'];
      });
    }
  }

  void addFavorite(String imageUrl, int imageId) async {
    Directory documentDirectory = await p.getApplicationDocumentsDirectory();
    String path = documentDirectory.path + 'database.db';

    var database = await openDatabase(path,
        version: 1, onUpgrade: (Database db, int version, int info) async {},
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE Favoritos (idFavorito integer primary key autoincrement, baseImageUrl TEXT, imageId INTEGER )");
    });

    await database.rawInsert(
        "insert into Favoritos(baseImageUrl, imageId) values(?,?)",
        [imageUrl, imageId]);

    var newFotos = fotos;
    for (final f in newFotos) {
      if (f['imageid'] == imageId) {
        f['isEnable'] = true;
      }
    }
    setState(() {
      fotos = newFotos;
    });

    await database.close();
  }

  @override
  void initState() {
    getDataFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Museu virtual"),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FavoritesView())),
              child: Icon(
                Icons.favorite,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Scrollbar(
        child: ListView(
          children: [
            for (int i = 0; i < fotos.length; i++)
              ListTile(
                title: Text("Imagem - ${fotos[i]['imageid']}"),
                leading: Image.network(fotos[i]['baseimageurl'], width: 30),
                trailing: IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: fotos[i]['isEnable'] ? Colors.red : Colors.grey,
                    ),
                    onPressed: () => addFavorite(
                        fotos[i]['baseimageurl'], fotos[i]['imageid'])),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ImageView(fotos[i]['baseimageurl']))),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: goToNextPage,
        child: Icon(Icons.cached),
      ),
    );
  }
}
