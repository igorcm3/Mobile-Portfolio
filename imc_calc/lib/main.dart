import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weigthController = TextEditingController();
  TextEditingController heigthController = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String _infoText = "";
  String _imcResult = "";
  void _resetFields() {
    weigthController.text = "";
    heigthController.text = "";
    setState(() {
      _imcResult = "";
      _infoText = "";
      _formkey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weigth = double.parse(weigthController.text);
      double height = double.parse(heigthController.text) / 100;
      double imc = weigth / (height * height);
      _imcResult = "O IMC calculado é ${imc.toStringAsPrecision(4)}";
      if (imc < 18.6) {
        _infoText = "Abaixo no peso";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso ideal ";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente acima do peso";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade grau I";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade grau II";
      } else if (imc >= 40) {
        _infoText = "Obesidade grau III";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _resetFields();
            },
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  Icons.person_outline,
                  size: 120,
                  color: Colors.lightGreen,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 10),
                  child: Text(
                    "Informe seus dados",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25.0),
                  ),
                ),
                TextFormField(
                  controller: weigthController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira o peso!";
                    }
                  },
                ),
                TextFormField(
                  controller: heigthController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira a altura!";
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 10.0),
                  child: Container(
                    height: 45.0,
                    child: RaisedButton(
                      //TODO: Alterar shape do button
                      onPressed: () {
                        if (_formkey.currentState.validate()) {
                          _calculate();
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.green),
                      ),
                      child: Text(
                        "Calcular".toUpperCase(),
                        style: TextStyle(color: Colors.white, fontSize: 21.0),
                      ),
                      color: Colors.green,
                    ),
                  ),
                ),
                Text(
                  _imcResult,
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(color: Colors.greenAccent[700], fontSize: 25.0),
                ),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(color: Colors.greenAccent[700], fontSize: 25.0),
                ),
              ],
            ),
          )),
    );
  }
}
