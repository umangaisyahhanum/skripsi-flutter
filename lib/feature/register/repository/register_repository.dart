import 'dart:io';

import 'package:simplilearn/utils/shared_value.dart';

import '../model/register_model.dart';
import '../bloc/register_state.dart';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'dart:convert';

class RegisterRepository {
  final http.Client client;

  RegisterRepository({@required http.Client client})
      : assert(client != null),
        this.client = client;

  Future<RegisterState> checkEmail(String email, String password, String name, String phonenumber) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('http://asti-graphql.herokuapp.com/graphql'));
    request.body = '''{"query":"{\\r\\n    userByParam(email:\\"$email\\"){ \\r\\n        password \\r\\n    }\\r\\n}","variables":{}}''';

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String body = await response.stream.bytesToString();

      if (json.decode(body)["data"]["userByParam"]["password"] != null) {
        return RegisterEmailIsRegistered();
      } else {
        return requestRegister(email, password, name, phonenumber);
      }
    } else {
      return RegisterError(message: "server error");
    }
  }

  Future<RegisterState> requestRegister(String email, String password, String name, String phonenumber) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('http://asti-graphql.herokuapp.com/graphql'));
    request.body =
        '''{"query":"mutation {           \\r\\n    user_add(       \\r\\n        name: \\"$name\\",              \\r\\n        email: \\"$email\\",              \\r\\n        phonenumber : \\"$phonenumber\\",\\r\\n        password: \\"$password\\")\\r\\n    { _id }          \\r\\n}\\r\\n        ","variables":{}}''';

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String body = await response.stream.bytesToString();

      var userId = json.decode(body)["data"]["user_add"]["_id"];
      SharedValue.setUserId(userId);
      SharedValue.setUserEmail(email);
      return RegisterLoaded();
    } else {
      return RegisterError(message: "server error");
    }
  }
}
