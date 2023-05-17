import 'package:shelf/shelf.dart';

import '../infra/dependency_injector/dependency_injector.dart';
import '../infra/security/security_service.dart';
import '../infra/security/security_service_imp.dart';

abstract class Api {
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false});

  //esse metodo vai devolver um handler
  Handler createHandler({
    required Handler router,
    List<Middleware>? middlewares,
    bool isSecurity = false,
  }) {
    final _di = DependencyInjector();
    var _securityService = _di.get<SecurityService>();

    middlewares ??= [];
    var pipeline = Pipeline();

    middlewares.forEach((m) => pipeline = pipeline.addMiddleware(m));
    return pipeline.addHandler(router);
  }
}
