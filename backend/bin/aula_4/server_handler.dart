import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart'; //o shelf_rout traz de forma mais amigavel e simplificada a criacao de rotas

//shelf_router disponibiliza uma serie de recurso para trabalhar com nosso metodos HTTP
class ServeHandler {
/*
Handle é um tipo typedef, ou seja, é um tipo criado
Handle é Uma funcao que lida com um Request,

*/
  Handler get handler {
    final router = Router();

    //primeira rota '/', enviamos um request  e retornamos um Response
    router.get('/', (Request request) {
      return Response(200, body: 'Primeira Rota');
    });

    return router;
  }
}
