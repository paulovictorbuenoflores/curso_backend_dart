//esse contrato garante que se um dia precisar trocar a biblioteca do  jwt fica facil a troca
import 'package:shelf/shelf.dart';

abstract class SecurityService<T> {
  // gera gerar um jwt
  Future<String> generateJWT(String userID);
  // vai validar nosso jwt
  Future<T?> validateJWT(String token);

  //1 Middleware de seguranca, ou seja, vai colocar seguranca nas nossas APIs, ele exige que cada API tenha um token valido
  Middleware get verifyJwt;
  //2 o middleware de autorizacao para cada API, caso tenha dado tudo certo no primeiro middleware
  Middleware get authorization;
}
