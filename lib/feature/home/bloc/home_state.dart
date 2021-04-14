import 'package:simplilearn/feature/home/model/course_model.dart';

import 'package:meta/meta.dart';

abstract class HomeState {}

class HomeEmpty extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<CourseModel> homeList;

  HomeLoaded({@required this.homeList});
}

class HomeError extends HomeState {
  final String message;

  HomeError({@required this.message});
}
