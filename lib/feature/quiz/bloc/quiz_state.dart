import 'package:simplilearn/feature/quiz/model/course_wth_quiz.dart';

import '../model/quiz_model.dart';
import 'package:meta/meta.dart';

abstract class QuizState {}

class QuizEmpty extends QuizState {}

class QuizLoading extends QuizState {}

class QuizLoaded extends QuizState {
  final CourseWithQuiz courseWithQuiz;

  QuizLoaded({@required this.courseWithQuiz});
}

class QuizError extends QuizState {
  final String message;

  QuizError({@required this.message});
}

abstract class AddQuizState {}

class AddQuizEmpty extends AddQuizState {}

class AddQuizLoading extends AddQuizState {}

class AddQuizSuccess extends AddQuizState {
  final String message;

  AddQuizSuccess({@required this.message});
}

class AddQuizError extends AddQuizState {
  final String message;

  AddQuizError({@required this.message});
}
