import 'package:simplilearn/feature/materi_detail/page/materi_detail_page.dart';

import '../model/bab_model.dart';
import '../model/materi_model.dart';
import 'package:simplilearn/feature/class/model/course_model.dart';

import '../bloc/module_bloc.dart';
import '../bloc/module_state.dart';
import 'package:simplilearn/injection_container.dart';
import 'package:flutter/material.dart';

class ModulePage extends StatefulWidget {
  final CourseModel classModel;

  ModulePage({
    Key key,
    @required this.classModel,
  }) : super(key: key);

  @override
  _ModulePageState createState() => _ModulePageState();
}

class _ModulePageState extends State<ModulePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  ModuleBloc moduleBloc = sl<ModuleBloc>();

  @override
  void initState() {
    super.initState();
    moduleBloc.getModule(widget.classModel.id);
  }

  @override
  void dispose() {
    super.dispose();
    moduleBloc.dispose();
  }

  void navigateToLearn() {}

  Widget materiListItem(MateriModel materiModel) {
    return ListTile(
      title: Text(materiModel.name),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => MateriDetailPage(
              materiModel: materiModel,
            ),
          ),
        );
      },
    );
  }

  Widget listItem(BabModel babModel) {
    return ExpansionTile(
      title: Text(babModel.name),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: ListView.builder(
            itemCount: babModel.materi.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return materiListItem(babModel.materi[index]);
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Module"),
      ),
      key: _scaffoldKey,
      body: StreamBuilder<ModuleState>(
        initialData: moduleBloc.initialState,
        stream: moduleBloc.moduleState,
        builder: (context, snapshot) {
          if (snapshot.data is ModuleLoading) {
            return Center(
              child: Container(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.data is ModuleError) {
            return Center(
              child: Container(
                height: 40,
                width: 40,
                child: Icon(Icons.error, color: Colors.grey),
              ),
            );
          } else if (snapshot.data is ModuleLoaded) {
            return ListView.builder(
              itemCount: (snapshot.data as ModuleLoaded).moduleList.bab.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return listItem((snapshot.data as ModuleLoaded).moduleList.bab[index]);
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
