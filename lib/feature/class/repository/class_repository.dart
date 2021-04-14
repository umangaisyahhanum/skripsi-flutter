import 'dart:io';

import '../model/course_model.dart';
import '../model/enrollment_model.dart';
import '../../../utils/shared_value.dart';

import '../bloc/class_state.dart';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'dart:convert';

class ClassRepository {
  final http.Client client;

  ClassRepository({@required http.Client client})
      : assert(client != null),
        this.client = client;

  Future<ClassState> requestClass() async {
    var headers = {'Content-Type': 'application/json'};

    String user_id = SharedValue.getUserId();
    var request = http.Request('POST', Uri.parse('http://asti-graphql.herokuapp.com/graphql'));
    request.body =
        '''{"query":"{\\r\\n      userByParam(_id : \\"$user_id\\"){\\r\\n        enrollment{\\r\\n          _id\\r\\n          status\\r\\n          materi\\r\\n          task{\\r\\n            _id\\r\\n          }\\r\\n          quiz{\\r\\n            _id\\r\\n            score\\r\\n          }\\r\\n          course{\\r\\n            _id\\r\\n            type\\r\\n            title\\r\\n            description\\r\\n            bab{\\r\\n              materi{\\r\\n                _id\\r\\n              }\\r\\n            }\\r\\n            quiz{\\r\\n              _id\\r\\n            }\\r\\n          }\\r\\n          class{\\r\\n            _id\\r\\n            name\\r\\n            instructor{\\r\\n              _id\\r\\n              name\\r\\n              email\\r\\n            }\\r\\n            task{\\r\\n              _id\\r\\n            }\\r\\n          }\\r\\n        }\\r\\n      }\\r\\n    }","variables":{}}''';

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String body = await response.stream.bytesToString();

      var tmp = json.decode(body)["data"]["userByParam"]["enrollment"] as List;
      var classList = tmp.where((i) => i["status"] == "2").toList();
      List<EnrollmentModel> classTmp = classList.map((i) => EnrollmentModel.fromJson(i)).toList();
      return ClassLoaded(classList: classTmp);
    } else {
      
      return ClassError(message: "server error");
    }
  }
}
