import 'dart:async';

import '../repository/home_repository.dart';
import 'home_state.dart';
import 'package:meta/meta.dart';

class HomeBloc {
  final HomeRepository homeRepository;

  HomeBloc({@required HomeRepository homeRepository})
      : assert(homeRepository != null),
        this.homeRepository = homeRepository;

  StreamController<HomeState> _homeController = StreamController<HomeState>.broadcast();
  Stream<HomeState> get homeState => _homeController.stream.asBroadcastStream();

  HomeState get initialState => HomeLoading();

  void dispose() {
    _homeController.close();
  }

  void getHome() {
    _homeController.add(HomeLoading());
    homeRepository.requestHome().then((value) {
      _homeController.add(value);
    });
  }
}
