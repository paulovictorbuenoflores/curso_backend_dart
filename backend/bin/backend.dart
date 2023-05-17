import 'package:shelf/shelf.dart';
import 'apis/blog_api.dart';
import 'apis/login_api.dart';
import 'infra/custom_server.dart';
import 'infra/dependency_injector/injects.dart';
import 'infra/middleware_interception.dart';
import 'utils/custom_env.dart';

void main() async {
  // CustomEnv.fromFile('.env-dev');

  final _di = Injects.initialized();

  var cascadeHandler = Cascade()
      .add(
        _di.get<LoginApi>().getHandler(isSecurity: false),
      ) //precisa saber quem ta implementando o cara do contrato security
      .add(_di.get<BlogApi>().getHandler(isSecurity: true))
      .handler;

  var handler = Pipeline()
      .addMiddleware(logRequests()) //global Middlewares
      .addMiddleware(MiddlewareInterception()
          .middleware) //global Middlewares para transformar os arquivos devolvidos em json
      //.addMiddleware(_securityService.authorization) //global Middlewares de seguranca
      // .addMiddleware(_securityService.verifyJwt) //global Middlewares
      .addHandler(cascadeHandler);

  await CustomServer().initialize(
      handler: handler,
      address: await CustomEnv.get<String>(key: 'server_address'),
      port: await CustomEnv.get<int>(key: 'server_port'));
}
