import 'dart:async';
import 'dart:ffi';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kettik/components/default_button.dart';
import 'package:kettik/components/form_error.dart';
import 'package:kettik/components/settings_service.dart';
import 'package:kettik/helper/keyboard.dart';
import 'package:kettik/models/RequestEntity.dart';
import 'package:kettik/models/UserProfile.dart';
import 'package:kettik/screens/filter/date_time.dart';
import 'package:kettik/screens/filter/filter_controller.dart';
import 'package:kettik/screens/filter/filter_loading_overlay.dart';
import 'package:kettik/screens/home/home_controller.dart';
import 'package:get/get.dart';
import 'package:kettik/constants.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'dart:developer' as debug;

class FilterDiolog extends StatefulWidget {
  final int initialWeight = 0;
  late final List<RequestEntity> requestEntityList = List.empty();

  @override
  FilterDiologState createState() {
    return new FilterDiologState();
  }
}

class FilterDiologState extends State<FilterDiolog> {
  List<String> list = <String>['ihint'.tr, 'sender'.tr, 'courier'.tr];
  DateTime _dateTime = new DateTime.now();
  double _weight = double.maxFinite;
  int price = double.maxFinite.toInt();
  TextEditingController _textControllerWeight =
      new TextEditingController(text: "");
  TextEditingController _textControllerPrice =
      new TextEditingController(text: "");

  List<RequestEntity> requestEntityList = List.empty();
  final List<String?> errors = [];
  late RequestType resultRequestType;

  String dropdownReqTypeValue = 'ihint'.tr;
  final _formKey = GlobalKey<FormState>();
  String countryValue = '';
  String stateValue = '';
  String cityValue = '';

  String toCountryValue = '';
  String toStateValue = '';
  String toCityValue = '';

