import 'package:flutter/gestures.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simplilearn/feature/login/page/login_page.dart';
import 'package:simplilearn/feature/menu/bottom_menu_page.dart';

import '../bloc/register_bloc.dart';
import '../model/register_model.dart';
import '../bloc/register_state.dart';
import 'package:simplilearn/injection_container.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({
    Key key,
  }) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _obsecureText = true;
  String username, password, email, phone, repassword;

  RegisterBloc _registerBloc = sl<RegisterBloc>();

  @override
  void initState() {
    checkRegister();
    super.initState();
  }

  void checkRegister() async {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String user_id = prefs.getString('user_id');
      if (user_id != null) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => BottomMenu()));
      }
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
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
                    },
                ),
              ],
            ),
          ),
        ],
      ),
    );
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

  Widget emailTextInput() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Email",
        prefixIcon: Icon(Icons.email),
        fillColor: Colors.white,
        filled: true,
      ),
      maxLines: 1,
      onSaved: (email) {
        this.email = email;
      },
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value.isEmpty) {
          return 'Email tidak boleh kosong';
        }
        return null;
      },
    );
  }

  Widget phoneTextInput() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Phone Number",
        prefixIcon: Icon(Icons.phone),
        fillColor: Colors.white,
        filled: true,
      ),
      maxLines: 1,
      onSaved: (phone) {
        this.phone = phone;
      },
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value.isEmpty) {
          return 'Phone tidak boleh kosong';
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

  // Widget repasswordTextInput() {
  //   return TextFormField(
  //     obscureText: _obsecureText,
  //     decoration: InputDecoration(
  //       hintText: "Re-Password",
  //       fillColor: Colors.white,
  //       filled: true,
  //       prefixIcon: Icon(
  //         Icons.lock,
  //       ),
  //     ),
  //     maxLines: 1,
  //     onSaved: (repassword) {
  //       this.repassword = repassword;
  //     },
  //     keyboardType: TextInputType.text,
  //     validator: (value) {
  //       if (value.isEmpty) {
  //         return 'Re-Password tidak boleh kosong';
  //       }
  //       if (this.password != null && this.password != value) {
  //         return 'Re-pasword tidak sama';
  //       }
  //       return null;
  //     },
  //   );
  // }

  Widget registerButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8),
      child: RaisedButton(
        color: Colors.blue,
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            _registerBloc.getRegister(email, password, username, phone);
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
                Text(
                  "REGISTER",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w600),
                ),
                Container(
                  height: 48,
                ),
                emailTextInput(),
                SizedBox(
                  height: 20,
                ),
                usernameTextInput(),
                SizedBox(
                  height: 20,
                ),
                phoneTextInput(),
                SizedBox(
                  height: 20,
                ),
                passwordTextInput(),
                SizedBox(
                  height: 30,
                ),
                // registerButton(),
                SizedBox(
                  width: double.infinity,
                  child: StreamBuilder<RegisterState>(
                    initialData: _registerBloc.initialState,
                    stream: _registerBloc.registerState,
                    builder: (context, snapshot) {
                      if (snapshot.data is RegisterError) {
                        _showSnackbar((snapshot.data as RegisterError).message);
                      } else if (snapshot.data is RegisterLoaded) {
                        navigate();
                      } else if (snapshot.data is RegisterEmailIsRegistered) {
                        _showSnackbar("Email sudah Terdaftar");
                      }

                      return TextButton(
                        onPressed: () {
                          if (!(snapshot.data is RegisterLoading)) {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              _registerBloc.getRegister(email, password, username, phone);
                            }
                          }
                        },
                        child: snapshot.data is RegisterLoading
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
