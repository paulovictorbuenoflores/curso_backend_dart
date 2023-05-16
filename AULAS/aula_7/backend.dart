import 'package:shelf/shelf_io.dart' as shelf_io;
import 'server_handler.dart';

void main(List<String> arguments) async {
  var _serve = ServeHandler();

  //pegando do shelf o objeto serve() ele vai devolver uma Feture de httpServer
  //servidor é a primeira porta de entrada para criar um backend
  final server = await shelf_io.serve(_serve.handler, 'localhost', 8080);
  print('Nosso servidor foi iniciado http://localhost:8080');
}
