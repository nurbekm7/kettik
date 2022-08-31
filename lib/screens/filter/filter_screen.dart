import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kettik/components/default_button.dart';
import 'package:kettik/helper/keyboard.dart';
import 'package:kettik/models/RequestEntity.dart';
import 'package:kettik/screens/filter/date_time.dart';
import 'package:meta/meta.dart';
import 'package:get/get.dart';
import 'package:kettik/constants.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

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
      title: AutoSizeText('Фильтр'.tr),
      centerTitle: true,
      // actions: [x
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
    String countryValue = "";
    String? stateValue = "";
    String? cityValue = "";
    String address = "";

    return new Scaffold(
      appBar: _createAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(FontAwesomeIcons.locationDot,
                      color: kPrimaryColor, size: 20.0),
                  SizedBox(width: 10.w),
                  AutoSizeText("from".tr)
                ],
              ),
            ),
            Column(
              children: [
                CSCPicker(
                  countrySearchPlaceholder: "Страна",
                  countryDropdownLabel: "Страна",
                  onCountryChanged: (value) {
                    setState(() {
                      countryValue = value;
                    });
                  },
                  stateSearchPlaceholder: "Область",
                  stateDropdownLabel: "Область",
                  onStateChanged: (value) {
                    setState(() {
                      stateValue = value;
                    });
                  },
                  citySearchPlaceholder: "Город",
                  cityDropdownLabel: "Город",
                  onCityChanged: (value) {
                    setState(() {
                      cityValue = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(FontAwesomeIcons.locationDot,
                      color: kPrimaryColor, size: 20.0),
                  SizedBox(width: 10.w),
                  AutoSizeText("to".tr)
                ],
              ),
            ),
            Column(
              children: [
                CSCPicker(
                  countrySearchPlaceholder: "Страна",
                  countryDropdownLabel: "Страна",
                  onCountryChanged: (value) {
                    setState(() {
                      countryValue = value;
                    });
                  },
                  stateSearchPlaceholder: "Область",
                  stateDropdownLabel: "Область",
                  onStateChanged: (value) {
                    setState(() {
                      stateValue = value;
                    });
                  },
                  citySearchPlaceholder: "Город",
                  cityDropdownLabel: "Город",
                  onCityChanged: (value) {
                    setState(() {
                      cityValue = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 10.h),
            new ListTile(
              leading: new Icon(Icons.today, color: Colors.grey[500]),
              title: new DateTimeItem(
                dateTime: _dateTime,
                onChanged: (dateTime) => setState(() => _dateTime = dateTime),
              ),
            ),
            new ListTile(
              leading: new Image.asset(
                "assets/icons/scale-bathroom.png",
                color: Colors.grey[500],
                height: 24.0,
                width: 24.0,
              ),
              title: new TextField(
                decoration: new InputDecoration(
                  hintText: 'Вес до',
                ),
                controller: _textController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                onChanged: (value) => _weight = int.parse(value),
              ),
              // onTap: () => {_showNumberPicker(context)},
            ),
            new ListTile(
              leading: new Icon(Icons.money, color: Colors.grey[500]),
              title: new TextField(
                decoration: new InputDecoration(
                  hintText: 'Цена до',
                ),
                controller: _textController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                onChanged: (value) => _weight = int.parse(value),
              ),
              // onTap: () => {_showNumberPicker(context)},
            ),
            SizedBox(
              height: 20.h,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: DefaultButton(
                  text: 'Найти'.tr,
                  press: () {
                    // if all are valid then go to success screen
                    KeyboardUtil.hideKeyboard(context);
                  },
                ),
              ),
            )
          ],
        ),
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
          value: 1,
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
