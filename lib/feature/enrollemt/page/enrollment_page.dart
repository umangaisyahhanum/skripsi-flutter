import 'package:simplilearn/feature/enrollemt/model/enrollment_model.dart';

import '../bloc/enrollment_bloc.dart';
import '../bloc/enrollment_state.dart';
import '../../../injection_container.dart';
import 'package:flutter/material.dart';

class EnrollmentPage extends StatefulWidget {
  EnrollmentPage({
    Key key,
  }) : super(key: key);

  @override
  _EnrollmentPageState createState() => _EnrollmentPageState();
}

class _EnrollmentPageState extends State<EnrollmentPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  EnrollmentBloc enrollmentBloc = sl<EnrollmentBloc>();

  @override
  void initState() {
    super.initState();
    enrollmentBloc.getEnrollment();
  }

  @override
  void dispose() {
    super.dispose();
    enrollmentBloc.dispose();
  }

  void addAttendance() {}

  Widget listItem(EnrollmentModel enrollmentModel) {
    IconData icon;
    String status = "Pending";
    if (enrollmentModel.status == "0") {
      icon = Icons.pending_outlined;
      status = "Pending";
    } else if (enrollmentModel.status == "1") {
      icon = Icons.watch_later_outlined;
      status = "Waiting";
    } else if (enrollmentModel.status == "2") {
      icon = Icons.check_circle_outline_outlined;
      status = "Joined";
    }
    return InkWell(
      onTap: addAttendance,
      child: Card(
        elevation: 2,
        margin: EdgeInsets.only(top: 16, left: 20, right: 20, bottom: 8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            children: [
              Expanded(
                flex: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      enrollmentModel.course[0].title,
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.grey[700]),
                    ),
                    Container(
                      height: 8,
                    ),
                    Text(
                      enrollmentModel.course[0].type,
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      color: Colors.grey,
                    ),
                    Container(
                      height: 3,
                    ),
                    Text(
                      status,
                      style: TextStyle(fontWeight: FontWeight.w300, fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enrollment"),
      ),
      key: _scaffoldKey,
      body: StreamBuilder<EnrollmentState>(
        initialData: enrollmentBloc.initialState,
        stream: enrollmentBloc.enrollmentState,
        builder: (context, snapshot) {
          if (snapshot.data is EnrollmentLoading) {
            return Center(
              child: Container(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.data is EnrollmentError) {
            return Center(
              child: Container(
                height: 40,
                width: 40,
                child: Icon(Icons.error, color: Colors.grey),
              ),
            );
          } else if (snapshot.data is EnrollmentLoaded) {
            return ListView.builder(
              itemCount: (snapshot.data as EnrollmentLoaded).enrollmentList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return listItem((snapshot.data as EnrollmentLoaded).enrollmentList[index]);
              },
            );
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 120,
                  width: 120,
                  child: Icon(
                    Icons.layers_clear,
                    color: Colors.grey,
                    size: 120,
                  ),
                ),
                Container(
                  height: 20,
                ),
                Text(
                  "Anda Belum Enroll Course",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
