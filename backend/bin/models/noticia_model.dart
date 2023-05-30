// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NoticiaModel {
  int? id;
  String? titulo;
  String? descricao;
  DateTime? dtCreated;
  DateTime? dtUpdate;
  int? userId;

  NoticiaModel();
  NoticiaModel.create(
    this.id,
    this.titulo,
    this.descricao,
    this.dtCreated,
    this.dtUpdate,
    this.userId,
  );
//map['dtCreated'] != null ? DateTime.fromMillisecondsSinceEpoch(map['dtCreated'] as int) : null,
  factory NoticiaModel.fromMap(Map map) {
    return NoticiaModel()
      ..id = map['id']?.toInt()
      ..titulo = map['titulo']
      ..descricao = map['descricao'].toString()
      ..dtCreated = map['dt_criacao']
      ..dtUpdate = map['dt_autalizacao']
      ..userId = map['id_usuario']?.toInt();
  }
  factory NoticiaModel.fromJson(String source) =>
      NoticiaModel.fromMap(json.decode(source) as Map<String, dynamic>);
  Map toJson() {
    return {'id': id, 'titulo': titulo, 'descricao': descricao};
  }

  factory NoticiaModel.fromRequest(Map map) {
    return NoticiaModel()
      ..id = map['id']?.toInt()
      ..titulo = map['titulo']
      ..descricao = map['descricao']
      ..userId = map['id_usuario']?.toInt();
  }

  @override
  String toString() {
    return 'NoticiaModel(id: $id, titulo: $titulo, descricao: $descricao, dtCreated: $dtCreated, dtUpdate: $dtUpdate, userId: $userId)';
  }
}
