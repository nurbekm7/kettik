import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kettik/models/RequestEntity.dart';
import 'package:kettik/screens/filter/date_time.dart';
import 'package:meta/meta.dart';
import 'package:get/get.dart';
import 'package:kettik/constants.dart';
import 'package:numberpicker/numberpicker.dart';

class FilterDiolog extends StatefulWidget {
  final int initialWeight = 0;
  late final List<RequestEntity> requestEntityList = List.empty();

  // FilterDiolog.add(this.initialWeight) : requestEntityList = List.empty();

  // FilterDiolog.edit(this.requestEntityList) : initialWeight = requestEntityList;

  @override
  FilterDiologState createState() {
    // if (requestEntityList != null) {
    //   return new FilterDiologState(requestEntityList.dateTime,
    //       weighEntryToEdit.weight, weighEntryToEdit.note);
    // } else {
    return new FilterDiologState(new DateTime.now(), initialWeight, "");
    // }
  }
}

class FilterDiologState extends State<FilterDiolog> {
  DateTime _dateTime = new DateTime.now();
  int _weight;
  String _note;
  TextEditingController _textController = new TextEditingController(text: "");
  List<RequestEntity> requestEntityList = List.empty();

  FilterDiologState(this._dateTime, this._weight, this._note);

  PreferredSizeWidget? _createAppBar(BuildContext context) {
    return new AppBar(
      backgroundColor: kPrimaryColor,
      title: AutoSizeText('filter'.tr),
      centerTitle: true,
      // actions: [
      //   new FlatButton(
      //     onPressed: () {
      //       Navigator.of(context).pop(requestEntityList);
      //     },
      //     child: new AutoSizeText(
      //       'SAVE',
      //     ),
      //   ),
      // ],
    );
  }

  @override
  void initState() {
    super.initState();
    _textController = new TextEditingController(text: _note);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _createAppBar(context),
      body: new Column(
        children: [
          new ListTile(
            leading: new Icon(Icons.today, color: Colors.grey[500]),
            title: new DateTimeItem(
              dateTime: _dateTime,
              onChanged: (dateTime) => setState(() => _dateTime = dateTime),
            ),
          ),
          new ListTile(
            // leading: new Image.asset(
            //   "assets/scale-bathroom.png",
            //   color: Colors.grey[500],
            //   height: 24.0,
            //   width: 24.0,
            // ),
            title: new Text(
              "$_weight kg",
            ),
            onTap: () => {_showNumberPicker(context)},
          ),
          new ListTile(
            leading: new Icon(Icons.speaker_notes, color: Colors.grey[500]),
            title: new TextField(
              decoration: new InputDecoration(
                hintText: 'Поиск по описанию',
              ),
              controller: _textController,
              onChanged: (value) => _note = value,
            ),
          ),
        ],
      ),
    );
  }

  _showNumberPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return NumberPicker(
          minValue: 1,
          maxValue: 150,
          value: 0,
          onChanged: (value) => setState(() => _weight = value),
        );
      },
    ).then((value) {
      if (value != null) {
        setState(() => _weight = value);
      }
    });
  }
}
