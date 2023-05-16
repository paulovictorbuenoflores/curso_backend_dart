import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

/*
Na aula de hoje aprenderemos como devolver os objetos, temos varios tipos dele, informamos para o header que devolveremos um tipo.
Como devolver um objeto do tipo Json
*/
class ServeHandler {
  Handler get handler {
    final router = Router();

    router.get('/', (Request req) {
      //exemplo de como devolver um HTML
      return Response.ok('<h1>Primeira Rota</h1>',
          headers: {'content-type': 'text/html'});
    });
    /*
    Por que devolver um tipo é muito importante? porque dessa forma os clientes que requisitaram uma informacao vao ter a resposta ja com o tipo plenamente definido do contente-type daquele objeto requesitado
    */

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

    router.post('/login/jsonEncode', (Request req) async {
      var result = await req.readAsString();
      Map json = jsonDecode(result);

      var usuario = json['usuario'];
      var senha = json['senha'];

      //aqui vamos fazer um jsonEncode, ou seja, processo oposto do metodo acima, enviaremos um metodo Map para json
      if (usuario == 'admin' && senha == '123') {
        Map result = {
          'token': 'token123',
          'id': 1,
        };
        String jsonResponse = jsonEncode(result);

        return Response.ok(jsonResponse,
            headers: {'content-type': 'application/json'});
      } else {
        return Response.forbidden('Acesso Negado!!!');
      }

      //acima vemos como enviar informacoes atraves do metodo post, decifra ela atraves do metodo json decoder, json para Map, Map para json
    });
    return router;
  }
}
