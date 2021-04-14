import 'package:simplilearn/feature/module/model/materi_model.dart';

import '../bloc/materi_detail_bloc.dart';
import '../model/materi_detail_model.dart';
import '../bloc/materi_detail_state.dart';
import 'package:simplilearn/injection_container.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class MateriDetailPage extends StatefulWidget {
  final MateriModel materiModel;

  MateriDetailPage({
    Key key,
    @required this.materiModel,
  }) : super(key: key);

  @override
  _MateriDetailPageState createState() => _MateriDetailPageState();
}

class _MateriDetailPageState extends State<MateriDetailPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  MateriDetailBloc materiDetailBloc = sl<MateriDetailBloc>();

  Codec<String, String> stringToBase64 = utf8.fuse(base64);

  @override
  void initState() {
    super.initState();
    materiDetailBloc.getMateriDetail(widget.materiModel.id);
  }

  @override
  void dispose() {
    super.dispose();
    materiDetailBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String contentFromBase64 = stringToBase64.decode(widget.materiModel.content);
    int len = contentFromBase64.length;
    String content = contentFromBase64.substring(3, len - 4);

    return Scaffold(
      appBar: AppBar(
        title: Text("Learn " + widget.materiModel.name),
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
                    widget.materiModel.name,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
