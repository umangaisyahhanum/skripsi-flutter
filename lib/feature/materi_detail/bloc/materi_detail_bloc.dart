import 'dart:async';

import '../repository/materi_detail_repository.dart';
import 'materi_detail_state.dart';
import 'package:meta/meta.dart';

class MateriDetailBloc {
  final MateriDetailRepository materiDetailRepository;

  MateriDetailBloc({@required MateriDetailRepository materiDetailRepository})
      : assert(materiDetailRepository != null),
        this.materiDetailRepository = materiDetailRepository;

  StreamController<MateriDetailState> _materiDetailController = StreamController<MateriDetailState>.broadcast();
  Stream<MateriDetailState> get materiDetailState => _materiDetailController.stream.asBroadcastStream();

  MateriDetailState get initialState => MateriDetailLoading();

  StreamController<AddMateriDetailState> _addmateriDetailController = StreamController<AddMateriDetailState>.broadcast();
  Stream<AddMateriDetailState> get addmateriDetailState => _addmateriDetailController.stream.asBroadcastStream();

  AddMateriDetailState get addInitialState => AddMateriDetailLoading();

  void dispose() {
    _materiDetailController.close();
    _addmateriDetailController.close();
  }

  void getMateriDetail(String id_project) {
    _materiDetailController.add(MateriDetailLoading());
    materiDetailRepository.requestMateriDetail(id_project).then((value) {
      _materiDetailController.add(value);
    });
  }

  void addMateriDetail(String id_user, String id_project) {
    _addmateriDetailController.add(AddMateriDetailLoading());
    materiDetailRepository.addMateriDetail(id_project).then((value) {
      _addmateriDetailController.add(value);
    });
  }
}

