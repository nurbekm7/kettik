import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kettik/components/coustom_bottom_nav_bar.dart';
import 'package:kettik/models/PromoEntity.dart';
import 'package:kettik/models/RequestEntity.dart';
import 'package:kettik/screens/filter/filter_screen.dart';
import 'package:kettik/screens/home/components/folding_promo_card.dart';
import 'package:kettik/screens/home/components/folding_request_card.dart';
import 'package:kettik/screens/home/home_controller.dart';
import 'package:kettik/screens/sign_in/sign_in_screen.dart';
import 'package:kettik/screens/transaction/create_request_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kettik/constants.dart';
import 'package:kettik/components/settings_service.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<RequestEntity> senderEntityList;
  late List<RequestEntity> courierEntityList;
  late List<PromoEntity> promoEntityList;
  late Future<void> _initData;
  late HomeController homeController;

  @override
  void initState() {
    super.initState();
    homeController = Get.put(HomeController());
    _initData = _initDataController();
  }

  Future<void> _initDataController() async {
    final lsenderEntityList = await homeController.getSenderRequests();
    final lcourierEntityList = await homeController.getCourierRequests();
    final lpromoEntityList = await homeController.getPromoList();
    senderEntityList = lsenderEntityList;
    courierEntityList = lcourierEntityList;
    promoEntityList = lpromoEntityList;
  }

  Future<void> _refreshData() async {
    final lsenderEntityList = await homeController.getSenderRequests();
    final lcourierEntityList = await homeController.getCourierRequests();
    final lpromoEntityList = await homeController.getPromoList();

    setState(() {
      senderEntityList = lsenderEntityList;
      courierEntityList = lcourierEntityList;
      promoEntityList = lpromoEntityList;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    String kettikName = (Get.find<SettingsService>().userProfile == null
        ? ""
        : ", " + Get.find<SettingsService>().userProfile!.name!);
    return WillPopScope(
        onWillPop: () async => false,
        child: DefaultTabController(
          initialIndex: 0,
          length: 3,
          child: Scaffold(
              appBar: AppBar(
                title: Align(
                  alignment: Alignment.topLeft,
                  child: AutoSizeText('Kettik' + kettikName,
                      textAlign: TextAlign.start, maxLines: 1),
                ),
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
                    icon: Icon(Icons.production_quantity_limits),
                    child: AutoSizeText('promo'.tr, maxLines: 1),
                  ),
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
              body: getFutureBuilder(),
              // body: TabBarView(children: getTabChildren(controller)),
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
        ));
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
    print("promoEntityList view: " + promoEntityList.toString());
    return [
      Container(
          child: promoEntityList.isNotEmpty
              ? AnimationLimiter(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      print("RefreshIndicator");
                      _refreshData();
                    },
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      primary: false,
                      shrinkWrap: true,
                      itemCount: promoEntityList.length,
                      itemBuilder: (context, index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                            child: FadeInAnimation(
                              child: Padding(
                                padding: const EdgeInsetsDirectional.all(8),
                                child: Container(
                                  child: FoldingPromoCard(
                                      promoEntity: promoEntityList[index]),
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
                      children: [Icon(Icons.arrow_downward, size: 100.w)]))),
      getOneTab(senderEntityList),
      getOneTab(courierEntityList)
    ];
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

  Future _openFilterDialog() async {
    Get.to(() => FilterDiolog());
  }

  Future _openAddTransDialog() async {
    Get.to(() => CreateRequestScreen());
  }

  Future _openSignInDialog() async {
    Get.to(() => SignInScreen());

    // SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
    //   Navigator.of(context).push(MaterialPageRoute<String>(
    //       builder: (BuildContext context) {
    //         return SignInScreen();
    //       },
    //       fullscreenDialog: true));
    // });
  }
}
