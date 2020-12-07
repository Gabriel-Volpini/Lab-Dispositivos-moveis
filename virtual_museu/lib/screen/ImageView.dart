import 'package:flutter/material.dart';

// ignore: must_be_immutable

class ImageView extends StatelessWidget {
  String url;
  ImageView(this.url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Image.network(url),
        ),
      ),
    );
  }
}
