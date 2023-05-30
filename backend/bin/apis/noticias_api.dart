import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../models/noticia_model.dart';
import '../services/generic_service.dart';
import '../services/noticia_service.dart';
import 'api.dart';

//api rest full trabalhando com retorno da informacao
class NoticiasApi extends Api {
//inversao do controle de dependencia 5 principio do solid
  final GenericService<NoticiaModel> _service;
  NoticiasApi(
    this._service,
  );

  @override
  Handler getHandler({
    List<Middleware>? middlewares,
    bool isSecurity = false,
  }) {
    Router router = Router();

    //abaixo teremos os end-point

    //router.get é o metodo endpoint que vamos fazer a listagem
    //listagem
    //http://localhost:8080/noticia?id=2
    router.get('/noticia', (Request req) async {
      String? id = await req.url.queryParameters['id'];
      if (id == null) return Response(400);

      var noticia = await _service.findOne(int.parse(id));
      if (noticia == null) return Response(400);

      return Response.ok(jsonEncode(noticia.toJson()));
    });
    router.get('/noticias', (Request req) async {
      List<NoticiaModel> noticias = await _service.findAll();
      List<Map> noticiasMap = noticias.map((e) => e.toJson()).toList();
      return Response.ok(jsonEncode(noticiasMap));
    });

    //nova notificacao
    router.post('/noticias', (Request req) async {
      var body = await req.readAsString();
      var result =
          await _service.save(NoticiaModel.fromRequest(jsonDecode(body)));
      return result ? Response(201) : Response(500);
    });

    //update- com query param: ?id=1?id=1
    // /blog/noticias?id=1
    router.put('/noticias', (Request req) async {
      var body = await req.readAsString();
      var result =
          await _service.save(NoticiaModel.fromRequest(jsonDecode(body)));
      return result ? Response(201) : Response(500);
    });

    // /blog/noticias?id=1
    //delete
    router.delete('/noticias', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);

      var result = await _service.delete(int.parse(id));
      return result ? Response(200) : Response(500); //internalServerError
    });

    return createHandler(
      router: router,
      isSecurity: isSecurity,
      middlewares: middlewares,
    );
  }
}
