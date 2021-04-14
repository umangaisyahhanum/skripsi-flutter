import 'dart:async';

import '../repository/course_detail_repository.dart';
import 'course_detail_state.dart';
import 'package:meta/meta.dart';

class CourseDetailBloc {
  final CourseDetailRepository courseDetailRepository;

  CourseDetailBloc({@required CourseDetailRepository courseDetailRepository})
      : assert(courseDetailRepository != null),
        this.courseDetailRepository = courseDetailRepository;

  StreamController<CourseDetailState> _courseDetailController = StreamController<CourseDetailState>.broadcast();
  Stream<CourseDetailState> get courseDetailState => _courseDetailController.stream.asBroadcastStream();

  CourseDetailState get initialState => CourseDetailLoading();

  StreamController<AddCourseDetailState> _addcourseDetailController = StreamController<AddCourseDetailState>.broadcast();
  Stream<AddCourseDetailState> get addcourseDetailState => _addcourseDetailController.stream.asBroadcastStream();

  AddCourseDetailState get addInitialState => AddCourseDetailLoading();

  void dispose() {
    _courseDetailController.close();
    _addcourseDetailController.close();
  }

  void getCourseDetail(String id_project) {
    _courseDetailController.add(CourseDetailLoading());
    courseDetailRepository.requestCourseDetail(id_project).then((value) {
      _courseDetailController.add(value);
    });
  }

  void addCourseDetail(String id_user, String id_project) {
    _addcourseDetailController.add(AddCourseDetailLoading());
    courseDetailRepository.addCourseDetail(id_project).then((value) {
      _addcourseDetailController.add(value);
    });
  }
}

