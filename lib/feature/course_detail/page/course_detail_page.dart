import 'package:flutter/material.dart';
import 'package:simplilearn/feature/home/model/course_model.dart';
import 'package:simplilearn/feature/home/model/keyfeature_model.dart';
import 'package:simplilearn/feature/home/model/learningpath_model.dart';

class CourseDetailPage extends StatefulWidget {
  CourseDetailPage({@required this.courseModel});
  final CourseModel courseModel;
  @override
  _CourseDetailPageState createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  Widget keyfeatureWidget(KeyfeatureModel keyfeatureModel) {
    return Container(
      margin: EdgeInsets.only(top: 12),
      child: Row(
        children: [
          SizedBox(
            width: 6,
          ),
          Icon(Icons.check),
          SizedBox(
            width: 6,
          ),
          Expanded(
            flex: 8,
            child: Container(
              child: Text(
                keyfeatureModel.title,
                softWrap: true,
                maxLines: 10,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget learningPathWidget(LearningpathModel learningpathModel) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 6,
          ),
          Icon(
            Icons.adjust_outlined,
            size: 20,
            color: Colors.blue,
          ),
          SizedBox(
            width: 6,
          ),
          Expanded(
            flex: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  learningpathModel.title,
                  softWrap: true,
                  maxLines: 10,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  learningpathModel.description,
                  softWrap: true,
                  maxLines: 10,
                  style: Theme.of(context).textTheme.caption,
                ),
                SizedBox(
                  height: 12,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Course Detail"),
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
                    widget.courseModel.title,
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
                  Text(widget.courseModel.description),
                  ListView.builder(
                    itemCount: widget.courseModel.keyfeature.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return keyfeatureWidget(widget.courseModel.keyfeature[index]);
                    },
                  )
                ],
              ),
            ),
            Divider(),
            Stack(
              children: [
                Positioned(
                  bottom: 0,
                  top: 0,
                  left: 22.75,
                  child: Container(
                    width: 2.5,
                    color: Colors.blue,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                  child: ListView.builder(
                    itemCount: widget.courseModel.learningpath.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return learningPathWidget(widget.courseModel.learningpath[index]);
                    },
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: ElevatedButton(
                    onPressed: () {
                      print("enroll");
                    },
                    child: Text("Enroll"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
