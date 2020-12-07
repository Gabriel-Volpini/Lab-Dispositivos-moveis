import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:virtual_museu/screen/ImageView.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var fotos = [];
  var info;

  Future<void> getDataFromAPI() async {
    var response = await http.get(
        "https://api.harvardartmuseums.org/image?apikey=4e461967-72e1-4502-9f84-87622df7bc02");
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      setState(() {
        fotos = jsonResponse['records'];
        info = jsonResponse['info'];
      });
    }
  }

  Future<void> goToNextPage() async {
    var response = await http.get(info['next']);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      setState(() {
        fotos = jsonResponse['records'];
        info = jsonResponse['info'];
      });
    }
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
      ),
      body: Scrollbar(
        child: ListView(
          children: [
            for (int i = 0; i < fotos.length; i++)
              ListTile(
                title: Text("Imagem - ${fotos[i]['imageid']}"),
                leading: Image.network(fotos[i]['baseimageurl'], width: 30),
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
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}
