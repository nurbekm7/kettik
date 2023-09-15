import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:kettik/components/settings_service.dart';

class DateTimeItem extends StatelessWidget {
  DateTimeItem({Key? key, DateTime? dateTime, required this.onChanged})
      : date = dateTime == null
            ? new DateTime.now()
            : new DateTime(dateTime.year, dateTime.month, dateTime.day),
        // time = dateTime == null
        //     ? new TimeOfDay(
        //         hour: new DateTime.now().hour,
        //         minute: new DateTime.now().minute)
        //     : new TimeOfDay(hour: dateTime.hour, minute: dateTime.minute),
        super(key: key);

  final DateTime date;
  // final TimeOfDay time;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    print(Get.find<SettingsService>().localeLangCode);
    initializeDateFormatting();
    return new Row(
      children: <Widget>[
        new Expanded(
          child: new InkWell(
            onTap: (() => _showDatePicker(context)),
            child: new Padding(
                padding: new EdgeInsets.symmetric(vertical: 8.0),
                child: new AutoSizeText(new DateFormat('EEEE, d MMM ',
                        Get.find<SettingsService>().localeLangCode)
                    .format(date))),
          ),
        ),
        // new InkWell(
        //   onTap: (() => _showTimePicker(context)),
        //   child: new Padding(
        //       padding: new EdgeInsets.symmetric(vertical: 8.0),
        //       child: new Text('$time')),
        // ),
      ],
    );
  }

  Future _showDatePicker(BuildContext context) async {
    DateTime? dateTimePicked = await showDatePicker(
        context: context,
        initialDate: date,
        locale: Get.find<SettingsService>().locale,
        firstDate: date.subtract(const Duration(days: 20000)),
        lastDate: date.add(const Duration(days: 999999)));

    if (dateTimePicked != null) {
      onChanged(new DateTime(
          dateTimePicked.year, dateTimePicked.month, dateTimePicked.day));
    }
  }

  // Future _showTimePicker(BuildContext context) async {
  //   TimeOfDay? timeOfDay =
  //       await showTimePicker(context: context, initialTime: time);

  //   if (timeOfDay != null) {
  //     onChanged(new DateTime(
  //         date.year, date.month, date.day, timeOfDay.hour, timeOfDay.minute));
  //   }
  // }
}
