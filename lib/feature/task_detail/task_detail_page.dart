import 'package:flutter/material.dart';
import 'package:simplilearn/feature/task/model/task_model.dart';

import 'dart:convert';

class TaskDetailPage extends StatefulWidget {
  TaskDetailPage({Key key, @required this.taskModel}) : super(key: key);
  final TaskModel taskModel;

  @override
  _TaskDetailPageState createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  Codec<String, String> stringToBase64 = utf8.fuse(base64);

  @override
  Widget build(BuildContext context) {
    String contentFromBase64 = stringToBase64.decode(widget.taskModel.description);
    int len = contentFromBase64.length;
    String content = contentFromBase64.substring(3, len - 4);

    return Scaffold(
      appBar: AppBar(
        title: Text("Task"),
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
                    widget.taskModel.title,
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
                  Text(content),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          print("done task");
                        },
                        child: Text("Mark As Done"),
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
