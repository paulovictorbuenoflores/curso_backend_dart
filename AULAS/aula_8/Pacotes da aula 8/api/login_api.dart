import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class LoginApi {
  //como criar uma API?

  //sabemos que temos que devolver um handler

  Handler get handler {
    Router router = Router();

    router.post('/login', (Request req) {
      return Response.ok('API de Login');
    });

    return router;
  }
}
