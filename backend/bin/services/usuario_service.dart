import '../dao/usuario_dao.dart';
import '../models/usuario_model.dart';
import 'generic_service.dart';

class UsuarioService implements GenericService<UsuarioModel> {
  final UsuarioDao _usuarioDAO;
  UsuarioService(this._usuarioDAO);

  @override
  Future<bool> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<UsuarioModel>> findAll() {
    // TODO: implement findAll
    throw UnimplementedError();
  }

  @override
  Future<UsuarioModel> findOne(int id) {
    // TODO: implement findOne
    throw UnimplementedError();
  }

  @override
  Future<bool> save(UsuarioModel value) {
    //como sei se ta criando ou atualizando usuario? pelo id, usuario novo nunca tem id
    if (value.id != null) {
      _usuarioDAO.create(value);
    } else {
      _usuarioDAO.update(value);
    }

    throw UnimplementedError();
  }
}
