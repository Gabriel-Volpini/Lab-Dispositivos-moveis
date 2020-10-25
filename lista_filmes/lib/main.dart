import 'package:flutter/material.dart';
import 'package:mvc_app/views/item_list.view.dart';

void main() {
  runApp(MaterialApp(
    title: 'Lista de filmes para quarentena',
    debugShowCheckedModeBanner: false,
    home: ItemListView(),
  ));
}
