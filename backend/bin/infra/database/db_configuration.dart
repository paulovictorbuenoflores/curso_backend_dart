abstract class DBConfiguration {
  //metodo que cria conexao
  Future<dynamic> createConnection();

  //get conexao aberta conexao ja configurada
  Future<dynamic> get connection;
}
