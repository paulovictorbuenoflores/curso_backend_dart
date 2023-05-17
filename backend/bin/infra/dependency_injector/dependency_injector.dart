//vamos criar um tipo abstrato, precisamos de uma funcao que receba um tipo e devolva esse tipo
typedef T InstanceCreator<T>();

/*
Criando conteiner de  Injetor de Dependências 
*/
class DependencyInjector {
  DependencyInjector._(); //proibi de usar o construtor, construtor privado;
  static final _singleton = DependencyInjector
      ._(); //vou criar um singleton que vai garantir para nos que sera feito apenas uma instacia dessa classe
  factory DependencyInjector() =>
      _singleton; // devolve a instacia da classe dependecyInjector que foi criada uma unica vez

//um mapa, o mapa vai guardar todas as nossas instancia
  final _instanceMap = Map<Type, _InstanceGenerator<Object>>();

//registrar as nossas instancias, objetos.
  void register<T extends Object>(InstanceCreator<T> instance,
          {bool isSingleton = true}) =>
      _instanceMap[T] = _InstanceGenerator(instance, isSingleton);

//get para devolver a nossa instancia
  T get<T extends Object>() {
    final instance = _instanceMap[T]?.getInstance();
    if (instance != null && instance is T) return instance;
    throw Exception('[ERROR] -> Instance ${T.toString()} not found');
  }
}

//classe privada tem a responsabilidade, pegar nossa instancia, faz uma logica, e devolve a instancia do objeto fabricada
class _InstanceGenerator<T> {
  T? _instance;
  bool _isFirstGet =
      false; //vai dizer se é a primeira vez que o usuario ta pegando essa informacao

  final InstanceCreator<T> _instanceCreator;
  _InstanceGenerator(
      this._instanceCreator,
      bool
          isSingleton) //para saber se é um singleton ou nao, se nao é um singleton entao é uma factory
      : _isFirstGet =
            isSingleton; //depois de criado posso adicionar o resultado do isSingleton no _isFirstGet. Oq isso ta dizendo?  que se  isSingleton for true, o _isFirstGet vai devolver true, sempre devolvo a mesma instancia armazenada no  _isFirstGet

//devolve nossa instancia
  T? getInstance() {
    if (_isFirstGet) {
      _instance = _instanceCreator();
      _isFirstGet = false;
    }
    return _instance != null
        ? _instance
        : _instanceCreator(); // se a nossa instancia for diferente de null, retorna a propria instancia, se for igual a nulo execulte o _instanceCreator, vai criar uma nova instancia e vai devolver
  }
}
