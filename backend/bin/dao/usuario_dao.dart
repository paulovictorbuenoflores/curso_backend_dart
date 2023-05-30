import '../infra/database/db_configuration.dart';
import '../models/usuario_model.dart';
import 'dao.dart';

class UsuarioDao implements DAO<UsuarioModel> {
  final DBConfiguration _dbConfiguration;

  UsuarioDao(this._dbConfiguration);

  @override
  Future<bool> create(UsuarioModel value) async {
    var result = await _dbConfiguration.execQuery(
      'INSERT INTO usuarios (nome, email, password) VALUES (?, ?, ?)',
      [value.nome, value.email, value.password],
    );
    return result.affectedRows > 0;
  }

  @override
  Future<List<UsuarioModel>> findAll() async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM usuarios');
    List<UsuarioModel> _usuarios = [];
    return result
        .map((r) => UsuarioModel.fromMap(r.fields))
        .toList()
        .cast<UsuarioModel>();

    /*
    for (var r in result) {
      _usuarios.add(UsuarioModel.fromMap(r.fields));
    }
    return _usuarios;*/
  }

  @override
  Future<UsuarioModel?> findOne(int id) async {
    var result = await _dbConfiguration
        .execQuery('SELECT * FROM usuarios WHERE id = ?', [id]);

    return result.length == 0
        ? null
        : UsuarioModel.fromMap(result.first.fields);
  }

  @override
  Future<bool> update(UsuarioModel value) async {
    var result = await _dbConfiguration.execQuery(
      'UPDATE usuarios set nome = ?, password = ? where id = ?',
      [value.nome, value.password, value.id],
    );
    return result.affectedRows > 0;
  }

  @override
  Future<bool> delete(int id) async {
    var result = await _dbConfiguration
        .execQuery('DELETE from usuarios where id = ?', [id]);
    return result.affectedRows > 0;
  }

  Future<UsuarioModel?> findByEmail(String email) async {
    var r = await _dbConfiguration
        .execQuery('SELECT * FROM usuarios WHERE email = ?', [email]);
    return r.length == 0 ? null : UsuarioModel.fromEmail(r.first.fields);
  }

  /* _execQuery(String sql, [List? params]) async {
    var conection = await _dbConfiguration.connection;
    return await conection.query(sql, params);
  }*/
}
