import 'dart:io';

import 'package:simplilearn/feature/module/model/courseById_model.dart';
import '../bloc/module_state.dart';

import '../../../utils/shared_value.dart';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'dart:convert';

class ModuleRepository {
  final http.Client client;

  ModuleRepository({@required http.Client client})
      : assert(client != null),
        this.client = client;

  Future<ModuleState> requestModule(String course_id) async {
    var headers = {'Content-Type': 'application/json'};

    String user_id = SharedValue.getUserId();
    var request = http.Request('POST', Uri.parse('http://asti-graphql.herokuapp.com/graphql'));
    request.body =
        '''{"query":"{\\r\\n  courseById(_id : \\"$course_id\\"){\\r\\n    _id\\r\\n    type\\r\\n    title\\r\\n    bab{\\r\\n      _id\\r\\n      name\\r\\n      order\\r\\n      materi{\\r\\n        _id\\r\\n        name\\r\\n        content\\r\\n        order\\r\\n      }\\r\\n    }\\r\\n  }\\r\\n}","variables":{}}''';

    request.headers.addAll(headers);

    http.StreamedResponse response;
    try {
      print("try 1");
      response = await request.send();
    } catch (e) {
      return ModuleError(message: "Periksa Koneksi Internet Anda");
    }

    if (response.statusCode == 200) {
      try {
        String body = await response.stream.bytesToString();

        var moduleList = json.decode(body)["data"]["courseById"];
        CourseByIdModel moduleTmp = CourseByIdModel.fromJson(moduleList);
        return ModuleLoaded(moduleList: moduleTmp);
      } catch (e) {
        return ModuleError(message: e.toString());
      }
    } else {
      return ModuleError(message: "server error");
    }
  }

  // Future<AddModuleState> addModule(String id_project) async {
  //   var headers = {'Content-Type': 'application/json'};

  //   String user_id = SharedValue.getUserId();
  //   var request = http.Request('POST', Uri.parse('http://asti-graphql.herokuapp.com/graphql'));
  //   request.body =
  //       '''{"query":"{\\r\\n      userByParam(_id : \\"$user_id\\"){\\r\\n        enrollment{\\r\\n          _id\\r\\n          status\\r\\n          materi\\r\\n          task{\\r\\n            _id\\r\\n          }\\r\\n          quiz{\\r\\n            _id\\r\\n            score\\r\\n          }\\r\\n          course{\\r\\n            _id\\r\\n            type\\r\\n            title\\r\\n            description\\r\\n            bab{\\r\\n              materi{\\r\\n                _id\\r\\n              }\\r\\n            }\\r\\n            quiz{\\r\\n              _id\\r\\n            }\\r\\n          }\\r\\n          class{\\r\\n            _id\\r\\n            name\\r\\n            instructor{\\r\\n              _id\\r\\n              name\\r\\n              email\\r\\n            }\\r\\n            task{\\r\\n              _id\\r\\n            }\\r\\n          }\\r\\n        }\\r\\n      }\\r\\n    }","variables":{}}''';

  //   request.headers.addAll(headers);

  //   http.StreamedResponse response;
  //   try {
  //     print("try 1");
  //     response = await request.send();
  //   } catch (e) {
  //     return AddModuleError(message: "Periksa Koneksi Internet Anda");
  //   }

  //   if (response.statusCode == 200) {
  //     try {
  //       String body = await response.stream.bytesToString();

  //       var moduleList = json.decode(body)["data"] as List;
  //       List<ModuleModel> moduleTmp = moduleList.map((i) => ModuleModel.fromJson(i)).toList();
  //       return AddModuleSuccess(message: "Module Success");
  //     } catch (e) {
  //       return AddModuleError(message: e.toString());
  //     }
  //   } else {
  //     return AddModuleError(message: "server error");
  //   }
  // }
}
