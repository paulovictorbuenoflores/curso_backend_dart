import 'package:shelf/shelf.dart';

import 'api/blog_api.dart';
import 'api/login_api.dart';
import 'infra/custom_server.dart';

void main() async {
  //////////////////////////////// Cascade ////////////////////////////////////////////////////////////////////////////////////////////////////
  // se olharmos na api temos 2 handlers, futuramente teremos mais,
  // mas nosso servidor no seu metodo de initialize recebe somente um handler.
  // Qual a solucao? devemos usar uma cascata de handler para gerenciar nossos handler
  // Criação de handlers, varios handlers trabalhando paralelamente, ou seja, uma cascata.
  // 1 para trabalhar com varios handlers paralelamente, devemos criar uma cascata, uma cascata nada mais é que o padrao builder
  // Uma cascata é o padrao builder de projeto, design Perter builder, onde ele aceita um objeto e devolve o mesmo objeto.
  // O design peter builder, diz eu vou criar objetos e no final eu vou devolver eu mesmo.
  var cascadeHandler =
      Cascade().add(LoginApi().handler).add(BlogApi().handler).handler;

  ////////////////////////////////////////////// Midleware ////////////////////////////////////////////////////////////////////////////////////
  // proximo cara que vamos conhecer é o middleware
  // oque é o midleware? Quando a gente colocar autenticação na nossa API apartir do login,
  // todas as nossas APIs, exemplo as APIs do blog só vao ser possiveis de acessar com autorizacao.
  // Oque isso quer dizer? os get direto que fazemos agora ex: http://localhost:8080/blog/noticias não vai mais funcionar
  // se usuario não tiver altenticado e com tocken valido. Ou seja a rota vai ser protegida no futuro
  // Como a gente verifica se o usuario esta altenticado entre a Request e o Response? essa altenticacao é verificada atraves de um Midleware

  /////////////////////////////////////////// Pipeline ////////////////////////////////////////////////////////////////////////////////////////
  // Proximo cara, Pipeline, oque é uma pipeline do shelf? é um tipo de objeto onde consigo colocar midleware e Handlers

  var handler =
      Pipeline().addMiddleware(logRequests()).addHandler(cascadeHandler);

  await CustomServer().initialize(handler);
}
