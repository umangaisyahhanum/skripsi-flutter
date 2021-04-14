import 'package:simplilearn/feature/course_detail/page/course_detail_page.dart';
import 'package:simplilearn/feature/home/model/course_model.dart';
import 'package:simplilearn/feature/login/page/login_page.dart';
import 'package:simplilearn/utils/shared_value.dart';

import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';
import '../../../injection_container.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  HomeBloc homeBloc = sl<HomeBloc>();

  @override
  void initState() {
    super.initState();
    homeBloc.getHome();
  }

  @override
  void dispose() {
    super.dispose();
    homeBloc.dispose();
  }

  Widget listItem(CourseModel courseModel) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => CourseDetailPage(
              courseModel: courseModel,
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
              Text(
                courseModel.title,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.grey[700]),
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
              Text(
                courseModel.keyfeature.length.toString() + " Key Feature",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.grey),
              ),
              Container(
                height: 4,
              ),
              Text(
                courseModel.learningpath.length.toString() + " Learning Path",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.grey),
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
        title: Text("Home"),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              SharedValue.logout();
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
            },
          ),
        ],
      ),
      key: _scaffoldKey,
      body: StreamBuilder<HomeState>(
        initialData: homeBloc.initialState,
        stream: homeBloc.homeState,
        builder: (context, snapshot) {
          if (snapshot.data is HomeLoading) {
            return Center(
              child: Container(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.data is HomeError) {
            return Center(
              child: Container(
                height: 40,
                width: 40,
                child: Icon(Icons.error, color: Colors.grey),
              ),
            );
          } else if (snapshot.data is HomeLoaded) {
            return ListView.builder(
              itemCount: (snapshot.data as HomeLoaded).homeList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return listItem((snapshot.data as HomeLoaded).homeList[index]);
              },
            );
          }

          return Center(
            child: Column(
              children: [
                Container(
                  height: 120,
                  width: 120,
                  child: Icon(
                    Icons.hourglass_empty,
                    color: Colors.grey,
                    size: 120,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
