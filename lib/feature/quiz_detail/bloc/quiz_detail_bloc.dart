import 'dart:async';

import '../repository/quiz_detail_repository.dart';
import 'quiz_detail_state.dart';
import 'package:meta/meta.dart';

class QuizDetailBloc {
  final QuizDetailRepository quizDetailRepository;

  QuizDetailBloc({@required QuizDetailRepository quizDetailRepository})
      : assert(quizDetailRepository != null),
        this.quizDetailRepository = quizDetailRepository;

  StreamController<QuizDetailState> _quizDetailController = StreamController<QuizDetailState>.broadcast();
  Stream<QuizDetailState> get quizDetailState => _quizDetailController.stream.asBroadcastStream();

  QuizDetailState get initialState => QuizDetailLoading();

  StreamController<AddQuizDetailState> _addquizDetailController = StreamController<AddQuizDetailState>.broadcast();
  Stream<AddQuizDetailState> get addquizDetailState => _addquizDetailController.stream.asBroadcastStream();

  AddQuizDetailState get addInitialState => AddQuizDetailLoading();

  StreamController<QuizDetailAnswerState> _quizDetailAnswerController = StreamController<QuizDetailAnswerState>.broadcast();
  Stream<QuizDetailAnswerState> get quizDetailAnswerState => _quizDetailAnswerController.stream.asBroadcastStream();

  QuizDetailAnswerState get answerInitialState => QuizDetailAnswerState(answer: answerMap);

  Map<String, String> answerMap = Map<String, String>();

  void dispose() {
    _quizDetailController.close();
    _addquizDetailController.close();
    _quizDetailAnswerController.close();
  }

  void newAnswer(String quiz_id, String answer) {
    answerMap[quiz_id] = answer;
    _quizDetailAnswerController.add(QuizDetailAnswerState(answer: answerMap));
  }

  void getQuizDetail(String id_project) {
    _quizDetailController.add(QuizDetailLoading());
    quizDetailRepository.requestQuizDetail(id_project).then((value) {
      _quizDetailController.add(value);
    });
  }

  void addQuizDetail(String id_user, String id_project) {
    _addquizDetailController.add(AddQuizDetailLoading());
    quizDetailRepository.addQuizDetail(id_project).then((value) {
      _addquizDetailController.add(value);
    });
  }
}
