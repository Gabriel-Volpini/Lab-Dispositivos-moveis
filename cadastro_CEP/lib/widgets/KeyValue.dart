import 'package:flutter/material.dart';

// ignore: must_be_immutable
class KeyValue extends StatelessWidget {
  String chave;
  String value;
  bool isVisible;

  KeyValue(this.chave, this.value, this.isVisible);

  @override
  Widget build(BuildContext context) {
    return isVisible
        ? RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.black, fontSize: 19),
              children: <TextSpan>[
                TextSpan(
                    text: '$chave: ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: '$value'),
              ],
            ),
          )
        : Container();
  }
}
