import 'package:shelf/shelf.dart';

class MiddlewareInterception {
  Middleware get middleware => createMiddleware(
        responseHandler: (Response res) => res.change(
          headers: {'content-type': 'application/json'},
        ),
      );
}


/*
codigo antes de limpar

Middleware get middleware {
    return createMiddleware(responseHandler: (Response res) {
      return res.change(headers: {'content-type': 'application/json'});
    });
  }
*/