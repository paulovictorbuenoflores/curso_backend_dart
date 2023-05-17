import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../models/noticia_model.dart';
import '../services/generic_service.dart';
import '../services/noticia_service.dart';
import 'api.dart';

//api rest full trabalhando com retorno da informacao
class BlogApi extends Api {
//inversao do controle de dependencia 5 principio do solid
  final GenericService<NoticiaModel> _service;
  BlogApi(
    this._service,
  );

  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    Router router = Router();

    //abaixo teremos os end-point

    //router.get é o metodo endpoint que vamos fazer a listagem
    //listagem
    router.get('/blog/noticias', (Request req) {
      List<NoticiaModel> noticias = _service.findAll();
      List<Map> noticiasMap = noticias.map((e) => e.toJson()).toList();
      return Response.ok(jsonEncode(noticiasMap));
    });

    //nova notificacao
    router.post('/blog/noticias', (Request req) async {
      var body = await req.readAsString();
      _service.save(NoticiaModel.fromJson(jsonDecode(body)));
      return Response(201);
    });

    //update- com query param: ?id=1?id=1
    // /blog/noticias?id=1
    router.put('/blog/noticias', (Request req) {
      String? id = req.url.queryParameters['id'];
      //   _service.save('');
      return Response.ok('Choveu hoje');
    });

    // /blog/noticias?id=1
    //delete
    router.delete('/blog/noticias', (Request req) {
      String? id = req.url.queryParameters['id'];
      //  _service.delete(1);
      return Response.ok('Choveu hoje');
    });

    return createHandler(
      router: router,
      isSecurity: isSecurity,
      middlewares: middlewares,
    );
  }
}
