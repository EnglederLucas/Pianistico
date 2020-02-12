import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:pianistico/auth/auth.dart';
import 'package:pianistico/auth/signup_page.dart';
import 'package:pianistico/home.dart';
import 'package:pianistico/widgets/layout.dart';

class LoginPage extends StatefulWidget {

  LoginPage({this.auth});
  final Auth auth;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _key = GlobalKey<FormState>();
  String _email;
  String _password;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Form(
            key: _key,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 50, 20, 50),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text("LOGIN"),
                      _inputEmail(),
                      _inputPassword(),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          children: <Widget>[
                            _submitBtn(),
                            FlatButton(
                              child: Text("No account yet?"),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => SignupPage()
                                ));
                              },
                          ),
                        ]),
                      ),
                      TextDivider(text: "or login with"),
                      GoogleSignInButton(
                        darkMode: true,
                        onPressed: signInWithGoogle,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          _circularProgress()
        ],
      )
    );
  }

  Widget _inputEmail(){
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      autocorrect: true,
      decoration: InputDecoration(
        hintText: "Email"
      ),
      onSaved: (value) => _email = value,
      validator: (text) {
        if(text.isEmpty)
          return 'This field is mandatory';

        return null;
      },
    );
  }

  Widget _inputPassword(){
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
          hintText: "Password"
      ),
      onSaved: (value) => _password = value,
      validator: (text) {
        if(text.isEmpty)
          return 'This field is mandatory';

        return null;
      },
    );
  }

  Widget _submitBtn(){
    return RaisedButton(
      child: Text("SUBMIT"),
      onPressed: submit
    );
  }

  Widget _circularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  void submit() async {
    setState(() {
      _isLoading = true;
    });
    if(_key.currentState.validate()) {
      _key.currentState.save();
      String userId = "";
      try {
        print(_email);
        userId = await widget.auth.signIn(_email, _password);
        print('Signed in: $userId');
        setState(() {
          _isLoading = false;
        });

      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          //_key.currentState.reset();
        });
      }
    }
  }

  void signInWithGoogle() async {
    navigateToHome(await widget.auth.signInWithGoogle().catchError((err) {
      print(err);
    }));
  }

  void navigateToHome(FirebaseUser user){
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) => HomePage(user: user)
    ));
  }
}
