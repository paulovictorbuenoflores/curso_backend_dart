// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UsuarioModel {
  int? id;
  String? nome;
  String? email;
  String? password;
  bool? isActived;
  DateTime? dtCreated;
  DateTime? dtUpdated;
  UsuarioModel();
  UsuarioModel.create(
    this.id,
    this.nome,
    this.email,
    this.isActived,
    this.dtCreated,
    this.dtUpdated,
  );

  @override
  String toString() {
    return 'UsuarioModel(id: $id, nome: $nome, email: $email, isActived: $isActived, dtCreated: $dtCreated, dtUpdated: $dtUpdated)';
  }

  factory UsuarioModel.fromMap(Map<String, dynamic> map) {
    return UsuarioModel.create(
      map['id'] != null ? map['id'] as int : null,
      map['nome'] ?? '',
      map['email'] ?? '',
      map['is_ativo'] == 1,
      map['dt_criacao'],
      map['dt_autalizacao'],
    );
  }

  factory UsuarioModel.fromJson(String source) =>
      UsuarioModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
