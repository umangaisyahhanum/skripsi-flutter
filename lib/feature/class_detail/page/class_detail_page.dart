import 'package:simplilearn/feature/module/page/module_page.dart';
import 'package:simplilearn/feature/quiz/page/quiz_page.dart';
import 'package:simplilearn/feature/task/page/task_page.dart';

import '../../class/model/bab_model.dart';
import '../../class/model/enrollment_model.dart';

import 'package:flutter/material.dart';

class ClassDetailPage extends StatefulWidget {
  final EnrollmentModel enrollmentModel;
  ClassDetailPage({
    Key key,
    @required this.enrollmentModel,
  }) : super(key: key);

  @override
  _ClassDetailPageState createState() => _ClassDetailPageState();
}

class _ClassDetailPageState extends State<ClassDetailPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void addAttendance() {}

  Widget listItem(EnrollmentModel enrolmentModel) {
    return InkWell(
      onTap: addAttendance,
      child: Card(
        elevation: 2,
        margin: EdgeInsets.only(top: 16, left: 20, right: 20, bottom: 8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    enrolmentModel.studentClass[0].name + "  ",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.grey[700]),
                  ),
                  Text(
                    enrolmentModel.course[0].title,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: Colors.grey[600]),
                  ),
                ],
              ),
              Container(
                height: 6,
              ),
              Container(
                height: 3,
                width: 80,
                color: Colors.blue[300],
              ),
              Container(
                height: 8,
              ),
              Row(
                children: [
                  Text(
                    "Instructed By ",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.grey),
                  ),
                  Text(
                    enrolmentModel.studentClass[0].instructor[0].name,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
              Container(
                height: 6,
              ),
              Text(
                enrolmentModel.course[0].type,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13, color: Colors.grey),
              ),
              Container(
                height: 6,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int materiDone = int.parse(widget.enrollmentModel.materiResult);
    int materiTarget = 0;
    for (BabModel tmp in widget.enrollmentModel.course[0].bab) {
      materiTarget += tmp.materi.length;
    }
    int quizDone = widget.enrollmentModel.quizResult.length;
    int quizTarget = widget.enrollmentModel.course[0].quiz.length;
    int taskDone = widget.enrollmentModel.taskResult.length;
    int taskTarget = widget.enrollmentModel.studentClass[0].task.length;

    return Scaffold(
      appBar: AppBar(
        title: Text("CLASS DETAIL"),
      ),
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.enrollmentModel.studentClass[0].name + " " + widget.enrollmentModel.course[0].title,
                        style: TextStyle(fontSize: 18),
                      ),
                      Container(
                        height: 12,
                      ),
                      Text(
                        widget.enrollmentModel.course[0].description,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      Container(
                        height: 13,
                      ),
                      Text(
                        "Module",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Colors.grey[700]),
                      ),
                      Container(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: materiDone,
                            child: Container(
                              height: 6,
                              color: Colors.blue[300],
                            ),
                          ),
                          Expanded(
                            flex: materiTarget - materiDone,
                            child: Container(
                              height: 6,
                              color: Colors.grey[400],
                            ),
                          )
                        ],
                      ),
                      Container(
                        height: 10,
                      ),
                      Text(
                        "Quiz",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.grey[700]),
                      ),
                      Container(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: quizDone,
                            child: Container(
                              height: 6,
                              color: Colors.blue[300],
                            ),
                          ),
                          Expanded(
                            flex: quizTarget - quizDone,
                            child: Container(
                              height: 6,
                              color: Colors.grey[400],
                            ),
                          )
                        ],
                      ),
                      Container(
                        height: 10,
                      ),
                      Text(
                        "Task",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.grey[700]),
                      ),
                      Container(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: taskDone,
                            child: Container(
                              height: 6,
                              color: Colors.blue[300],
                            ),
                          ),
                          Expanded(
                            flex: taskTarget - taskDone,
                            child: Container(
                              height: 6,
                              color: Colors.grey[400],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 12,
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20, top: 12, bottom: 12),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Icon(
                            Icons.person,
                            color: Colors.grey,
                            size: 30,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.enrollmentModel.studentClass[0].instructor[0].name,
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.grey[700]),
                            ),
                            Text(
                              widget.enrollmentModel.studentClass[0].instructor[0].email,
                              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 12,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => ModulePage(
                        classModel: widget.enrollmentModel.course[0],
                      ),
                    ),
                  );
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20, top: 12, bottom: 12),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Center(
                            child: Icon(
                              Icons.menu_book_outlined,
                              color: Colors.grey,
                              size: 30,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Modules",
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.grey[700]),
                              ),
                              Text(
                                "Learn modules",
                                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.grey),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 12,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => TaskPage(
                        enrollmentModel: widget.enrollmentModel,
                      ),
                    ),
                  );
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20, top: 12, bottom: 12),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Center(
                            child: Icon(
                              Icons.assignment,
                              color: Colors.grey,
                              size: 30,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Task",
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.grey[700]),
                              ),
                              Text(
                                "See all task",
                                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.grey),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 12,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => QuizPage(
                        enrollmentModel: widget.enrollmentModel,
                      ),
                    ),
                  );
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20, top: 12, bottom: 12),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Center(
                            child: Icon(
                              Icons.create,
                              color: Colors.grey,
                              size: 30,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Quiz",
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.grey[700]),
                              ),
                              Text(
                                "See All Quiz",
                                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.grey),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 12,
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20, top: 12, bottom: 12),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Icon(
                            Icons.people,
                            color: Colors.grey,
                            size: 30,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Student",
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.grey[700]),
                            ),
                            Text(
                              "See all student",
                              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
