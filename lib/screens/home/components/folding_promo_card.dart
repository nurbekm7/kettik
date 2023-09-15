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

    return Container(child: innerTopWidget());
  }

  GestureDetector frontWidget() {
    return GestureDetector(
      onTap: () => _foldingCellKey.currentState?.toggleFold(),
      child: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.white,
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
                  padding: EdgeInsetsDirectional.all(8.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        AutoSizeText(promoEntity.name,
                            maxLines: 3,
                            style: TextStyle(
                              color: kTextColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            )),
                        // AutoSizeText("category",
                        //     maxLines: 1,
                        //     style: TextStyle(
                        //       color: kTextColor,
                        //       fontSize: 16.sp,
                        //     )),
                        SizedBox(height: 10.h),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: AutoSizeText(
                                  promoEntity.price.toString() + "currency".tr,
                                  style: TextStyle(
                                    color: kTextColor,
                                    fontSize: 18.0.sp,
                                    fontWeight: FontWeight.bold,
                                  )),
                            )
                          ],
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
                    AutoSizeText(promoEntity.name,
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          // fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ),
            ),

            //tilte
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () async {
                            await showDialog(
                                context: context,
                                builder: (_) => Dialog(
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        width: 200.w,
                                        height: 400.h,
                                        imageUrl: promoEntity.imageUrl,
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) =>
                                                Center(
                                                    child: Shimmer.fromColors(
                                          child: Container(),
                                          baseColor:
                                              Color.fromRGBO(224, 224, 224, 1),
                                          highlightColor:
                                              Color.fromRGBO(245, 245, 245, 1),
                                        )),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ));
                          },
                          child: ClipRRect(
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
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            AutoSizeText(promoEntity.user.name!,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20.sp)),
                            AutoSizeText(
                                promoEntity.price.toString() + "currency".tr,
                                style: TextStyle(
                                  color: kTextColor,
                                  fontSize: 18.0.sp,
                                  fontWeight: FontWeight.bold,
                                )),
                            Divider(),
                            AutoSizeText('from'.tr,
                                style: TextStyle(
                                    color: kTextColor, fontSize: 14.0)),
                            SizedBox(height: 5),
                            AutoSizeText(promoEntity.from.city,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14.0)),
                            Divider(),
                            Container(
                              padding: EdgeInsets.all(5),
                              child: AutoSizeText(promoEntity.description,
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18.0.sp)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    width: _size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        launchUrlString(
                            'https://api.whatsapp.com/send/?phone=' +
                                promoEntity.user.phoneNumber,
                            mode: LaunchMode.externalApplication);
                      }, //TODO show phone number
                      child: AutoSizeText(
                        'buy_request'.tr,
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryBtnColor),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
