import '../model/enrollment_model.dart';
import '../../class_detail/page/class_detail_page.dart';

import '../bloc/class_bloc.dart';
import '../bloc/class_state.dart';
import '../../../injection_container.dart';
import 'package:flutter/material.dart';

class ClassPage extends StatefulWidget {
  ClassPage({
    Key key,
  }) : super(key: key);

  @override
  _ClassPageState createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  ClassBloc classBloc = sl<ClassBloc>();

  @override
  void initState() {
    super.initState();
    classBloc.getClass();
  }

  @override
  void dispose() {
    super.dispose();
    classBloc.dispose();
  }

  Widget listItem(EnrollmentModel enrolmentModel) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => ClassDetailPage(
              enrollmentModel: enrolmentModel,
            ),
          ),
        );
      },
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Class"),
      ),
      key: _scaffoldKey,
      body: StreamBuilder<ClassState>(
        initialData: classBloc.initialState,
        stream: classBloc.classState,
        builder: (context, snapshot) {
          if (snapshot.data is ClassLoading) {
            return Center(
              child: Container(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.data is ClassError) {
            return Center(
              child: Container(
                height: 40,
                width: 40,
                child: Icon(Icons.error, color: Colors.grey),
              ),
            );
          } else if (snapshot.data is ClassLoaded) {
            return ListView.builder(
              itemCount: (snapshot.data as ClassLoaded).classList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return listItem((snapshot.data as ClassLoaded).classList[index]);
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
                  "Anda Belum Memiliki Kelas",
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
