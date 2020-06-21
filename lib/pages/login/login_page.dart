import 'package:flutter/material.dart';
import 'package:flutter_sqlite/data/database-helper.dart';
import 'package:flutter_sqlite/models/user.dart';
import 'package:flutter_sqlite/pages/login/login_presenter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginPageContract {
  BuildContext _ctx;
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  String _email, _password, _cpf, _telefone;

  LoginPagePresenter _presenter;

  _LoginPageState() {
    _presenter = new LoginPagePresenter(this);
  }

  void _register() {
    Navigator.of(context).pushNamed("/register");
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        _presenter.doLogin(_email, _password, _cpf, _telefone);
      });
    }
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    var loginBtn = new RaisedButton(
      onPressed: _submit,
      child: Text(
        "  Entrar       ",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black38,
          fontSize: 20,
        ),
        textAlign: TextAlign.center,
      ),
    );
    var registerBtn = new RaisedButton(
      padding: const EdgeInsets.all(10.0),
      onPressed: _register,
      child: Text(
        "  Cadastrar  ",
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
          "Página de Login",
          textScaleFactor: 2.0,
        ),
        new Form(
          key: formKey,
          child: new Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(15.0),
                child: new TextFormField(
                  onSaved: (val) => _email = val,
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
              )
            ],
          ),
        ),
        new Padding(
            padding: const EdgeInsets.all(10.0),
            child: loginBtn),

        registerBtn
      ],
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Página de Login"),
      ),
      key: scaffoldKey,
      body: new Container(
        child: new Center(
          child: loginForm,
        ),
      ),
    );
  }

  @override
  void onLoginError(String error) {
    // TODO: implement onLoginError
    _showSnackBar("Login não efetuado");
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onLoginSuccess(User user) async {
    // TODO: implement onLoginSuccess
    if(user.username == ""){
      _showSnackBar("Login efetuado");
    }else{
    _showSnackBar(user.toString());
    }
    setState(() {
      _isLoading = false;
    });
    if(user.flaglogged == "logged"){
      print("Login efetuado com sucesso");
      Navigator.of(context).pushNamed("/home");
    }else{
      print("Dados Incorretos");
    }
  }
}
