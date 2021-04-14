import 'package:simplilearn/feature/class/model/enrollment_model.dart';
import 'package:simplilearn/feature/task_detail/task_detail_page.dart';

import '../bloc/task_bloc.dart';
import '../model/task_model.dart';
import '../bloc/task_state.dart';
import 'package:simplilearn/injection_container.dart';
import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
  final EnrollmentModel enrollmentModel;

  TaskPage({
    Key key,
    @required this.enrollmentModel,
  }) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TaskBloc taskBloc = sl<TaskBloc>();

  @override
  void initState() {
    super.initState();
    taskBloc.getTask(widget.enrollmentModel.studentClass[0].id);
  }

  @override
  void dispose() {
    super.dispose();
    taskBloc.dispose();
  }

  Widget listItem(TaskModel taskModel) {
    bool taskIsDone = false;
    for (var item in widget.enrollmentModel.taskResult) {
      if (item.id == taskModel.id) {
        taskIsDone = true;
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
              taskModel.title,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            Container(
              height: 8,
            ),
            Text(
              "Status   : " + (taskIsDone ? "Done" : "-"),
              style: Theme.of(context).textTheme.subtitle2,
            ),
            Container(
              height: 4,
            ),
            Divider(),
            Container(
              height: 4,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => TaskDetailPage(
                          taskModel: taskModel,
                        ),
                      ),
                    );
                  },
                  child: Text("Read Task"),
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
        title: Text("My Task"),
      ),
      key: _scaffoldKey,
      body: StreamBuilder<TaskState>(
        initialData: taskBloc.initialState,
        stream: taskBloc.taskState,
        builder: (context, snapshot) {
          if (snapshot.data is TaskLoading) {
            return Center(
              child: Container(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.data is TaskError) {
            return Center(
              child: Container(
                height: 40,
                width: 40,
                child: Icon(Icons.error, color: Colors.grey),
              ),
            );
          } else if (snapshot.data is TaskLoaded) {
            return ListView.builder(
              itemCount: (snapshot.data as TaskLoaded).classWithTask.task.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return listItem((snapshot.data as TaskLoaded).classWithTask.task[index]);
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

class AddTaskDialog extends StatelessWidget {
  const AddTaskDialog({
    Key key,
    @required this.taskBloc,
  }) : super(key: key);

  final TaskBloc taskBloc;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AddTaskState>(
      initialData: taskBloc.addInitialState,
      stream: taskBloc.addtaskState,
      builder: (context, snapshot) {
        print(snapshot.data.runtimeType);
        if (snapshot.data is AddTaskLoading) {
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
        } else if (snapshot.data is AddTaskSuccess) {
          return AlertDialog(
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
            title: Text("Task Success"),
            content: Text((snapshot.data as AddTaskSuccess).message),
          );
        } else if (snapshot.data is AddTaskError) {
          return AlertDialog(
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
            title: Text("Task Failed"),
            content: Text((snapshot.data as AddTaskError).message),
          );
        }
      },
    );
  }
}
