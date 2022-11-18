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
  late MyAdsController myAdsController;
  late List<RequestEntity> senderEntityList;
  late List<RequestEntity> courierEntityList;
  late Future<void> _initData;

  @override
  void initState() {
    super.initState();
    myAdsController = Get.put(MyAdsController());
    _initData = _initDataController();
  }

  Future<void> _refreshData() async {
    final lsenderEntityList = await myAdsController.getSenderRequests();
    final lcourierEntityList = await myAdsController.getCourierRequests();

    setState(() {
      senderEntityList = lsenderEntityList;
      courierEntityList = lcourierEntityList;
    });
  }

  Future<void> _initDataController() async {
    final lsenderEntityList = await myAdsController.getSenderRequests();
    final lcourierEntityList = await myAdsController.getCourierRequests();
    senderEntityList = lsenderEntityList;
    courierEntityList = lcourierEntityList;
  }

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
            body: getFutureBuilder(),
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

  Widget getFutureBuilder() {
    return FutureBuilder(
      future: _initData, // a previously-obtained Future<String> or null
      builder: (context, snapshot) {
        List<Widget> children;
        if (snapshot.connectionState == ConnectionState.done) {
          print("calculationAsync completed: ");
          children = getTabChildren();
        } else {
          children = <Widget>[
            getCircularProgressIndicator(),
            getCircularProgressIndicator()
          ];
        }
        return TabBarView(children: children);
      },
    );
  }

  Widget getCircularProgressIndicator() {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              child: CircularProgressIndicator(),
              height: 20.0,
              width: 20.0,
            )
          ],
        ),
      ),
    );
  }

  List<Widget> getTabChildren() {
    print("senderEntityList view: " + senderEntityList.toString());
    return [getOneTab(senderEntityList), getOneTab(courierEntityList)];
  }

  Widget getOneTab(List list) {
    return Container(
        child: list.isNotEmpty
            ? RefreshIndicator(
                onRefresh: () async {
                  print("RefreshIndicator");
                  _refreshData();
                },
                child: AnimationLimiter(
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    primary: false,
                    shrinkWrap: true,
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          child: FadeInAnimation(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.all(8),
                              child: Container(
                                child: FoldingRequestCard(
                                    requestEntity: list[index]),
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
                  _refreshData();
                },
                child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    primary: false,
                    shrinkWrap: true,
                    children: [Icon(Icons.arrow_downward, size: 100.w)])));
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
