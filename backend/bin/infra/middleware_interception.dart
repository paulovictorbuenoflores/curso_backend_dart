import 'package:shelf/shelf.dart';
//vamos trabalhar com json em nossa aplicacao, para isso vomos criar esse middleware que intercepta de forma global, para converter em json

//o middleware nada mais é que uma classe que intercepta nossa requisicao ou nosso response, e execulta determinada tarefa
class MiddlewareInterception {
  Middleware get middleware => createMiddleware(
        responseHandler: (Response res) => res.change(
          headers: {'content-type': 'application/json'},
        ),
      );
}


/*
codigo antes de limpar

o createMiddleware pode trabalhar com 3 tipos de middleware, 1-requestHandler, 2 responseHandler, 3 errorHandler 


Middleware get middleware {
    return createMiddleware(responseHandler: (Response res) {
      return res.change(headers: {'content-type': 'application/json'});
    });
  }
*/