import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kettik/components/coustom_bottom_nav_bar.dart';
import 'package:kettik/models/RequestEntity.dart';
import 'package:kettik/screens/filter/filter_controller.dart';
import 'package:kettik/screens/filter/filter_screen.dart';
import 'package:kettik/screens/home/components/folding_request_card.dart';
import 'package:kettik/screens/home/home_screen.dart';
import 'package:kettik/screens/sign_in/sign_in_screen.dart';
import 'package:kettik/screens/transaction/create_request_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kettik/constants.dart';
import 'package:kettik/components/settings_service.dart';
import 'package:flutter/scheduler.dart';

class FilterResultScreen extends StatefulWidget {
  FilterResultScreen({Key? key}) : super(key: key);

  @override
  _FilterResultScreenState createState() => new _FilterResultScreenState();
}

class _FilterResultScreenState extends State<FilterResultScreen> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FilterController>(builder: (controller) {
      return DefaultTabController(
        initialIndex: 0,
        length: 1,
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Get.offAll(() => HomeScreen()),
              ),
              title: AutoSizeText('filter'.tr,
                  textAlign: TextAlign.start, maxLines: 1),
              backgroundColor: kPrimaryColor,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.tune),
                  onPressed: () {
                    _openFilterDialog();
                  },
                )
              ],
              bottom: TabBar(tabs: [
                Tab(
                  icon: controller.selectedRequestType == RequestType.sender
                      ? Icon(Icons.post_add)
                      : Icon(FontAwesomeIcons.personWalking),
                  child: AutoSizeText(
                      controller.selectedRequestType == RequestType.sender
                          ? 'sender'.tr
                          : 'courier'.tr,
                      maxLines: 1),
                ),
              ]),
            ),
            body: TabBarView(children: [
              Container(
                child: controller.selectedRequestType == RequestType.sender
                    ? AnimationLimiter(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          primary: false,
                          shrinkWrap: true,
                          itemCount: controller.filteredSenderEntityList.length,
                          itemBuilder: (context, index) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              child: SlideAnimation(
                                // verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.all(8),
                                    child: Container(
                                      // height: 200.h,
                                      // width: _size.width,
                                      // child: RequestCard(requestEntity: demoCarts[index]),
                                      child: FoldingRequestCard(
                                          requestEntity: controller
                                              .filteredSenderEntityList[index]),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : AnimationLimiter(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          primary: false,
                          shrinkWrap: true,
                          itemCount:
                              controller.filteredCourierEntityList.length,
                          itemBuilder: (context, index) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              child: SlideAnimation(
                                // verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.all(8),
                                    child: Container(
                                      // height: 200.h,
                                      // width: _size.width,
                                      // child: RequestCard(requestEntity: demoCarts[index]),
                                      child: FoldingRequestCard(
                                          requestEntity: controller
                                                  .filteredCourierEntityList[
                                              index]),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              )
            ]),
            bottomNavigationBar: CustomBottomNavBar(cIndex: 0),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: new FloatingActionButton(
              onPressed: () {
                if (!Get.find<SettingsService>().isLoggedIn) {
                  _openSignInDialog();
                } else {
                  _openAddTransDialog();
                }
              },
              tooltip: 'Add',
              child: new Icon(Icons.add),
              backgroundColor: kPrimaryBtnColor,
            )),
      );
    });
  }

  Future _openFilterDialog() async {
    RequestEntity? requestEntity =
        await Navigator.of(context).push(new MaterialPageRoute<RequestEntity>(
            builder: (BuildContext context) {
              return new FilterDiolog();
            },
            fullscreenDialog: true));
    print(requestEntity);
    if (requestEntity != null) {
      print("requestEntity: ${requestEntity.id}");
      setState(() {
        // requestEntityList.add(requestEntity);
      });
    }
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
      setState(() {
        // requestEntityList.add(requestEntity);
      });
    }
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
