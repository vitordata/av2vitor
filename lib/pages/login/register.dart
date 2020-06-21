import 'package:flutter/material.dart';
import 'package:flutter_sqlite/data/database-helper.dart';
import 'package:flutter_sqlite/models/user.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => new _RegisterPageState();
}

class _RegisterPageState  extends State<RegisterPage> {
  BuildContext _ctx;
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String _name, _username, _password, _cpf, _telefone;

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    var loginBtn = new RaisedButton(
      onPressed: _submit,
      child: Text(
        "Cadastrar",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black38,
          fontSize: 20,
        ),
        textAlign: TextAlign.center,
      ),
    );

    var loginForm = new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 30,
        ),
        new Text(
          "Página de Cadastro",
          textScaleFactor: 2.0,
        ),
        new Form(
          key: formKey,
          child: new Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(15.0),
                child: new TextFormField(
                  onSaved: (val) => _name = val,
                  decoration: InputDecoration(
                    labelText: "Nome",
                    labelStyle: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(15.0),
                child: new TextFormField(
                  onSaved: (val) => _username = val,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "E-mail",
                    labelStyle: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(15.0),
                child: new TextFormField(
                  onSaved: (val) => _password = val,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Senha",
                    labelStyle: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(15.0),
                child: new TextFormField(
                  onSaved: (val) => _cpf = val,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "CPF",
                    labelStyle: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(15.0),
                child: new TextFormField(
                  onSaved: (val) => _telefone = val,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Telefone",
                    labelStyle: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        loginBtn
      ],
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Cadastrar"),
      ),
      key: scaffoldKey,
      body: new Container(
        child: new Center(
          child: loginForm,
        ),
      ),
    );
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }

  void _submit(){
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        var user = new User(_name, _username, _password, _cpf, _telefone, null);
        var db = new DatabaseHelper();
        db.saveUser(user);
        _isLoading = false;
        Navigator.of(context).pushNamed("/login");
      });
    }
  }
}