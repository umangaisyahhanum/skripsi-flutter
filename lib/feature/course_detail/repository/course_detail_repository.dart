import 'dart:io';

import '../model/course_detail_model.dart';
import '../bloc/course_detail_state.dart';

import '../../../utils/shared_value.dart';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'dart:convert';

class CourseDetailRepository {
  final http.Client client;

  CourseDetailRepository({@required http.Client client})
      : assert(client != null),
        this.client = client;

  Future<CourseDetailState> requestCourseDetail(String id_project) async {
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
      return CourseDetailError(message: "Periksa Koneksi Internet Anda");
    }

    if (response.statusCode == 200) {
      try {
        String body = await response.stream.bytesToString();

        var courseDetailList = json.decode(body)["data"] as List;
        List<CourseDetailModel> courseDetailTmp = courseDetailList.map((i) => CourseDetailModel.fromJson(i)).toList();
        return CourseDetailLoaded(courseDetailList: courseDetailTmp);
      } catch (e) {
        return CourseDetailError(message: e.toString());
      }
    } else {
      return CourseDetailError(message: "server error");
    }
  }

  Future<AddCourseDetailState> addCourseDetail(String id_project) async {
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
      return AddCourseDetailError(message: "Periksa Koneksi Internet Anda");
    }

    if (response.statusCode == 200) {
      try {
        String body = await response.stream.bytesToString();

        var courseDetailList = json.decode(body)["data"] as List;
        List<CourseDetailModel> courseDetailTmp = courseDetailList.map((i) => CourseDetailModel.fromJson(i)).toList();
        return AddCourseDetailSuccess(message: "CourseDetail Success");
      } catch (e) {
        return AddCourseDetailError(message: e.toString());
      }
    } else {
      return AddCourseDetailError(message: "server error");
    }
  }
}

