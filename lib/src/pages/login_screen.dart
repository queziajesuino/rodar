import 'package:flutter/material.dart';
import 'package:rodar/src/domain/login_service.dart';
import 'package:rodar/src/domain/user.dart';
import 'package:rodar/src/ui/flushbar.dart';

import '../mixins/validation.dart';
import 'home_page.dart';

class LoginScreen extends StatefulWidget {
  //route to login screen
  static String route = '/loginScreen';

  //@override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Validation {
  //key created to validate input
  final formKey = GlobalKey<FormState>();
  final _tLogin = new TextEditingController();
  final _tPassword = new TextEditingController();

  //password visibility
  bool obscurePassword = true;

  //node created to request focus from the next form
  FocusNode userFocusNode = new FocusNode();
  FocusNode passwordFocusNode = new FocusNode();

  //form builder
  Widget formBuilder(TextInputType keyboardType, TextEditingController textEdit,
      Function validator, String labelText, bool obscureText,
      {FocusNode focusNode, Widget suffixIcon}) {
    return new Container(
      margin: new EdgeInsets.only(bottom: 20.0),
      child: new TextFormField(
        controller: textEdit,
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator,
        decoration: new InputDecoration(
          labelText: labelText,
          filled: true,
          border: InputBorder.none,
          suffixIcon: suffixIcon,
        ),
        focusNode: focusNode,
      ),
    );
  }

//function to show or hide password
  void toggleObscure() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        title: new Text('RodarAPP'),
      ),
      //listview created to not give overflow error when the keyboard appears
      body: new ListView(
        padding: new EdgeInsets.all(40.0),
        children: <Widget>[
          new Builder(
            builder: (BuildContext context) {
              return new GestureDetector(
                onTap: () {
                  //node created to request focus from the screen
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                //manages the entire form
                child: new Form(
                  key: formKey,
                  child: new Column(
                    children: <Widget>[
                      //email form
                      formBuilder(TextInputType.text, _tLogin, validateUsername,
                          'Usuário', false),
                      //password form
                      formBuilder(
                        TextInputType.text,
                        _tPassword,
                        validatePassword,
                        'Password',
                        //controlled by toggleObscure function
                        obscurePassword,
                        suffixIcon: new IconButton(
                          //calls toggleObscure function to enable or disable obscureText parameter
                          onPressed: toggleObscure,
                          icon: Icon(
                              //changes the icon
                              obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                          tooltip: obscurePassword ? 'Show' : 'Hide',
                        ),
                        //referencing password focus
                        focusNode: passwordFocusNode,
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new RaisedButton(
                            child: new Text('Login'),
                            onPressed: () {
                              //method to validate forms
                              if (formKey.currentState.validate()) {
                                //method to save forms
                                formKey.currentState.save();
                                _onClickLogin(context);
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _onClickLogin(BuildContext context) async {
    final user = _tLogin.text;
    final password = _tPassword.text;

    final response = await LoginService.login(user, password);

    if (response.isOk()) {
      setState(() {
        final parceiro = User(
          response.nome , user, response.email, response.id_parceiro);
        parceiro.save();
        var route = new MaterialPageRoute(
            builder: (BuildContext context) => HomePage(response.id_parceiro));
        Navigator.pushReplacement(context, route);
      });
    } else {
      Flushbar(
        message: "Usuário ou senha estão errados. Não consta nosso Sistem",
        duration: Duration(seconds: 3),
      )..show(context);
    }
  }
}
