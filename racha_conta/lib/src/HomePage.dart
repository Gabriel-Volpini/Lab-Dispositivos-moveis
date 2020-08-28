import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // VARIAVEIS
  final _tValor = TextEditingController();
  final _tPessoas = TextEditingController();
  final _tGarcom = TextEditingController();
  var _infoText = "Informe seus dados!";
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Racha conta"),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFF8E4DFF),
      body: _body(),
    );
  }

  //Limpeza dos dados após o calculo
  void _resetFields() {
    _tValor.text = "";
    _tPessoas.text = "";
    _tGarcom.text = "";
    setState(() {
      _formKey = GlobalKey<FormState>();
    });
  }

  _body() {
    return SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _textInfo(),
              _editText("Valor", _tValor, "(R\$) "),
              _editText("Quantidade de pessoas", _tPessoas, ""),
              _editText("Porcentagem do garçom", _tGarcom, "(%) "),
              _buttonCalcular(),
            ],
          ),
        ));
  }

  // Widget text
  _editText(String field, TextEditingController controller, String prefix) {
    return TextFormField(
      controller: controller,
      validator: (s) => _validate(s, field),
      keyboardType: TextInputType.number,
      style: TextStyle(
        fontSize: 22,
        color: Colors.white,
      ),
      decoration: InputDecoration(
        errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF4E008A))),
        errorStyle: TextStyle(color: Color(0xFF4E008A)),
        focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF4E008A))),
        labelText: field,
        prefixText: prefix,
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.white,
        )),
        labelStyle: TextStyle(
          fontSize: 22,
          color: Colors.white,
        ),
      ),
    );
  }

  // Validação
  String _validate(String text, String field) {
    if (text.isEmpty) {
      return "Este campo é obrigatório";
    } else if (double.parse(text) <= 0) {
      return "Este valor não pode ser negativo";
    }
    return null;
  }

  // Widget button
  _buttonCalcular() {
    return Container(
      margin: EdgeInsets.only(top: 30.0, bottom: 20),
      height: 55,
      child: RaisedButton(
        color: Theme.of(context).accentColor,
        child: Text(
          "Calcular",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _calculate();
          }
        },
      ),
    );
  }

  // Calculo da divisão
  void _calculate() {
    setState(() {
      double total = double.parse(_tValor.text);
      double garcomPercent = double.parse(_tGarcom.text);
      double pessoas = double.parse(_tPessoas.text);

      double garcomValue = total * (garcomPercent / 100);

      double value = (total + garcomValue) / pessoas;
      String stringValue = value.toStringAsPrecision(2);

      _infoText =
          "O valor total do garçom será R\$$garcomValue , cada pessoa deve pagar R\$$stringValue";
      _resetFields();
    });
  }

  // Widget text
  _textInfo() {
    return Text(
      _infoText,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.w500),
    );
  }
}
