import 'dart:io';
import 'parser_extensio.dart';

class CustomEnv {
  static Map<String, String> _map = {};
  static String _file = '.env';

//vou deixar o construtor privado, so é acessivel da classe
  CustomEnv._();
// agora usaremos uma factory para fabricar um construtor
  factory CustomEnv.fromFile(String file) {
    _file = file;
    return CustomEnv._();
  }
  static Future<T> get<T>({required String key}) async {
    if (_map.isEmpty) await _load();
    return _map[key]!.toType(T);
  }

  static Future<void> _load() async {
    List<String> linhas = (await _readFile()).split('\n');
    _map = {
      for (var l in linhas) l.split('=')[0]: l.split('=')[1],
    };
  }

  //faz a leitura de um arquivo
  static Future<String> _readFile() async {
    return await File(_file).readAsString();
  }
}
