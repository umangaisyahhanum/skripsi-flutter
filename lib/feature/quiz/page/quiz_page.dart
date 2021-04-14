import 'package:simplilearn/feature/class/model/enrollment_model.dart';
import 'package:simplilearn/feature/quiz_detail/page/quiz_detail_page.dart';

import '../bloc/quiz_bloc.dart';
import '../model/quiz_model.dart';
import '../bloc/quiz_state.dart';
import 'package:simplilearn/injection_container.dart';
import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  final EnrollmentModel enrollmentModel;

  QuizPage({
    Key key,
    @required this.enrollmentModel,
  }) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  QuizBloc quizBloc = sl<QuizBloc>();

  @override
  void initState() {
    super.initState();
    quizBloc.getQuiz(widget.enrollmentModel.course[0].id);
  }

  @override
  void dispose() {
    super.dispose();
    quizBloc.dispose();
  }

  Widget listItem(QuizModel quizModel) {
    String score = "-";
    for (var item in widget.enrollmentModel.quizResult) {
      if (item.id == quizModel.id) {
        score = item.score;
      }
    }
    return Card(
      elevation: 2,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              quizModel.title,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            Container(
              height: 8,
            ),
            Text(
              quizModel.question.length.toString() + " Question",
              style: Theme.of(context).textTheme.subtitle2,
            ),
            Container(
              height: 8,
            ),
            Text(
              "Status   : " + score,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            Container(
              height: 4,
            ),
            Divider(),
            Container(
              height: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => QuizDetailPage(
                          quizModel: quizModel,
                        ),
                      ),
                    );
                  },
                  child: Text("Take Quiz"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Quiz"),
      ),
      key: _scaffoldKey,
      body: StreamBuilder<QuizState>(
        initialData: quizBloc.initialState,
        stream: quizBloc.quizState,
        builder: (context, snapshot) {
          if (snapshot.data is QuizLoading) {
            return Center(
              child: Container(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.data is QuizError) {
            return Center(
              child: Container(
                height: 40,
                width: 40,
                child: Icon(Icons.error, color: Colors.grey),
              ),
            );
          } else if (snapshot.data is QuizLoaded) {
            return ListView.builder(
              itemCount: (snapshot.data as QuizLoaded).courseWithQuiz.quiz.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return listItem((snapshot.data as QuizLoaded).courseWithQuiz.quiz[index]);
              },
            );
          }

          return Center(
            child: Container(
              height: 40,
              width: 40,
              child: Icon(Icons.hourglass_empty, color: Colors.grey),
            ),
          );
        },
      ),
    );
  }
}

class AddQuizDialog extends StatelessWidget {
  const AddQuizDialog({
    Key key,
    @required this.quizBloc,
  }) : super(key: key);

  final QuizBloc quizBloc;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AddQuizState>(
      initialData: quizBloc.addInitialState,
      stream: quizBloc.addquizState,
      builder: (context, snapshot) {
        print(snapshot.data.runtimeType);
        if (snapshot.data is AddQuizLoading) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                    ],
                  )
                ],
              ),
            ),
          );
        } else if (snapshot.data is AddQuizSuccess) {
          return AlertDialog(
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
            title: Text("Quiz Success"),
            content: Text((snapshot.data as AddQuizSuccess).message),
          );
        } else if (snapshot.data is AddQuizError) {
          return AlertDialog(
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
            title: Text("Quiz Failed"),
            content: Text((snapshot.data as AddQuizError).message),
          );
        }
      },
    );
  }
}
