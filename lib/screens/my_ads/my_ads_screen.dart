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
  List<RequestEntity> requestEntityList = demoRequestCarts;

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: AutoSizeText(
              'my_transactions'.tr,
              textAlign: TextAlign.center,
            ),
            backgroundColor: kPrimaryColor,
            actions: <Widget>[],
            bottom: TabBar(tabs: [
              Tab(
                icon: Icon(Icons.post_add),
                child: AutoSizeText('isender'.tr),
              ),
              Tab(
                icon: Icon(FontAwesomeIcons.personWalking),
                child: AutoSizeText('icourier'.tr),
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
  }

  Future _openDialog() async {
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
}
