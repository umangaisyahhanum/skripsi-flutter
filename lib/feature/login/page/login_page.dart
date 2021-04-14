import 'package:flutter/gestures.dart';
import 'package:simplilearn/feature/login/bloc/login_bloc.dart';
import 'package:simplilearn/feature/login/bloc/login_state.dart';
import 'package:simplilearn/feature/menu/bottom_menu_page.dart';
import 'package:simplilearn/feature/register/page/register_page.dart';
import 'package:simplilearn/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _obsecureText = true;
  String username, password;

  LoginBloc _loginBloc = sl<LoginBloc>();

  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  void checkLogin() async {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String user_id = prefs.getString('user_id');
      print(user_id);
      if (user_id != null) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => BottomMenu()));
      }
    });
  }

  Widget usernameTextInput() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Username",
        prefixIcon: Icon(Icons.person),
        fillColor: Colors.white,
        filled: true,
      ),
      maxLines: 1,
      onSaved: (username) {
        this.username = username;
      },
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value.isEmpty) {
          return 'Username tidak boleh kosong';
        }
        return null;
      },
    );
  }

  Widget passwordTextInput() {
    return TextFormField(
      obscureText: _obsecureText,
      decoration: InputDecoration(
        hintText: "Password",
        fillColor: Colors.white,
        filled: true,
        suffixIcon: IconButton(
          icon: Icon(_obsecureText ? Icons.visibility_off : Icons.visibility),
          color: Colors.grey,
          onPressed: () {
            setState(() {
              _obsecureText = !_obsecureText;
            });
          },
        ),
        prefixIcon: Icon(
          Icons.lock,
        ),
      ),
      maxLines: 1,
      onSaved: (password) {
        this.password = password;
      },
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value.isEmpty) {
          return 'Password tidak boleh kosong';
        }
        return null;
      },
    );
  }

  Widget loginButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8),
      child: RaisedButton(
        color: Colors.blue,
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            _loginBloc.getLogin(username, password);
          }
        },
        child: Text(
          'Submit',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  void navigate() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => BottomMenu()));
    });
  }

  Padding bottomNavBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            text: new TextSpan(
              // Note: Styles for TextSpans must be explicitly defined.
              // Child text spans will inherit styles from parent
              style: new TextStyle(
                fontSize: 11.0,
                color: Colors.white,
              ),
              children: <TextSpan>[
                new TextSpan(
                  text: 'Don\'t Have an account?  ',
                  style: new TextStyle(fontWeight: FontWeight.w200, fontSize: 15),
                ),
                new TextSpan(
                  text: 'Register  ',
                  style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => RegisterPage()));
                    },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showSnackbar(String value) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(value),
        duration: Duration(seconds: 1),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      bottomNavigationBar: bottomNavBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 70),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 48,
                ),
                Text(
                  "SIMPLILEARN",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w600),
                ),
                Container(
                  height: 48,
                ),
                usernameTextInput(),
                SizedBox(
                  height: 20,
                ),
                passwordTextInput(),
                SizedBox(
                  height: 30,
                ),
                // loginButton(),
                SizedBox(
                  width: double.infinity,
                  child: StreamBuilder<LoginState>(
                    initialData: _loginBloc.initialState,
                    stream: _loginBloc.loginState,
                    builder: (context, snapshot) {
                      if (snapshot.data is LoginError) {
                        _showSnackbar((snapshot.data as LoginError).message);
                      } else if (snapshot.data is LoginLoaded) {
                        navigate();
                      } else if (snapshot.data is LoginEmailNotRegistered) {
                        _showSnackbar("Email Tidak Terdaftar");
                      } else if (snapshot.data is LoginWrongPassword) {
                        _showSnackbar("Password Salah");
                      }

                      return TextButton(
                        onPressed: () {
                          if (!(snapshot.data is LoginLoading)) {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              _loginBloc.getLogin(username, password);
                            }
                          }
                        },
                        child: snapshot.data is LoginLoading
                            ? CircularProgressIndicator()
                            : Text(
                                "Masuk",
                                style: TextStyle(color: Colors.white, fontSize: 18),
                              ),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          primary: Colors.white,
                          backgroundColor: Theme.of(context).primaryColorDark,
                          onSurface: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
