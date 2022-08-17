import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:folding_cell/folding_cell.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kettik/models/RequestEntity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:kettik/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class FoldingRequestCard extends StatelessWidget {
  final RequestEntity requestEntity;
  final _foldingCellKey = GlobalKey<SimpleFoldingCellState>();
  late Size _size;
  FoldingRequestCard({Key? key, required this.requestEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;

    return Container(
      child: SimpleFoldingCell.create(
        key: _foldingCellKey,
        frontWidget: frontWidget(),
        innerWidget: innerTopWidget(),
        cellSize: Size(MediaQuery.of(context).size.width, 140),
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
      onTap: () => _foldingCellKey?.currentState?.toggleFold(),
      child: Container(
        color: Color(0xffdfd4f4),
        alignment: Alignment.center,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
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
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AutoSizeText(
                              requestEntity.price.toString() + ' KZT',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          )),
                          Container(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AutoSizeText(
                              'До',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            ),
                          )),
                          Container(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AutoSizeText(
                              requestEntity.fromTime,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            ),
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
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
                            Container(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AutoSizeText(requestEntity.from,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  )),
                            )),
                            Container(
                              width: _size.width * 0.35,
                              child: Align(
                                alignment: Alignment.topRight,
                                child: AutoSizeText(
                                    'Вес: ' + requestEntity.weight.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                            ),
                          ],
                        ),
                        Container(
                            child: Row(
                          children: <Widget>[
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(FontAwesomeIcons.locationDot,
                                    color: kPrimaryColor, size: 20.0),
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AutoSizeText(requestEntity.to,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0.sp,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                            )
                          ],
                        )),
                      ])),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector innerTopWidget() {
    return GestureDetector(
      onTap: () => _foldingCellKey?.currentState?.toggleFold(),
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
                        child: AutoSizeText('# ' + requestEntity.id,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      SizedBox(
                        width: _size.width * 0.5,
                      ),
                      Expanded(
                        child: AutoSizeText(
                            requestEntity.price.toString() + ' KZT',
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
                        child: AutoSizeText(
                            requestEntity.user.firstName +
                                ' ' +
                                requestEntity.user.lastName,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              //Rating
              // Row(
              //   children: [
              //     Container(
              //       width: _size.width * 0.5,
              //       height: 15.h,
              //       padding: EdgeInsetsDirectional.only(start: 50),
              //       alignment: Alignment.topLeft,
              //       child: RatingBar.builder(
              //         initialRating: requestEntity.user.rating,
              //         minRating: 1,
              //         direction: Axis.horizontal,
              //         allowHalfRating: true,
              //         itemCount: 5,
              //         itemSize: 15.h,
              //         itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              //         itemBuilder: (context, _) => Icon(
              //           FontAwesomeIcons.solidHeart,
              //           color: Colors.black,
              //         ),
              //         onRatingUpdate: (rating) {
              //           print(rating);
              //         },
              //         ignoreGestures: true,
              //       ),
              //     ),
              //     Container(
              //       child: AutoSizeText(
              //           '(' +
              //               requestEntity.user.userReview.length.toString() +
              //               ')',
              //           style: TextStyle(
              //             color: Colors.black,
              //             fontSize: 14.0,
              //             fontWeight: FontWeight.bold,
              //           )),
              //     ),
              //   ],
              // ),
              Divider(),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        AutoSizeText('FROM'.tr,
                            style:
                                TextStyle(color: kTextColor, fontSize: 14.0)),
                        SizedBox(height: 5),
                        AutoSizeText(requestEntity.from,
                            style:
                                TextStyle(color: Colors.black, fontSize: 14.0)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        AutoSizeText('TO'.tr,
                            style: TextStyle(
                                color: kTextColor, fontSize: 14.0.sp)),
                        SizedBox(height: 5),
                        AutoSizeText(requestEntity.to,
                            style: TextStyle(
                                color: Colors.black, fontSize: 14.0.sp))
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        AutoSizeText('WEIGHT'.tr,
                            style: TextStyle(
                                color: kTextColor, fontSize: 14.0.sp)),
                        SizedBox(height: 5),
                        AutoSizeText(requestEntity.weight.toString(),
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
                    style: TextStyle(color: Colors.black, fontSize: 18.0.sp)),
              ),

              Container(
                padding: EdgeInsets.all(10),
                width: _size.width,
                child: ElevatedButton(
                  onPressed: () {
                    launch('tel:' + requestEntity.user.phoneNumber);
                  }, //TODO show phone number
                  child: AutoSizeText(
                    'SEND_REQUEST'.tr,
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(primary: kPrimaryBtnColor),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
