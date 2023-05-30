import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../infra/security/security_service.dart';
import '../services/login_service.dart';
import '../to/auth_to.dart';
import 'api.dart';

class LoginApi extends Api {
  //como criar uma API?

  //sabemos que temos que devolver um handler
// tem que ser imutavel e n pode receber um novo valor
  final SecurityService _securityService;
  final LoginService _loginService;

  LoginApi(this._securityService, this._loginService);

  @override
  Handler getHandler({
    List<Middleware>? middlewares,
    bool isSecurity = false,
  }) {
    Router router = Router();

    router.post('/login', (Request req) async {
      var body = await req.readAsString();
      var authTO = AuthTO.fromRequest(body);

      int userID = await _loginService.authnticate(authTO);
      if (userID >= 0) {
        var jwt = await _securityService.generateJWT(userID.toString());

        return Response.ok(jsonEncode({'token': jwt}));
      } else {
        return Response(401);
      }
    });

    return createHandler(
      router: router,
      isSecurity: isSecurity,
      middlewares: middlewares,
    );
  }
}
