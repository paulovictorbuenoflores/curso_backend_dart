import 'dart:ffi';

import '../dao/noticia_dao.dart';
import '../models/noticia_model.dart';
import 'generic_service.dart';
import '../utils/list_extension.dart';

class NoticiaService implements GenericService<NoticiaModel> {
  final NoticiaDao _noticiaDao;
  NoticiaService(this._noticiaDao);
  @override
  Future<bool> delete(int id) async {
    return _noticiaDao.delete(id);
  }

  @override
  Future<List<NoticiaModel>> findAll() async {
    return _noticiaDao.findAll();
  }

  @override
  Future<bool> save(value) async {
    if (value.id != null) {
      _noticiaDao.update(value);
    } else {
      _noticiaDao.create(value);
    }

    return true;
  }

  @override
  Future<NoticiaModel?> findOne(int id) async {
    return _noticiaDao.findOne(id);
  }
}
