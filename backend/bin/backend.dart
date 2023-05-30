import 'package:mysql1/mysql1.dart';
import 'package:password_dart/password_dart.dart';
import 'package:shelf/shelf.dart';
import 'apis/noticias_api.dart';
import 'apis/login_api.dart';
import 'apis/usuario_api.dart';
import 'dao/usuario_dao.dart';
import 'infra/custom_server.dart';
import 'infra/database/db_configuration.dart';
import 'infra/database/mysql_db_configuration.dart';
import 'infra/dependency_injector/injects.dart';
import 'infra/middleware_interception.dart';
import 'models/usuario_model.dart';
import 'utils/custom_env.dart';

void main() async {
  // CustomEnv.fromFile('.env-dev');

  /* var result = Password.hash('12345678A', PBKDF2());
  print(result);
  bool r = Password.verify('12345678a', result);
  print(r);*/

//container que injeta minhas instancias
  final _di = Injects.initialized();

//adiciono varios handlers e no final me devolve um handler
  var cascadeHandler = Cascade()
      .add(
        _di.get<LoginApi>().getHandler(isSecurity: false),
      ) //precisa saber quem ta implementando o cara do contrato security
      .add(_di.get<NoticiasApi>().getHandler(isSecurity: true))
      .add(_di.get<UsuarioApi>().getHandler(isSecurity: true))
      .handler;

//junta middleware e uma cascata de handler (um handler)
  var handler = Pipeline()
      .addMiddleware(logRequests()) //global Middlewares
      //global Middlewares para transformar os arquivos devolvidos em json
      .addMiddleware(MInterception.contentTypeJson) //global Middlewares
      //middleware do CORS
      .addMiddleware(MInterception.cors) //global Middlewares
      .addHandler(cascadeHandler);

//passo para o servidor mmeus handles e os middlewares de seguranca
  await CustomServer().initialize(
      handler: handler,
      address: await CustomEnv.get<String>(key: 'server_address'),
      port: await CustomEnv.get<int>(key: 'server_port'));
}








/**
 * 
 * 
 *   UsuarioDao _usuarioDAO = UsuarioDao(_di<DBConfiguration>());
  // (await _usuarioDAO.findAll()).forEach(print);

  var usuario = UsuarioModel()
    ..nome = 'João Batista'
    ..email = 'jb@gmail.com'
    ..password = '12345678';
  //await _usuarioDAO.delete(40).then(print);
  //await _usuarioDAO.update(usuario).then(print);
  //await _usuarioDAO.create(usuario).then(print);
  //print(await _usuarioDAO.findOne(5));
  // (await _usuarioDAO.findAll()).forEach(print);

*/