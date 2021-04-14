import '../bloc/quiz_detail_bloc.dart';
import '../model/quiz_detail_model.dart';
import '../bloc/quiz_detail_state.dart';
import 'package:simplilearn/injection_container.dart';
import 'package:flutter/material.dart';

class QuizDetailPage extends StatefulWidget {
  final String id_project;

  QuizDetailPage({
    Key key,
    @required this.id_project,
  }) : super(key: key);

  @override
  _QuizDetailPageState createState() => _QuizDetailPageState();
}

class _QuizDetailPageState extends State<QuizDetailPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  QuizDetailBloc quizDetailBloc = sl<QuizDetailBloc>();

  @override
  void initState() {
    super.initState();
    quizDetailBloc.getQuizDetail(widget.id_project);
  }

  @override
  void dispose() {
    super.dispose();
    quizDetailBloc.dispose();
  }

  void addAttendance() {}

  Widget listItem(QuizDetailModel quizDetailModel) {
    return InkWell(
      onTap: addAttendance,
      child: Card(
        elevation: 2,
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Row(
            children: [Text(quizDetailModel.option)],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My QuizDetail"),
      ),
      key: _scaffoldKey,
      body: StreamBuilder<QuizDetailState>(
        initialData: quizDetailBloc.initialState,
        stream: quizDetailBloc.quizDetailState,
        builder: (context, snapshot) {
          if (snapshot.data is QuizDetailLoading) {
            return Center(
              child: Container(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.data is QuizDetailError) {
            return Center(
              child: Container(
                height: 40,
                width: 40,
                child: Icon(Icons.error, color: Colors.grey),
              ),
            );
          } else if (snapshot.data is QuizDetailLoaded) {
            return ListView.builder(
              itemCount: (snapshot.data as QuizDetailLoaded).quizDetailList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return listItem((snapshot.data as QuizDetailLoaded).quizDetailList[index]);
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

class AddQuizDetailDialog extends StatelessWidget {
  const AddQuizDetailDialog({
    Key key,
    @required this.quizDetailBloc,
  }) : super(key: key);

  final QuizDetailBloc quizDetailBloc;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AddQuizDetailState>(
      initialData: quizDetailBloc.addInitialState,
      stream: quizDetailBloc.addquizDetailState,
      builder: (context, snapshot) {
        print(snapshot.data.runtimeType);
        if (snapshot.data is AddQuizDetailLoading) {
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
        } else if (snapshot.data is AddQuizDetailSuccess) {
          return AlertDialog(
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
            title: Text("QuizDetail Success"),
            content: Text((snapshot.data as AddQuizDetailSuccess).message),
          );
        } else if (snapshot.data is AddQuizDetailError) {
          return AlertDialog(
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
            title: Text("QuizDetail Failed"),
            content: Text((snapshot.data as AddQuizDetailError).message),
          );
        }
      },
    );
  }
}
