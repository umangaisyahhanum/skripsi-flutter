import 'package:flutter/material.dart';
import 'package:simplilearn/feature/quiz/model/question_model.dart';
import 'package:simplilearn/feature/quiz/model/quiz_model.dart';
import 'package:simplilearn/feature/quiz_detail/bloc/quiz_detail_bloc.dart';
import 'package:simplilearn/feature/quiz_detail/bloc/quiz_detail_state.dart';
import 'package:simplilearn/injection_container.dart';

class QuizDetailPage extends StatefulWidget {
  QuizDetailPage({Key key, @required this.quizModel}) : super(key: key);
  final QuizModel quizModel;

  @override
  _QuizDetailPageState createState() => _QuizDetailPageState();
}

class _QuizDetailPageState extends State<QuizDetailPage> {
  QuizDetailBloc quizDetailBloc = sl<QuizDetailBloc>();

  Widget listItem(QuestionModel quizModel, String currentAnswer) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            quizModel.order + ". " + quizModel.question,
            style: Theme.of(context).textTheme.caption,
          ),
          Container(
            height: 8,
          ),
          Divider(),
          ListTile(
            title: Text(
              'a. ' + quizModel.a,
              style: Theme.of(context).textTheme.caption,
            ),
            leading: Radio<String>(
              value: quizModel.a,
              groupValue: currentAnswer,
              onChanged: (value) {
                quizDetailBloc.newAnswer(quizModel.id, value);
              },
            ),
          ),
          ListTile(
            title: Text(
              'b. ' + quizModel.b,
              style: Theme.of(context).textTheme.caption,
            ),
            leading: Radio<String>(
              value: quizModel.b,
              groupValue: currentAnswer,
              onChanged: (value) {
                quizDetailBloc.newAnswer(quizModel.id, value);
              },
            ),
          ),
          ListTile(
            title: Text(
              'c. ' + quizModel.c,
              style: Theme.of(context).textTheme.caption,
            ),
            leading: Radio<String>(
              value: quizModel.c,
              groupValue: currentAnswer,
              onChanged: (value) {
                quizDetailBloc.newAnswer(quizModel.id, value);
              },
            ),
          ),
          ListTile(
            title: Text(
              'd. ' + quizModel.d,
              style: Theme.of(context).textTheme.caption,
            ),
            leading: Radio<String>(
              value: quizModel.d,
              groupValue: currentAnswer,
              onChanged: (value) {
                quizDetailBloc.newAnswer(quizModel.id, value);
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz Check"),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 10,
                  ),
                  Text(
                    widget.quizModel.title,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Container(
                    height: 10,
                  ),
                  Container(
                    height: 3,
                    width: 80,
                    color: Colors.blue[300],
                  ),
                  Container(
                    height: 20,
                  ),
                  StreamBuilder<QuizDetailAnswerState>(
                    initialData: quizDetailBloc.answerInitialState,
                    stream: quizDetailBloc.quizDetailAnswerState,
                    builder: (context, snapshot) {
                      List<QuestionModel> questionModels = widget.quizModel.question;
                      questionModels.sort((a, b) => int.parse(a.order).compareTo(int.parse(b.order)));
                      return ListView.builder(
                        itemCount: widget.quizModel.question.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return listItem(widget.quizModel.question[index], snapshot.data.answer[widget.quizModel.question[index].id]);
                        },
                      );
                    },
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          print("done quiz");
                        },
                        child: Text("Submit"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
