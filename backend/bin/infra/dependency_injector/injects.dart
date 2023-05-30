import '../../apis/noticias_api.dart';
import '../../apis/login_api.dart';
import '../../apis/usuario_api.dart';
import '../../dao/noticia_dao.dart';
import '../../dao/usuario_dao.dart';
import '../../models/noticia_model.dart';
import '../../services/generic_service.dart';
import '../../services/login_service.dart';
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

//dependencia Noticias
    di.register<NoticiaDao>(() => NoticiaDao(di.get<DBConfiguration>()));
    di.register<GenericService<NoticiaModel>>(
        () => NoticiaService(di.get<NoticiaDao>()));
    di.register<NoticiasApi>(
        () => NoticiasApi(di.get<GenericService<NoticiaModel>>()));

//sempre registrar de tras para frente!
//camada mais externa, usuarioDAO
    di.register<UsuarioDao>(() => UsuarioDao(di<DBConfiguration>()));
//camada de servico,
    di.register<UsuarioService>(() => UsuarioService(di<UsuarioDao>()));
//ultima camada a de API
    di.register<UsuarioApi>(() => UsuarioApi(di<UsuarioService>()));

//dependecia do login criado depois do usuario, porque ele utiliza o usuario
    di.register<LoginService>(() => LoginService(di.get<UsuarioService>()));
    di.register<LoginApi>(
        () => LoginApi(di.get<SecurityService>(), di.get<LoginService>()));

    return di;
  }
}
