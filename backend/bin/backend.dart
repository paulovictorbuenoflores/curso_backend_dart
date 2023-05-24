import 'package:shelf/shelf.dart';
import 'apis/blog_api.dart';
import 'apis/login_api.dart';
import 'infra/custom_server.dart';
import 'infra/dependency_injector/injects.dart';
import 'infra/middleware_interception.dart';
import 'utils/custom_env.dart';

void main() async {
  // CustomEnv.fromFile('.env-dev');

//container que injeta minhas instancias
  final _di = Injects.initialized();

//adiciono varios handlers e no final me devolve um handler
  var cascadeHandler = Cascade()
      .add(
        _di.get<LoginApi>().getHandler(isSecurity: true),
      ) //precisa saber quem ta implementando o cara do contrato security
      .add(_di.get<BlogApi>().getHandler(isSecurity: false))
      .handler;

//junta middleware e uma cascata de handler (um handler)
  var handler = Pipeline()
      .addMiddleware(logRequests()) //global Middlewares
      .addMiddleware(MiddlewareInterception()
          .middleware) //global Middlewares para transformar os arquivos devolvidos em json
      .addHandler(cascadeHandler);

//passo para o servidor mmeus handles e os middlewares de seguranca
  await CustomServer().initialize(
      handler: handler,
      address: await CustomEnv.get<String>(key: 'server_address'),
      port: await CustomEnv.get<int>(key: 'server_port'));
}
