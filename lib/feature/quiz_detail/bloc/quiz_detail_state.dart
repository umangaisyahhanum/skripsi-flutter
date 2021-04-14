import '../model/quiz_detail_model.dart';
import 'package:meta/meta.dart';

abstract class QuizDetailState {}

class QuizDetailEmpty extends QuizDetailState {}

class QuizDetailLoading extends QuizDetailState {}

class QuizDetailLoaded extends QuizDetailState {
  final List<QuizDetailModel> quizDetailList;

  QuizDetailLoaded({@required this.quizDetailList});
}

class QuizDetailError extends QuizDetailState {
  final String message;

  QuizDetailError({@required this.message});
}

abstract class AddQuizDetailState {}

class AddQuizDetailEmpty extends AddQuizDetailState {}

class AddQuizDetailLoading extends AddQuizDetailState {}

class AddQuizDetailSuccess extends AddQuizDetailState {
  final String message;

  AddQuizDetailSuccess({@required this.message});
}

class AddQuizDetailError extends AddQuizDetailState {
  final String message;

  AddQuizDetailError({@required this.message});
}

class QuizDetailAnswerState {
  final Map<String, String> answer;

  QuizDetailAnswerState({@required this.answer});
}
