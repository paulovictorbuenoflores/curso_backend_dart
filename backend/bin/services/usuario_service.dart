import 'package:password_dart/password_dart.dart';

import '../dao/usuario_dao.dart';
import '../models/usuario_model.dart';
import 'generic_service.dart';

class UsuarioService implements GenericService<UsuarioModel> {
  final UsuarioDao _usuarioDAO;
  UsuarioService(this._usuarioDAO);

  @override
  Future<bool> delete(int id) async => await _usuarioDAO.delete(id);

  @override
  Future<List<UsuarioModel>> findAll() async => await _usuarioDAO.findAll();

  @override
  Future<UsuarioModel?> findOne(int id) async => await _usuarioDAO.findOne(id);

  @override
  Future<bool> save(UsuarioModel value) async {
    //como sei se ta criando ou atualizando usuario? pelo id, usuario novo nunca tem id
    if (value.id != null) {
      return _usuarioDAO.update(value);
    } else {
      final hash = Password.hash(value.password!, PBKDF2());
      value.password = hash;
      return _usuarioDAO.create(value);
    }
  }

  Future<UsuarioModel?> findByEmail(String email) async =>
      await _usuarioDAO.findByEmail(email);
}
