import 'package:shelf/shelf.dart';

abstract class Api {
  Handler getHandler({List<Middleware>? middlewares});

  //esse metodo vai devolver um handler
  Handler createHandler({
    required Handler router,
    List<Middleware>? middlewares,
  }) {
    middlewares ??= [];
    var pipeline = Pipeline();

    middlewares.forEach((m) => pipeline = pipeline.addMiddleware(m));
    return pipeline.addHandler(router);
  }
}
