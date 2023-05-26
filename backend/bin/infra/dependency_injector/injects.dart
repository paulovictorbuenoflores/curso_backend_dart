import '../../apis/blog_api.dart';
import '../../apis/login_api.dart';
import '../../apis/usuario_api.dart';
import '../../dao/usuario_dao.dart';
import '../../models/noticia_model.dart';
import '../../services/generic_service.dart';
import '../../services/noticia_service.dart';
import '../../services/usuario_service.dart';
import '../database/db_configuration.dart';
import '../database/mysql_db_configuration.dart';
import '../security/security_service.dart';
import '../security/security_service_imp.dart';
import 'dependency_injector.dart';

class Injects {
  static DependencyInjector initialized() {
    var di = DependencyInjector();

    di.register<DBConfiguration>(() => MySqlDBConfiguration());

//dependencia de seguranca
    di.register<SecurityService>(() => SecurityServiceImp());
//dependecia do login
    di.register<LoginApi>(() => LoginApi(di.get()));

//dependencia do blog
    di.register<GenericService<NoticiaModel>>(() => NoticiaService());
    di.register<BlogApi>(() => BlogApi(di.get()));

//sempre registrar de tras para frente!
//camada mais externa, usuarioDAO
    di.register<UsuarioDao>(() => UsuarioDao(di<DBConfiguration>()));
//camada de servico,
    di.register<UsuarioService>(() => UsuarioService(di<UsuarioDao>()));
//ultima camada a de API
    di.register<UsuarioApi>(() => UsuarioApi(di<UsuarioService>()));
    return di;
  }
}
