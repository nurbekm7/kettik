import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kettik/components/coustom_bottom_nav_bar.dart';
import 'package:kettik/enums.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kettik/models/PromoEntity.dart';
import 'package:kettik/models/RequestEntity.dart';
import 'package:kettik/screens/filter/filter_binding.dart';
import 'package:kettik/screens/filter/filter_screen.dart';
import 'package:kettik/screens/home/components/folding_promo_card.dart';
import 'package:kettik/screens/home/components/folding_request_card.dart';
import 'package:kettik/screens/sign_in/sign_in_screen.dart';
import 'package:kettik/screens/transaction/create_request_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kettik/constants.dart';
import 'package:kettik/components/settings_service.dart';
import 'package:flutter/scheduler.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<RequestEntity> requestEntityList = demoRequestCarts;
  List<PromoEntity> promoEntityList = demoCarts;

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    String kettikName = (Get.find<SettingsService>().userProfile == null
        ? ""
        : Get.find<SettingsService>().userProfile!.name ??
            Get.find<SettingsService>().userProfile!.phoneNumber);
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: AutoSizeText(
              kettikName + ' Kettik',
              textAlign: TextAlign.center,
            ),
            backgroundColor: kPrimaryColor,
            actions: <Widget>[
              IconButton(
                icon: Image.asset('assets/icons/filter.png'),
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
          body: TabBarView(children: [
            AnimationLimiter(
              child: ListView.builder(
                // physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                primary: false,
                shrinkWrap: true,
                itemCount: demoCarts.length,
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
            AnimationLimiter(
              child: ListView.builder(
                // physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                primary: false,
                shrinkWrap: true,
                itemCount: demoCarts.length,
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
                                requestEntity: requestEntityList[index]),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            AnimationLimiter(
              child: ListView.builder(
                // physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                primary: false,
                shrinkWrap: true,
                itemCount: demoCarts.length,
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
                                requestEntity: requestEntityList[index]),
                          ),
                        ),
                      ),
                    ),
                  );
                },
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
        requestEntityList.add(requestEntity);
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
        requestEntityList.add(requestEntity);
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
