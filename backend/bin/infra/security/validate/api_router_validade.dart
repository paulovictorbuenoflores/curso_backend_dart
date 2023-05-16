//solucao, no java temos o spring-security que tem um arquivo falando qual rota é privada e qual delas sao publica
//vamos fazer algo parecido aqui também

class ApiRouterValidate {
  final List<String> _rotas = [];

  //padrao build,  vou adicionar varias rotas e retornar eu mesmo
  ApiRouterValidate add(String rota) {
    _rotas.add(rota);
    return this;
  }

//se alto valida
  bool isPublic(String rota) {
    return _rotas.contains(rota);
  }
}



          //solucao simples, para problema de barra o login, retorna nulo e nao verifica se tem JWT
          //   if (req.url.path == 'login') return null;