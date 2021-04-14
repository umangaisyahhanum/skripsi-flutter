import 'dart:io';

import 'package:simplilearn/feature/task/model/class_with_task.dart';

import '../model/task_model.dart';
import '../bloc/task_state.dart';

import '../../../utils/shared_value.dart';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'dart:convert';

class TaskRepository {
  final http.Client client;

  TaskRepository({@required http.Client client})
      : assert(client != null),
        this.client = client;

  Future<TaskState> requestTask(String class_id) async {
    var headers = {'Content-Type': 'application/json'};

    String user_id = SharedValue.getUserId();
    var request = http.Request('POST', Uri.parse('http://asti-graphql.herokuapp.com/graphql'));
    request.body =
        '''{"query":"{\\r\\n  classById(_id : \\"$class_id\\"){\\r\\n    _id\\r\\n    name\\r\\n    task{\\r\\n      _id\\r\\n      title\\r\\n      description\\r\\n    }\\r\\n  }\\r\\n}","variables":{}}''';

    request.headers.addAll(headers);

    http.StreamedResponse response;
    try {
      print("try 1");
      response = await request.send();
    } catch (e) {
      return TaskError(message: "Periksa Koneksi Internet Anda");
    }

    if (response.statusCode == 200) {
      try {
        String body = await response.stream.bytesToString();

        var taskList = json.decode(body)["data"]["classById"];
        ClassWithTask taskTmp = ClassWithTask.fromJson(taskList);
        return TaskLoaded(classWithTask: taskTmp);
      } catch (e) {
        return TaskError(message: e.toString());
      }
    } else {
      return TaskError(message: "server error");
    }
  }

  Future<AddTaskState> addTask(String id_project) async {
    var headers = {'Content-Type': 'application/json'};

    String user_id = SharedValue.getUserId();
    var request = http.Request('POST', Uri.parse('http://asti-graphql.herokuapp.com/graphql'));
    request.body =
        '''{"query":"{\\r\\n      userByParam(_id : \\"$user_id\\"){\\r\\n        enrollment{\\r\\n          _id\\r\\n          status\\r\\n          materi\\r\\n          task{\\r\\n            _id\\r\\n          }\\r\\n          quiz{\\r\\n            _id\\r\\n            score\\r\\n          }\\r\\n          course{\\r\\n            _id\\r\\n            type\\r\\n            title\\r\\n            description\\r\\n            bab{\\r\\n              materi{\\r\\n                _id\\r\\n              }\\r\\n            }\\r\\n            quiz{\\r\\n              _id\\r\\n            }\\r\\n          }\\r\\n          class{\\r\\n            _id\\r\\n            name\\r\\n            instructor{\\r\\n              _id\\r\\n              name\\r\\n              email\\r\\n            }\\r\\n            task{\\r\\n              _id\\r\\n            }\\r\\n          }\\r\\n        }\\r\\n      }\\r\\n    }","variables":{}}''';

    request.headers.addAll(headers);

    http.StreamedResponse response;
    try {
      print("try 1");
      response = await request.send();
    } catch (e) {
      return AddTaskError(message: "Periksa Koneksi Internet Anda");
    }

    if (response.statusCode == 200) {
      try {
        String body = await response.stream.bytesToString();

        var taskList = json.decode(body)["data"] as List;
        List<TaskModel> taskTmp = taskList.map((i) => TaskModel.fromJson(i)).toList();
        return AddTaskSuccess(message: "Task Success");
      } catch (e) {
        return AddTaskError(message: e.toString());
      }
    } else {
      return AddTaskError(message: "server error");
    }
  }
}
