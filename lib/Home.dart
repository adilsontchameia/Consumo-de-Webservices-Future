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

  String _urlBase = "https://jsonplaceholder.typicode.com";

  //Metodo para recuperar postagens
  Future<List<Post>> _recuperarPostagens() async {
    http.Response response = await http.get(_urlBase + "/posts");
    var dadosJson = json.decode(response.body);

    //Percorrer para retornar como lista de postagens
    //Lista de postagens
    List<Post> postagens = List();
    for (var post in dadosJson) {
      print("Post: " + post["title"]);
      //Post configurada
      //Posso adicionar numa lista
      Post p = Post(post["userId"], post["id"], post["title"], post["body"]);
      postagens.add(p);
    }

    return postagens;
    //print(postagens.toString());
  }

//Metodo de requisiscao
//Post - insere
  _post() async {
    var corpo = json.encode(
      {
        "userId": 128,
        "id": null,
        "title": "Titulo",
        "body": "Corpo da Postagem"
      },
    );
    http.Response response = await http.post(_urlBase + "/posts",
        //Parametros opcionais
        headers: {'Content-type': 'application/json; charset=UTF-8'},
        //Corpo (dados a se enviar parar requisicao post)
        body: corpo);

    //Mostrando o restado, e os dados da API
    print("Resultado: ${response.statusCode}");
    print("Resultado: ${response.body}");
  }

//Atualizar os recursos na API
//Precisamos especificar qual POST atualizar
  _put() async {
    var corpo = json.encode(
      {
        "userId": 128,
        "id": null,
        "title": "Titulo alterado",
        "body": "Corpo da Postagem alterada"
      },
    );
    http.Response response = await http.put(_urlBase + "/posts/2",
        //Parametros opcionais
        headers: {'Content-type': 'application/json; charset=UTF-8'},
        //Corpo (dados a se enviar parar requisicao post)
        body: corpo);

    //Mostrando o restado, e os dados da API
    print("Resultado: ${response.statusCode}");
    print("Resultado: ${response.body}");
  }

//Atualiza coisas especificas, um unico campo
  _patch() async {
    var corpo = json.encode(
      {"userId": 128, "id": null, "body": "Corpo da Postagem alterada"},
    );
    http.Response response = await http.patch(_urlBase + "/posts/2",
        //Parametros opcionais
        headers: {'Content-type': 'application/json; charset=UTF-8'},
        //Corpo (dados a se enviar parar requisicao post)
        body: corpo);

    //Mostrando o restado, e os dados da API
    print("Resultado: ${response.statusCode}");
    print("Resultado: ${response.body}");
  }

//Metodo para apagar
  _delete() async {
    var corpo = json.encode(
      {
        "userId": 128,
        "id": null,
        "title": "Titulo alterado",
        "body": "Corpo da Postagem alterada"
      },
    );
    http.Response response = await http.delete(_urlBase + "/posts/2");

    //Mostrando o restado, e os dados da API
    //Codigo 200 - OK
    if (response.statusCode == 200) {
      //Sucesso
    } else {
      //Erro
    }
    print("Resultado: ${response.statusCode}");
    print("Resultado: ${response.body}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de Servico Avancado"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: _post,
                  child: Text("Salvar"),
                ),
                ElevatedButton(
                  //onPressed: _put,
                  onPressed: _patch,
                  child: Text("Atualizar"),
                ),
                ElevatedButton(
                  onPressed: _delete,
                  child: Text("Remover"),
                ),
              ],
            ),
            //Future
            Expanded(
              child: FutureBuilder<List<Post>>(
                future: _recuperarPostagens(),
                builder: (context, snapshot) {
                  //String resultado;
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      //print("conexao waiting");
                      //Indicador de progresso
                      return Center(child: CircularProgressIndicator());
                      break;
                    case ConnectionState.active:
                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        //resultado = "Erro ao carregar os dados.";
                        print("Erro ao carregar");
                      } else {
                        //double valor = snapshot.data["BRL"]["buy"]; //Aqui
                        //resultado = "Preço do bitcoin: ${valor.toString()} ";
                        print("Lista carregada");
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              //Pegar a postagem da API para uma lista
                              List<Post> lista = snapshot.data;
                              Post post = lista[index];
                              //Retornar na lista
                              return ListTile(
                                title: Text(post.title),
                                subtitle: Text(post.id.toString()),
                              );
                            });
                      }
                      break;
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
