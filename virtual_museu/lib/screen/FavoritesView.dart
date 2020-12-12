import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart' as p;
import 'package:virtual_museu/screen/ImageView.dart';

class FavoritesView extends StatefulWidget {
  @override
  _FavoritesViewState createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  var lista = [];

  void getFavorite() async {
    var documentDirectory = await p.getApplicationDocumentsDirectory();
    String path = documentDirectory.path + 'database.db';

    var database = await openDatabase(
      path,
      version: 1,
      onUpgrade: (Database db, int version, int info) async {},
    );

    var data = await database.query('Favoritos', columns: ['*']);
    setState(() {
      lista = data;
    });
    await database.close();
  }

  void removeItem(int imageId) async {
    var documentDirectory = await p.getApplicationDocumentsDirectory();
    String path = documentDirectory.path + 'database.db';

    var database = await openDatabase(
      path,
      version: 1,
      onUpgrade: (Database db, int version, int info) async {},
    );
    await database
        .rawDelete('delete from Favoritos where imageId=?', [imageId]);
    await database.close();

    getFavorite();
  }

  @override
  void initState() {
    getFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos'),
        centerTitle: true,
      ),
      body: Scrollbar(
        child: ListView(
          children: [
            for (int i = 0; i < lista.length; i++)
              ListTile(
                title: Text("Imagem - ${lista[i]['imageId']}"),
                leading: Image.network(lista[i]['baseImageUrl'], width: 30),
                trailing: IconButton(
                  icon: Icon(
                    Icons.delete_forever,
                    color: Colors.red,
                  ),
                  onPressed: () => removeItem(lista[i]['imageId']),
                ),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ImageView(lista[i]['baseImageUrl']))),
              ),
          ],
        ),
      ),
    );
  }
}
