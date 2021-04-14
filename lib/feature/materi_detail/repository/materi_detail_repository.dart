import 'dart:io';

import '../model/materi_detail_model.dart';
import '../bloc/materi_detail_state.dart';

import '../../../utils/shared_value.dart';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'dart:convert';

class MateriDetailRepository {
  final http.Client client;

  MateriDetailRepository({@required http.Client client})
      : assert(client != null),
        this.client = client;

  Future<MateriDetailState> requestMateriDetail(String id_project) async {
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
      return MateriDetailError(message: "Periksa Koneksi Internet Anda");
    }

    if (response.statusCode == 200) {
      try {
        String body = await response.stream.bytesToString();

        var materiDetailList = json.decode(body)["data"] as List;
        List<MateriDetailModel> materiDetailTmp = materiDetailList.map((i) => MateriDetailModel.fromJson(i)).toList();
        return MateriDetailLoaded(materiDetailList: materiDetailTmp);
      } catch (e) {
        return MateriDetailError(message: e.toString());
      }
    } else {
      return MateriDetailError(message: "server error");
    }
  }

  Future<AddMateriDetailState> addMateriDetail(String id_project) async {
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
      return AddMateriDetailError(message: "Periksa Koneksi Internet Anda");
    }

    if (response.statusCode == 200) {
      try {
        String body = await response.stream.bytesToString();

        var materiDetailList = json.decode(body)["data"] as List;
        List<MateriDetailModel> materiDetailTmp = materiDetailList.map((i) => MateriDetailModel.fromJson(i)).toList();
        return AddMateriDetailSuccess(message: "MateriDetail Success");
      } catch (e) {
        return AddMateriDetailError(message: e.toString());
      }
    } else {
      return AddMateriDetailError(message: "server error");
    }
  }
}

