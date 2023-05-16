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
    //http://localhost:8080/ola/mundo/nome/paulo
    router.get('/ola/mundo/nome/<usuario>', (Request req, String usuario) {
      return Response.ok("Ola mundo $usuario");
    });

    //passando atributo via query param, tem que usar o ?, o navegador sabe que depois da interrogacao é tudo query parametros
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

    return router;
  }
}
