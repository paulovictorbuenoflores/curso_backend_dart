import 'dart:convert';

import 'package:shelf/shelf.dart';

import 'package:shelf_router/shelf_router.dart';

import '../models/usuario_model.dart';
import '../services/usuario_service.dart';
import 'api.dart';

class UsuarioApi extends Api {
  final UsuarioService _usuarioService;

  UsuarioApi(this._usuarioService);

  @override
  Handler getHandler({
    List<Middleware>? middlewares,
    bool isSecurity = false,
  }) {
    final router = Router();

    router.get('/user', (Request req) {
      return Response.ok('');
    });

    router.post('/user', (Request req) async {
      var body = await req.readAsString();
      if (body.isEmpty) return Response(400);
      //o jsonDecode vai devolver um mapa, apartir da string body que é um json
      //o fromRequest vai ler o map e passar para um usuario os valores devidos,
      // que nossa factory fabricara um novo usuario
      var user = UsuarioModel.fromRequest(jsonDecode(body));

      var result = await _usuarioService.save(user);
      return result ? Response(201) : Response(500);
    });

    router.put('/user', (Request req) {
      return Response.ok('');
    });

    router.delete('/user', (Request req) {
      return Response.ok('');
    });

    return createHandler(
      router: router,
      isSecurity: isSecurity,
      middlewares: middlewares,
    );
  }
}
