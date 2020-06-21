class User {
  String _name;
  String _username;
  String _password;
  String _cpf;
  String _telefone;
  String _flaglogged;



  User(this._name, this._username, this._password, this._cpf, this._telefone, this._flaglogged);

  User.map(dynamic obj) {
    this._name = obj['name'];
    this._username = obj['username'];
    this._password = obj['password'];
    this._cpf = obj['cpf'];
    this._telefone = obj['telefone'];
    this._flaglogged = obj['password'];
  }

  String get name => _name;
  String get username => _username;
  String get password => _password;
  String get cpf => _cpf;
  String get telefone => _telefone;
  String get flaglogged => _flaglogged;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = _name;
    map["username"] = _username;
    map["password"] = _password;
    map["cpf"] = _cpf;
    map["telefone"] = _telefone;
    map["flaglogged"] = _flaglogged;
    return map;
  }
}
