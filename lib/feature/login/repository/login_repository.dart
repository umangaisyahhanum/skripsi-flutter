import 'dart:io';

import 'package:simplilearn/utils/shared_value.dart';

import '../model/login_model.dart';
import '../bloc/login_state.dart';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'dart:convert';

class LoginRepository {
  final http.Client client;

  LoginRepository({@required http.Client client})
      : assert(client != null),
        this.client = client;

  Future<LoginState> requestLogin(String email, String password) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('http://asti-graphql.herokuapp.com/graphql'));
    request.body =
        '''{"query":"{\\r\\n    userByParam( email: \\"$email\\") {\\r\\n        _id\\r\\n        email\\r\\n        password\\r\\n    }\\r\\n}","variables":{}}''';

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String body = await response.stream.bytesToString();

      if (json.decode(body)["data"]["userByParam"]["_id"] == null) {
        return LoginEmailNotRegistered();
      } else if (json.decode(body)["data"]["userByParam"]["password"] != password) {
        return LoginWrongPassword();
      } else if (json.decode(body)["data"]["userByParam"]["password"] == password) {
        SharedValue.setUserId(json.decode(body)["data"]["userByParam"]["_id"]);
        SharedValue.setUserEmail(json.decode(body)["data"]["userByParam"]["email"]);
        return LoginLoaded();
      }
    } else {
      return LoginError(message: "server error");
    }
  }
}
