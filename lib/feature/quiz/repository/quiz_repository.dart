import 'dart:io';

import 'package:simplilearn/feature/quiz/model/course_wth_quiz.dart';

import '../model/quiz_model.dart';
import '../bloc/quiz_state.dart';

import '../../../utils/shared_value.dart';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'dart:convert';

class QuizRepository {
  final http.Client client;

  QuizRepository({@required http.Client client})
      : assert(client != null),
        this.client = client;

  Future<QuizState> requestQuiz(String course_id) async {
    var headers = {'Content-Type': 'application/json'};

    String user_id = SharedValue.getUserId();
    var request = http.Request('POST', Uri.parse('http://asti-graphql.herokuapp.com/graphql'));
    request.body =
        '''{"query":"{\\r\\n  courseById(_id : \\"$course_id\\"){\\r\\n    _id\\r\\n    title\\r\\n    quiz{\\r\\n      _id\\r\\n      order\\r\\n      title\\r\\n      question{\\r\\n        _id\\r\\n        order\\r\\n        question\\r\\n        answer\\r\\n        a\\r\\n        b\\r\\n        c\\r\\n        d\\r\\n      }\\r\\n    }\\r\\n  }\\r\\n}","variables":{}}''';

    request.headers.addAll(headers);

    http.StreamedResponse response;
    try {
      response = await request.send();
    } catch (e) {
      return QuizError(message: "Periksa Koneksi Internet Anda");
    }

    if (response.statusCode == 200) {
      try {
        String body = await response.stream.bytesToString();

        var quizList = json.decode(body)["data"]["courseById"];
        CourseWithQuiz quizTmp = CourseWithQuiz.fromJson(quizList);
        return QuizLoaded(courseWithQuiz: quizTmp);
      } catch (e) {
        return QuizError(message: e.toString());
      }
    } else {
      return QuizError(message: "server error");
    }
  }

  Future<AddQuizState> addQuiz(String id_project) async {
    var headers = {'Content-Type': 'application/json'};

    String user_id = SharedValue.getUserId();
    var request = http.Request('POST', Uri.parse('http://asti-graphql.herokuapp.com/graphql'));
    request.body =
        '''{"query":"{\\r\\n      userByParam(_id : \\"$user_id\\"){\\r\\n        enrollment{\\r\\n          _id\\r\\n          status\\r\\n          materi\\r\\n          quiz{\\r\\n            _id\\r\\n          }\\r\\n          quiz{\\r\\n            _id\\r\\n            score\\r\\n          }\\r\\n          course{\\r\\n            _id\\r\\n            type\\r\\n            title\\r\\n            description\\r\\n            bab{\\r\\n              materi{\\r\\n                _id\\r\\n              }\\r\\n            }\\r\\n            quiz{\\r\\n              _id\\r\\n            }\\r\\n          }\\r\\n          class{\\r\\n            _id\\r\\n            name\\r\\n            instructor{\\r\\n              _id\\r\\n              name\\r\\n              email\\r\\n            }\\r\\n            quiz{\\r\\n              _id\\r\\n            }\\r\\n          }\\r\\n        }\\r\\n      }\\r\\n    }","variables":{}}''';

    request.headers.addAll(headers);

    http.StreamedResponse response;
    try {
      print("try 1");
      response = await request.send();
    } catch (e) {
      return AddQuizError(message: "Periksa Koneksi Internet Anda");
    }

    if (response.statusCode == 200) {
      try {
        String body = await response.stream.bytesToString();

        var quizList = json.decode(body)["data"] as List;
        List<QuizModel> quizTmp = quizList.map((i) => QuizModel.fromJson(i)).toList();
        return AddQuizSuccess(message: "Quiz Success");
      } catch (e) {
        return AddQuizError(message: e.toString());
      }
    } else {
      return AddQuizError(message: "server error");
    }
  }
}
