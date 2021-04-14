import '../model/course_detail_model.dart';
import 'package:meta/meta.dart';

abstract class CourseDetailState {}

class CourseDetailEmpty extends CourseDetailState {}

class CourseDetailLoading extends CourseDetailState {}

class CourseDetailLoaded extends CourseDetailState {
  final List<CourseDetailModel> courseDetailList;

  CourseDetailLoaded({@required this.courseDetailList});
}

class CourseDetailError extends CourseDetailState {
  final String message;

  CourseDetailError({@required this.message});
}

abstract class AddCourseDetailState {}

class AddCourseDetailEmpty extends AddCourseDetailState {}

class AddCourseDetailLoading extends AddCourseDetailState {}

class AddCourseDetailSuccess extends AddCourseDetailState {
  final String message;

  AddCourseDetailSuccess({@required this.message});
}

class AddCourseDetailError extends AddCourseDetailState {
  final String message;

  AddCourseDetailError({@required this.message});
}

