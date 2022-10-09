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
    Size _size = MediaQuery.of(context).size;

    return GetBuilder<MyAdsController>(builder: (controller) {
      controller.loadData();
      return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Get.off(() => ProfileScreen()),
              ),
              title: AutoSizeText('my_transactions'.tr,
                  textAlign: TextAlign.center, maxLines: 1),
              backgroundColor: kPrimaryColor,
              bottom: TabBar(tabs: [
                Tab(
                  icon: Icon(Icons.post_add),
                  child: AutoSizeText('sender'.tr, maxLines: 1),
                ),
                Tab(
                  icon: Icon(FontAwesomeIcons.personWalking),
                  child: AutoSizeText('courier'.tr, maxLines: 1),
                ),
              ]),
            ),
            body: RefreshIndicator(
              onRefresh: () => _pullRefresh(controller),
              child: TabBarView(children: [
                Container(
                  child: controller.mySenderEntityList.isNotEmpty
                      ? AnimationLimiter(
                          child: ListView.builder(
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
                        )
                      : Icon(Icons.arrow_downward, size: 100.w),
                ),
                Container(
                  child: controller.myCourierEntityList.isNotEmpty
                      ? AnimationLimiter(
                          child: ListView.builder(
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
                        )
                      : Icon(Icons.arrow_downward, size: 100.w),
                )
              ]),
            ),
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

  Future<void> _pullRefresh(MyAdsController myAdsController) async {
    myAdsController.onInit();
    setState(() {});
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
