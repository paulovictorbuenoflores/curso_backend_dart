import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../infra/security/security_service.dart';
import 'api.dart';

class LoginApi extends Api {
  //como criar uma API?

  //sabemos que temos que devolver um handler

  final SecurityService
      _securityService; // tem que ser imutavel e n pode receber um novo valor

  LoginApi(this._securityService);

  @override
  Handler getHandler({
    List<Middleware>? middlewares,
    bool isSecurity = false,
  }) {
    Router router = Router();

    router.post('/login', (Request req) async {
      // return Response.ok('API de Login');
      var token = await _securityService.generateJWT('1');
      var result = await _securityService.validateJWT(token);

      //return Response.ok((result != null).toString());
      return Response.ok(token);
    });

    return createHandler(
        router: router, isSecurity: isSecurity, middlewares: middlewares);
  }
}
