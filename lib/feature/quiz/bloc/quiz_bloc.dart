import 'dart:async';

import '../repository/quiz_repository.dart';
import 'quiz_state.dart';
import 'package:meta/meta.dart';

class QuizBloc {
  final QuizRepository quizRepository;

  QuizBloc({@required QuizRepository quizRepository})
      : assert(quizRepository != null),
        this.quizRepository = quizRepository;

  StreamController<QuizState> _quizController = StreamController<QuizState>.broadcast();
  Stream<QuizState> get quizState => _quizController.stream.asBroadcastStream();

  QuizState get initialState => QuizLoading();

  StreamController<AddQuizState> _addquizController = StreamController<AddQuizState>.broadcast();
  Stream<AddQuizState> get addquizState => _addquizController.stream.asBroadcastStream();

  AddQuizState get addInitialState => AddQuizLoading();

  void dispose() {
    _quizController.close();
    _addquizController.close();
  }

  void getQuiz(String id_project) {
    _quizController.add(QuizLoading());
    quizRepository.requestQuiz(id_project).then((value) {
      _quizController.add(value);
    });
  }

  void addQuiz(String id_user, String id_project) {
    _addquizController.add(AddQuizLoading());
    quizRepository.addQuiz(id_project).then((value) {
      _addquizController.add(value);
    });
  }
}
