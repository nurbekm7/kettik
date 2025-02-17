import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:folding_cell/folding_cell.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:kettik/components/settings_service.dart';
import 'package:kettik/models/RequestEntity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kettik/constants.dart';
import 'package:kettik/screens/sign_in/sign_in_screen.dart';
import 'package:url_launcher/url_launcher_string.dart';

class FoldingRequestCard extends StatelessWidget {
  final RequestEntity requestEntity;
  final _foldingCellKey = GlobalKey<SimpleFoldingCellState>();
  late Size _size;
  final DateFormat formatter =
      DateFormat.yMMMd(Get.find<SettingsService>().locale.toString());
  FoldingRequestCard({Key? key, required this.requestEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;

    return Container(
      child: SimpleFoldingCell.create(
        key: _foldingCellKey,
        frontWidget: frontWidget(),
        innerWidget: innerTopWidget(context),
        cellSize: Size(MediaQuery.of(context).size.width.w, 110.h),
        padding: EdgeInsets.all(5.0),
        animationDuration: Duration(milliseconds: 300),
        borderRadius: 3,
        onOpen: () => print('cell opened'),
        onClose: () => print('cell closed'),
      ),
    );
  }

  GestureDetector frontWidget() {
    return GestureDetector(
      onTap: () => _foldingCellKey.currentState?.toggleFold(),
      child: Container(
        color: Color(0xffdfd4f4),
        alignment: Alignment.center,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Color(0xff5a4d94),
                ),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              child: AutoSizeText(
                            requestEntity.price.toString() + "currency".tr,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )),
                          Container(
                              child: AutoSizeText(
                            formatter.format(requestEntity.deadline),
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.white,
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: [
                            Container(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(FontAwesomeIcons.locationDot,
                                  color: kPrimaryColor, size: 20.0),
                            )),
                            Expanded(
                                child: AutoSizeText(requestEntity.from.city,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    )))
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(FontAwesomeIcons.locationDot,
                                    color: kPrimaryColor, size: 20.0),
                              ),
                            ),
                            Expanded(
                              child: AutoSizeText(requestEntity.to.city,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0.sp,
                                    fontWeight: FontWeight.bold,
                                  )),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(FontAwesomeIcons.weightHanging,
                                    color: kPrimaryColor, size: 20.0),
                              ),
                            ),
                            Expanded(
                              // width: _size.width * 0.35,
                              child: AutoSizeText(
                                  requestEntity.weight.toString() + " kg",
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ],
                        ),
                      ])),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector innerTopWidget(BuildContext context) {
    return GestureDetector(
      onTap: () => _foldingCellKey.currentState?.toggleFold(),
      child: Container(
        color: kLightGrey,
        alignment: Alignment.center,
        child: Container(
          child: Column(
            children: <Widget>[
              //Heading
              Container(
                width: _size.width,
                color: kPrimaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: AutoSizeText(
                            "until_date".tr +
                                " " +
                                formatter.format(requestEntity.deadline),
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: AutoSizeText(
                            "price".tr + " " + requestEntity.price.toString(),
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ],
                  ),
                ),
              ),

              //tilte
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        FontAwesomeIcons.person,
                        color: kTextColor,
                      ),
                    )),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AutoSizeText(requestEntity.user.name!,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    )
                  ],
                ),
              ),
              Divider(),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        AutoSizeText('from'.tr,
                            style:
                                TextStyle(color: kTextColor, fontSize: 14.0)),
                        SizedBox(height: 5),
                        AutoSizeText(requestEntity.from.city,
                            style:
                                TextStyle(color: Colors.black, fontSize: 14.0)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        AutoSizeText('to'.tr,
                            style: TextStyle(
                                color: kTextColor, fontSize: 14.0.sp)),
                        SizedBox(height: 5),
                        AutoSizeText(requestEntity.to.city,
                            style: TextStyle(
                                color: Colors.black, fontSize: 14.0.sp))
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        AutoSizeText('weight'.tr,
                            style: TextStyle(
                                color: kTextColor, fontSize: 14.0.sp)),
                        SizedBox(height: 5),
                        AutoSizeText(requestEntity.weight.toString() + " kg",
                            style: TextStyle(
                                color: Colors.black, fontSize: 14.0.sp))
                      ],
                    ),
                  )
                ],
              ),
              Divider(),

              //Priority
              Container(
                padding: EdgeInsets.all(10),
                child: AutoSizeText(requestEntity.description,
                    maxLines: 3,
                    style: TextStyle(color: Colors.black, fontSize: 18.0.sp)),
              ),

              Container(
                  width: _size.width,
                  child: Get.find<SettingsService>().userProfile != null &&
                          requestEntity.user.phoneNumber ==
                              Get.find<SettingsService>()
                                  .userProfile!
                                  .phoneNumber
                      ? ElevatedButton(
                          onPressed: () {},
                          child: AutoSizeText(
                            'send_request_yours'.tr,
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimaryBtnColor),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            if (!Get.find<SettingsService>().isLoggedIn) {
                              _openSignInDialog(context);
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("alert_title".tr),
                                    content: Text("alert_content".tr),
                                    actions: [
                                      TextButton(
                                        child: Text("cancel".tr),
                                        onPressed: () async {
                                          Navigator.of(context)
                                              .pop(); // dismiss dialog
                                        },
                                      ),
                                      TextButton(
                                        child: Text("OK"),
                                        onPressed: () async {
                                          await launchUrlString(
                                              'https://api.whatsapp.com/send/?phone=' +
                                                  requestEntity
                                                      .user.phoneNumber,
                                              mode: LaunchMode
                                                  .externalApplication);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          child: AutoSizeText(
                            'send_request'.tr,
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimaryBtnColor),
                        ))
            ],
          ),
        ),
      ),
    );
  }

  Future _openSignInDialog(BuildContext context) async {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.of(context).push(MaterialPageRoute<String>(
          builder: (BuildContext context) {
            return SignInScreen();
          },
          fullscreenDialog: true));
    });
  }
}
