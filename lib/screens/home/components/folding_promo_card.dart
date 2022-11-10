import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:folding_cell/folding_cell.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kettik/components/settings_service.dart';
import 'package:kettik/models/PromoEntity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kettik/constants.dart';
import 'package:kettik/screens/sign_in/sign_in_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher_string.dart';

class FoldingPromoCard extends StatefulWidget {
  FoldingPromoCard({Key? key, required this.promoEntity}) : super(key: key);
  final PromoEntity promoEntity;

  @override
  _FoldingPromoCardState createState() =>
      new _FoldingPromoCardState(promoEntity: promoEntity);
}

class _FoldingPromoCardState extends State<FoldingPromoCard> {
  final PromoEntity promoEntity;
  final _foldingCellKey = GlobalKey<SimpleFoldingCellState>();
  late Size _size;
  _FoldingPromoCardState({required this.promoEntity});

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;

    return Container(
      child: SimpleFoldingCell.create(
        key: _foldingCellKey,
        frontWidget: frontWidget(),
        innerWidget: innerTopWidget(),
        cellSize: Size(MediaQuery.of(context).size.width, 140.h),
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
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Color(0xffdfd4f4),
                ),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              width: 110.w,
                              height: 120.h,
                              imageUrl: promoEntity.imageUrl,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                      child: Shimmer.fromColors(
                                child: Container(),
                                baseColor: Color.fromRGBO(224, 224, 224, 1),
                                highlightColor:
                                    Color.fromRGBO(245, 245, 245, 1),
                              )),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
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
                              child: AutoSizeText(promoEntity.name,
                                  maxLines: 3,
                                  style: TextStyle(
                                    color: kTextColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  )),
                            )),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              AutoSizeText("promo_price".tr,
                                  style: TextStyle(
                                      color: kTextColor, fontSize: 16.0.sp)),
                              Flexible(
                                child: AutoSizeText(
                                    promoEntity.price.toString() +
                                        "currency".tr,
                                    style: TextStyle(
                                      color: kTextColor,
                                      fontSize: 18.0.sp,
                                      fontWeight: FontWeight.bold,
                                    )),
                              )
                            ],
                          ),
                        ),
                      ])),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector innerTopWidget() {
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
                        child: AutoSizeText('# ' + promoEntity.id,
                            maxLines: 1,
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
                        child:
                            AutoSizeText(promoEntity.price.toString() + ' \$',
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
                        child: AutoSizeText("buyer".tr + promoEntity.user.name!,
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
                        AutoSizeText('from'.tr,
                            style:
                                TextStyle(color: kTextColor, fontSize: 14.0)),
                        SizedBox(height: 5),
                        AutoSizeText(promoEntity.from.city,
                            style:
                                TextStyle(color: Colors.black, fontSize: 14.0)),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(),

              //Priority
              Container(
                padding: EdgeInsets.all(10),
                child: AutoSizeText(promoEntity.description,
                    maxLines: 2,
                    style: TextStyle(color: Colors.black, fontSize: 18.0.sp)),
              ),

              Container(
                padding: EdgeInsets.all(10),
                width: _size.width,
                child: ElevatedButton(
                  onPressed: () {
                    if (!Get.find<SettingsService>().isLoggedIn) {
                      _openSignInDialog();
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
                                  Navigator.of(context).pop(); // dismiss dialog
                                },
                              ),
                              TextButton(
                                child: Text("OK"),
                                onPressed: () async {
                                  await launchUrlString(
                                      'https://api.whatsapp.com/send/?phone=' +
                                          promoEntity.user.phoneNumber,
                                      mode: LaunchMode.externalApplication);
                                },
                              ),
                            ],
                          );
                          ;
                        },
                      );
                    }
                  }, //TODO show phone number
                  child: AutoSizeText(
                    'send_request'.tr,
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

  Future _openSignInDialog() async {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.of(context).push(MaterialPageRoute<String>(
          builder: (BuildContext context) {
            return SignInScreen();
          },
          fullscreenDialog: true));

      setState(() {});
    });
  }
}
