import 'package:shelf/shelf.dart';
import 'validate/api_router_validade.dart';

import '../../utils/custom_env.dart';
import 'security_service.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class SecurityServiceImp implements SecurityService<JWT> {
  @override
  Future<String> generateJWT(String userID) async {
    var jwt = JWT({
      //iat data de criacao do token
      'iat': DateTime.now().millisecondsSinceEpoch,
      //sub para quem é esse cara, personalizamos para userId
      'userID': userID,
      //roles tipos de usuarios
      'roles': ['admin', 'user'],
    });

    String key = await CustomEnv.get(key: 'jwt_key');
    //valida e assina nosso token
    String token = jwt.sign(SecretKey(key));
    return token;
  }

  @override
  Future<JWT?> validateJWT(String token) async {
    String key = await CustomEnv.get(key: 'jwt_key');

    try {
      //se retornar diferente de null é valido.
      return JWT.verify(token, SecretKey(key));
    } on JWTInvalidError {
      return null;
    } catch (e) {
    } on JWTExpiredError {
      return null;
    } catch (e) {
    } on JWTNotActiveError {
      return null;
    } catch (e) {
    } on JWTUndefinedError {
      return null;
    } catch (e) {
      return null;
    }
  }

//como criar um Middleware,  o middleware ele pega o Handler do usuario, nesse hendler tem  o request, tem um response e tem o erro hendler
// so que dentro do handler trabalharemos o request, ou seja, vamos modificar ele, e colocar ele de volta dentro da handler, e deixar ele processar e seguir o fluxo normal
  @override
  Middleware get authorization {
    return (Handler handler) {
      return (Request req) async {
        //onde podemos manipular, modificar o request

        //capturando as heards, para pegar o token
        String? authorizationHeader = req.headers['Authorization'];
        JWT? jwt;
        //primeira validacao
        if (authorizationHeader != null) {
          if (authorizationHeader.startsWith('Bearer ')) {
            //captura o token
            String token = authorizationHeader.substring(7);
            //precisamos validar o token
            jwt = await validateJWT(token);
          }
        }

//vamos fazer uma modificacao no contexto do nosso request, passando o jwt token valido.
        var request = req.change(context: {'jwt': jwt});
        return handler(request);
      };
    };
  }

//verify JWT: bloqueia o acesso a API, se o token for null nao valido.
//verifica se o nosso JWT é valido se está no contexto do usuario para ai sim poder liberar a passagem para nossa as APIs
  @override
  Middleware get verifyJwt => createMiddleware(
        requestHandler: (Request req) {
          //verificar se no contexto da nossa requisicao existe o JWT && se ele é diferente de nulo
          if (req.context['jwt'] == null) {
            return Response.forbidden('Acesso Não Autorizado!');
          }
          return null;
        },
      );
  //o problema ao barrar as APIs é que o usuario nao consegue acessar a api de login pela primeira vez para gerar um token valido
  //entao temos que saber como permitir alguns casos
}

/*
Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE2ODQyMzY3MTAsInVzZXJJRCI6IjEiLCJyb2xlcyI6WyJhZG1pbiIsInVzZXIiXX0.nGG_CXjsl65pjdQNiLERFGcqe-5GBofpA4BZpiSMc_g
*/


