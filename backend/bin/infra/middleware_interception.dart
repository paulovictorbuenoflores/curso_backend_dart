import 'package:shelf/shelf.dart';
//vamos trabalhar com json em nossa aplicacao, para isso vomos criar esse middleware que intercepta de forma global, para converter em json

//o middleware nada mais é que uma classe que intercepta nossa requisicao ou nosso response, e execulta determinada tarefa
class MInterception {
  static Middleware get contentTypeJson => createMiddleware(
        responseHandler: (Response res) => res.change(
          headers: {'content-type': 'application/json'},
        ),
      );

  static Middleware get cors {
//1 - criar os headers permitidos

    final headersPermitidos = {
      //chave especial que ele precisa responder toda vez Access-Control-Allow-Origin: *
      //isso fala que ele esta aceitando requisicoes de todas as origins, ou seja, agora nossa API esta exposta
      //Se eu quisesse que apenas um site especifico fizesse requisicoes seria assim: 'Access-Control-Allow-Origin': 'www.siteEspecifico.com',
      'Access-Control-Allow-Origin': '*'
    };
//2 - responder as opcoes, o cors vai fazer uma requisicao para o nosso servidor pergutando quais opcoes vc tem disponiveis, ai o sevidor devolve as opcoes disponiveis
    Response? handlerOption(Request req) {
      if (req.method == 'OPTIONS') {
        return Response(200, headers: headersPermitidos);
      } else {
        return null;
      }
    }

//alterar o meu response para que ele tenha esse headlerOtion explicitamente

    Response addCorsHeader(Response resp) =>
        resp.change(headers: headersPermitidos);

    return createMiddleware(
      requestHandler: handlerOption,
      responseHandler: addCorsHeader,
    );
  }
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
