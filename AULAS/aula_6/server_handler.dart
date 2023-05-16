import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart'; //o shelf_rout traz de forma mais amigavel e simplificada a criacao de rotas

/*
Hoje vomos ver como passar atributos pelo path e via query params
1- vamos entender oq é cada um 
http://localhost:8080/ola/mundo
isso aqui é o path da nossa aplicacao: ola/mundo

*/

class ServeHandler {
  Handler get handler {
    final router = Router();

    router.get('/', (Request request) {
      return Response(200, body: 'Primeira Rota');
    });

    //http://localhost:8080/ola/mundo
    //agora tenho o path: ola/mundo
    router.get('/ola/mundo', (Request req) {
      return Response.ok("Ola mundo");
    });
    // como passar informacao pelo path
    router.get('/ola/mundo/nome/<usuario>', (Request req, String usuario) {
      return Response.ok("Ola mundo $usuario");
    });

    //passando atributo via query param
    //http://localhost:8080/query?
    router.get('/query', (Request req) {
      //vamos receber a requisicao, enviada pelo cliente atraves do protocolo http pelo padrao REST
      String? nome = req.url.queryParameters['nome'];
      //http://localhost:8080/query?nome=Paulo
      return Response.ok('Query eh: $nome');
    });
    //passando  2 atributo via query param, nome e idade
    //http://localhost:8080/query?
    router.get('/idadeNome/query', (Request req) {
      //vamos receber a requisicao, enviada pelo cliente atraves do protocolo http pelo padrao REST
      String? nome = req.url.queryParameters['nome'];
      String? idade = req.url.queryParameters['idade'];
      //http://localhost:8080/query?nome=Paulo&idade=26
      return Response.ok('Query eh: $nome,$idade');
    });

    //////////////////// aula 6 falaremos sobre o metodo post //////////////////////////
//usamos o post toda vez que queremos que as informacoes seja trafegadas de foma privada, ou seja, é um pouco mais seguro que o metodo Get
    router.post('/login', (Request req) async {
      var result = await req.readAsString();
      Map json = jsonDecode(result);

      var usuario = json['usuario'];
      var senha = json['senha'];
      //se usuario == admin e senha 123
      if (usuario == 'admin' && senha == '123') {
        return Response.ok('Bem vindo $usuario');
      } else {
        return Response.forbidden('Acesso Negado!!!');
      }

      //acima vemos como enviar informacoes atraves do metodo post, decifra ela atraves do metodo json decoder, json para Map, Map para json
    });

    return router;
  }
}

/*
O navegador só consegue tratar rotas do tipo Get.
para testar nossa API com metodo Post   usaremos o PostMan, os dados enviados esta no formato Json, este formato é parecido com umapa, chave:valor.

Sobre o PostMan: É uma ferramenta com uma serie de funcionalidades, para testar e trabalhar com APIs, consegue fazer mocks de servidores, consegue monitorar requisicoes, fazer teste automatizados
Postman é uma das ferramentas mais usadas em qualquer empresa.
*/
