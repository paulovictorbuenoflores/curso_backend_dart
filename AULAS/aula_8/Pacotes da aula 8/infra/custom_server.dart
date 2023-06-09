import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

//oq essa classe faz? ela vai ser nosso servidor customizado
class CustomServer {
  Future<void> initialize(Handler handler) async {
    String address = 'localhost';
    int port = 8080;

    await shelf_io.serve(handler, address, port);
    print('Servidor inicializado -> http://$address:$port');
  }
}
