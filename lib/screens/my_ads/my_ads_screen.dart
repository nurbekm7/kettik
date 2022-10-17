import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kettik/components/coustom_bottom_nav_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kettik/models/RequestEntity.dart';
import 'package:kettik/screens/home/components/folding_request_card.dart';
import 'package:kettik/screens/my_ads/my_ads_controller.dart';
import 'package:kettik/screens/profile/profile_screen.dart';
import 'package:kettik/screens/transaction/create_request_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kettik/constants.dart';

class MyAdsScreen extends StatefulWidget {
  MyAdsScreen({Key? key}) : super(key: key);

  @override
  _MyAdsScreenState createState() => new _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyAdsController>(builder: (controller) {
      return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Get.offAll(() => ProfileScreen()),
              ),
              title: AutoSizeText('my_transactions'.tr,
                  textAlign: TextAlign.center, maxLines: 1),
              backgroundColor: kPrimaryColor,
              bottom: TabBar(tabs: [
                Tab(
                  icon: Icon(Icons.post_add),
                  child: AutoSizeText('isender'.tr, maxLines: 1),
                ),
                Tab(
                  icon: Icon(FontAwesomeIcons.personWalking),
                  child: AutoSizeText('icourier'.tr, maxLines: 1),
                ),
              ]),
            ),
            body: TabBarView(children: [
              Container(
                  child: controller.mySenderEntityList.isNotEmpty
                      ? RefreshIndicator(
                          onRefresh: () async {
                            print("RefreshIndicator");
                            controller.loadData();
                          },
                          child: AnimationLimiter(
                            child: ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              primary: false,
                              shrinkWrap: true,
                              itemCount: controller.mySenderEntityList.length,
                              itemBuilder: (context, index) {
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 375),
                                  child: SlideAnimation(
                                    // verticalOffset: 50.0,
                                    child: FadeInAnimation(
                                      child: Padding(
                                        padding:
                                            const EdgeInsetsDirectional.all(8),
                                        child: Container(
                                          // height: 200.h,
                                          // width: _size.width,
                                          // child: RequestCard(requestEntity: demoCarts[index]),
                                          child: FoldingRequestCard(
                                              requestEntity: controller
                                                  .mySenderEntityList[index]),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: () async {
                            print("RefreshIndicator Icon");
                            controller.loadData();
                          },
                          child: ListView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              primary: false,
                              shrinkWrap: true,
                              children: [
                                Icon(Icons.arrow_downward, size: 100.w)
                              ]))),
              Container(
                  child: controller.myCourierEntityList.isNotEmpty
                      ? RefreshIndicator(
                          onRefresh: () async {
                            print("RefreshIndicator");
                            controller.loadData();
                          },
                          child: AnimationLimiter(
                            child: ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              primary: false,
                              shrinkWrap: true,
                              itemCount: controller.myCourierEntityList.length,
                              itemBuilder: (context, index) {
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 375),
                                  child: SlideAnimation(
                                    // verticalOffset: 50.0,
                                    child: FadeInAnimation(
                                      child: Padding(
                                        padding:
                                            const EdgeInsetsDirectional.all(8),
                                        child: Container(
                                          // height: 200.h,
                                          // width: _size.width,
                                          // child: RequestCard(requestEntity: demoCarts[index]),
                                          child: FoldingRequestCard(
                                              requestEntity: controller
                                                  .myCourierEntityList[index]),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: () async {
                            print("RefreshIndicator Icon");
                            controller.loadData();
                          },
                          child: ListView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              primary: false,
                              shrinkWrap: true,
                              children: [
                                Icon(Icons.arrow_downward, size: 100.w)
                              ])))
            ]),
            bottomNavigationBar: CustomBottomNavBar(cIndex: 1),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: new FloatingActionButton(
              onPressed: () {
                _openAddTransDialog();
              },
              tooltip: 'Add',
              child: new Icon(Icons.add),
              backgroundColor: kPrimaryBtnColor,
            )),
      );
    });
  }

  Future _openAddTransDialog() async {
    RequestEntity? requestEntity =
        await Navigator.of(context).push(new MaterialPageRoute<RequestEntity>(
            builder: (BuildContext context) {
              return new CreateRequestScreen();
            },
            fullscreenDialog: true));
    print(requestEntity);
    if (requestEntity != null) {
      print("requestEntity: ${requestEntity.id}");
      setState(() {});
    }
  }
}
