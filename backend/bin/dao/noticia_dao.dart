import '../infra/database/db_configuration.dart';
import '../models/noticia_model.dart';
import 'dao.dart';

class NoticiaDao implements DAO<NoticiaModel> {
  final DBConfiguration _dbConfiguration;
  NoticiaDao(this._dbConfiguration);

  @override
  Future<bool> create(NoticiaModel value) async {
    var result = await _dbConfiguration.execQuery(
      'INSERT INTO noticias (titulo, descricao, id_usuario) VALUES (?, ?, ?)',
      [value.titulo, value.descricao, value.userId],
    );
    return result.affectedRows > 0;
  }

  @override
  Future<List<NoticiaModel>> findAll() async {
    var result = await _dbConfiguration.execQuery('SELECT * FROM noticias');
    List<NoticiaModel> _usuarios = [];
    return result
        .map((r) => NoticiaModel.fromMap(r.fields))
        .toList()
        .cast<NoticiaModel>();
  }

  @override
  Future<NoticiaModel?> findOne(int id) async {
    var result = await _dbConfiguration
        .execQuery('SELECT * FROM noticias WHERE id = ?', [id]);

    return result.isEmpty || result.length == 0
        ? null
        : NoticiaModel.fromMap(result.first.fields);
  }

  @override
  Future<bool> update(NoticiaModel value) async {
    var result = await _dbConfiguration.execQuery(
      'UPDATE noticias set titulo = ?, descricao = ? where id = ?',
      [value.titulo, value.descricao, value.id],
    );
    return result.affectedRows > 0;
  }

  @override
  Future<bool> delete(int id) async {
    var result = await _dbConfiguration
        .execQuery('DELETE from noticias where id = ?', [id]);
    return result.affectedRows > 0;
  }
}