  PreferredSizeWidget? _createAppBar(BuildContext context) {
    return new AppBar(
      backgroundColor: kPrimaryColor,
      title: AutoSizeText('filter'.tr),
      centerTitle: true,
    );
  }

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  void initState() {
    super.initState();
    _textControllerWeight = new TextEditingController();
    _textControllerPrice = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return FilterLoadingOverlay(
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: _createAppBar(context),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.only(
                    top: 10,
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    left: 10,
                    right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton<String>(
                        value: dropdownReqTypeValue,
                        hint: AutoSizeText('please_select'.tr),
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            dropdownReqTypeValue = value!;
                          });
                        },
                        items:
                            list.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: AutoSizeText(value),
                          );
                        }).toList(),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(FontAwesomeIcons.locationDot,
                            color: kPrimaryColor, size: 20.0),
                        SizedBox(width: 10.w),
                        AutoSizeText("from".tr)
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CSCPicker(
                        countrySearchPlaceholder: "country".tr,
                        countryDropdownLabel: "country".tr,
                        onCountryChanged: (value) {
                          setState(() {
                            debug.log("countryValue: $value");

                            if (value.isNotEmpty) {
                              debug.log("countryValue isNotEmpty: $value");
                              countryValue = value;
                              debug.log(
                                  "countryValue countryValue: $countryValue");

                              removeError(error: kNullCountryField);
                            }
                          });
                        },
                        stateSearchPlaceholder: "region".tr,
                        stateDropdownLabel: "region".tr,
                        onStateChanged: (value) {
                          setState(() {
                            debug.log("stateValue: $value");
                            if (value != null) {
                              removeError(error: kNullRegionField);
                              stateValue = value.toString();
                            }
                          });
                        },
                        citySearchPlaceholder: "city".tr,
                        cityDropdownLabel: "city".tr,
                        onCityChanged: (value) {
                          setState(() {
                            debug.log("cityValue: $value");
                            if (value != null) {
                              removeError(error: kNullCityField);
                              cityValue = value;
                            }
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      children: [
                        Icon(FontAwesomeIcons.locationDot,
                            color: kPrimaryColor, size: 20.0),
                        SizedBox(width: 10.w),
                        AutoSizeText("to".tr)
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CSCPicker(
                        countrySearchPlaceholder: "country".tr,
                        countryDropdownLabel: "country".tr,
                        onCountryChanged: (value) {
                          setState(() {
                            debug.log("toCountryValue: $value");

                            if (value.isNotEmpty) {
                              removeError(error: kNullToCountryField);
                              toCountryValue = value;
                            }
                          });
                        },
                        stateSearchPlaceholder: "region".tr,
                        stateDropdownLabel: "region".tr,
                        onStateChanged: (value) {
                          setState(() {
                            debug.log("toStateValue: $value");
                            if (value != null) {
                              removeError(error: kNullToRegionField);
                              toStateValue = value;
                            }
                          });
                        },
                        citySearchPlaceholder: "city".tr,
                        cityDropdownLabel: "city".tr,
                        onCityChanged: (value) {
                          setState(() {
                            debug.log("toCityValue: $value");
                            if (value != null) {
                              removeError(error: kNullToCityField);
                              toCityValue = value;
                            }
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: AutoSizeText("deadline".tr,
                          textAlign: TextAlign.start),
                    ),
                    new ListTile(
                      leading: new Icon(Icons.today, color: Colors.grey[500]),
                      title: new DateTimeItem(
                        dateTime: _dateTime,
                        onChanged: (dateTime) =>
                            setState(() => _dateTime = dateTime),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child:
                          AutoSizeText("weight".tr, textAlign: TextAlign.start),
                    ),
                    new ListTile(
                      leading: new Image.asset(
                        "assets/icons/scale-bathroom.png",
                        color: Colors.grey[500],
                        height: 22.0.h,
                        width: 22.0.h,
                      ),
                      title: new TextFormField(
                        decoration: new InputDecoration(
                          hintText: 'to_value'.tr,
                        ),
                        controller: _textControllerWeight,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            removeError(error: kNullWeightField);
                            _weight = double.parse(value);
                          }
                          return null;
                        },
                        validator: (value) {
                          // if (value!.isEmpty || value == "0") {
                          //   addError(error: kNullWeightField);
                          //   return "";
                          // }
                          return null;
                        },
                      ),

                      // onTap: () => {_showNumberPicker(context)},
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: AutoSizeText("price".tr + ":",
                          textAlign: TextAlign.start),
                    ),
                    new ListTile(
                      leading: new Icon(Icons.money, color: Colors.grey[500]),
                      title: new TextFormField(
                        decoration: new InputDecoration(
                          hintText: 'to_value'.tr,
                        ),
                        controller: _textControllerPrice,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            removeError(error: kNullPriceField);
                            price = int.parse(value);
                          }
                          return null;
                        },
                        validator: (value) {
                          // if (value!.isEmpty || value == "0") {
                          //   addError(error: kNullPriceField);
                          //   return "";
                          // }
                          return null;
                        },
                      ),
                      // onTap: () => {_showNumberPicker(context)},
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    FormError(errors: errors),
                    SizedBox(
                      height: 10.h,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: DefaultButton(
                        text: 'find'.tr,
                        press: () {
                          checkRequestType();

                          // if all are valid then go to success screen
                          if (_formKey.currentState!.validate() &&
                              errors.isEmpty) {
                            _formKey.currentState!.save();
                            // if all are valid then go to success screen
                            debug.log('User createRequest valid');
                            debug.log('User createRequest valid countryValue');

                            KeyboardUtil.hideKeyboard(context);
                            Get.find<FilterController>().filterRequest(
                                RequestEntity(
                                    description: '',
                                    weight: _weight,
                                    price: price,
                                    from: Destination(
                                        country: countryValue.split(" ").last,
                                        region: stateValue,
                                        city: cityValue),
                                    to: Destination(
                                        country: toCountryValue.split(" ").last,
                                        region: toStateValue,
                                        city: toCityValue),
                                    deadline: _dateTime,
                                    user: UserProfile(
                                        id: "", phoneNumber: "phoneNumber"),
                                    requestType: resultRequestType));
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void checkRequestType() async {
    debug.log("dropdownReqTypeValue: $dropdownReqTypeValue");
    debug.log("list.elementAt(1): ${list.elementAt(1)}");
    if (dropdownReqTypeValue == list.elementAt(1)) {
      debug.log("list.elementAt(1) true: ${list.elementAt(1)}");

      resultRequestType = RequestType.sender;
      removeError(error: kWrongRequestType);
    } else if (dropdownReqTypeValue == list.elementAt(2)) {
      resultRequestType = RequestType.courier;
      removeError(error: kWrongRequestType);
    } else {
      addError(error: kWrongRequestType);
    }
  }
}
