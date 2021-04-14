import 'dart:io';

import 'package:simplilearn/feature/home/model/course_model.dart';

import '../bloc/home_state.dart';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'dart:convert';

class HomeRepository {
  final http.Client client;

  HomeRepository({@required http.Client client})
      : assert(client != null),
        this.client = client;

  Future<HomeState> requestHome() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('http://asti-graphql.herokuapp.com/graphql'));
    request.body =
        '''{"query":"{\\r\\n    allCourse {\\r\\n        _id\\r\\n        type\\r\\n        title\\r\\n        description\\r\\n        learningpath{\\r\\n            _id\\r\\n          title\\r\\n          description\\r\\n        }\\r\\n        keyfeature{\\r\\n            _id\\r\\n          title\\r\\n        }\\r\\n    }\\r\\n}","variables":{}}''';

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String body = await response.stream.bytesToString();

      var homeList = json.decode(body)["data"]["allCourse"] as List;
      List<CourseModel> homeTmp = homeList.map((i) => CourseModel.fromJson(i)).toList();
      return HomeLoaded(homeList: homeTmp);
    } else {
      return HomeError(message: "server error");
    }
  }
}
