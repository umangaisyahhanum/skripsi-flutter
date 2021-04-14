import 'dart:io';

import 'package:simplilearn/feature/enrollemt/model/enrollment_model.dart';
import 'package:simplilearn/utils/shared_value.dart';

import '../bloc/enrollment_state.dart';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'dart:convert';

class EnrollmentRepository {
  final http.Client client;

  EnrollmentRepository({@required http.Client client})
      : assert(client != null),
        this.client = client;

  Future<EnrollmentState> requestEnrollment() async {
    var headers = {'Content-Type': 'application/json'};
    String user_id = SharedValue.getUserId();
    var request = http.Request('POST', Uri.parse('http://asti-graphql.herokuapp.com/graphql'));
    request.body =
        '''{"query":"{\\r\\n      userByParam(_id : \\"$user_id\\"){\\r\\n        enrollment{\\r\\n          _id\\r\\n          status\\r\\n          course{\\r\\n            _id\\r\\n            title\\r\\n            type\\r\\n          }\\r\\n        }\\r\\n      }\\r\\n    }","variables":{}}''';

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String body = await response.stream.bytesToString();
      var enrollmentList = json.decode(body)["data"]["userByParam"]["enrollment"] as List;
      List<EnrollmentModel> enrollmentTmp = enrollmentList.map((i) => EnrollmentModel.fromJson(i)).toList();
      return EnrollmentLoaded(enrollmentList: enrollmentTmp);
    } else {
      return EnrollmentError(message: "server error");
    }
  }
}
