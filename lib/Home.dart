import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Metodo para recuperar o preco
  Future<Map> _recuperarPreco() async {
    //Pegando a URL
    String url = "https://blockchain.info/ticker";
    http.Response response = await http.get(url);
    //Fututre - Fica mais facil gerenciar o consumo WEB
    //Future - Conseguimos controlar a demora da requisicao e se deu certo.
    return json.decode(response.body);

    //Future - Dados que ainda vai se recuperar.
    //Snapshot - Dados recuperados ao fazer a requisicao.
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map>(
      future: _recuperarPreco(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          //Estado nulo da conexao
          case ConnectionState.none:
        }
      },
    );
  }
}
