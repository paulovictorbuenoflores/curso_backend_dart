import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf/shelf.dart';

import 'server_handler.dart'; //shelf é o pacote que tem tudo disponivel para criar o servidor

void main(List<String> arguments) async {
  var _serve = ServeHandler();

  //pegando do shelf o objeto serve() ele vai devolver uma Feture de httpServer
  //servidor é a primeira porta de entrada para criar um backend
  //nesta aula criaremos nossas primeiras APIs, _serve.handler
  final server = await shelf_io.serve(_serve.handler, 'localhost', 8080);
  print('Nosso servidor foi iniciado http://localhost:8080');
}
