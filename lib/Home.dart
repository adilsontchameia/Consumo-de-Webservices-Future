import 'package:consumo_webservices_future/Post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  /*Future<Map> _recuperarPreco() async {
    
    String url = "https://blockchain.info/ticker";
    http.Response response = await http.get(url);
    return json.decode(response.body);
    
  }
*/

  String urlBase = "https://jsonplaceholder.typicode.com";

  //Metodo para recuperar postagens
  Future<List<Post>> _recuperarPostagens() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de Servico Avancado"),
      ),
      body: FutureBuilder<List<Post>>(
        future: _recuperarPostagens(),
        builder: (context, snapshot) {
          //String resultado;
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              print("conexao waiting");
              //resultado = "Carregando...";
              break;
            case ConnectionState.active:
            case ConnectionState.done:
              print("conexao done");
              if (snapshot.hasError) {
                //resultado = "Erro ao carregar os dados.";
              } else {
                //double valor = snapshot.data["BRL"]["buy"]; //Aqui
                //resultado = "Preço do bitcoin: ${valor.toString()} ";
              }
              break;
          }
          return Center(
            child: null,
          );
        },
      ),
    );
  }
}
