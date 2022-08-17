import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kettik/components/coustom_bottom_nav_bar.dart';
import 'package:kettik/enums.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kettik/models/RequestEntity.dart';
import 'package:kettik/screens/home/components/folding_request_card.dart';
import '../home/components/categories.dart';
import '../home/components/special_offers.dart';
import '../home/components/popular_product.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kettik/constants.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static String routeName = "/home";

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
              'Kettik',
              textAlign: TextAlign.center,
            ),
            backgroundColor: kPrimaryColor,
            actions: <Widget>[
              IconButton(
                icon: Icon(FontAwesomeIcons.filterCircleDollar,
                    color: Colors.white.withOpacity(0.5)),
                onPressed: () {
                  // do something
                },
              )
            ],
            bottom: TabBar(tabs: [
              Tab(
                icon: Icon(Icons.people),
                child: AutoSizeText('sender'.tr),
              ),
              Tab(
                icon: Icon(Icons.location_city),
                child: AutoSizeText('courier'.tr),
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
                                requestEntity: demoCarts[index]),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Container(
                    // height: 200.h,
                    // width: _size.width,
                    // child: RequestCard(requestEntity: demoCarts[index]),
                    child: FoldingRequestCard(requestEntity: demoCarts[0]),
                  ),
                  Container(
                    // height: 200.h,
                    // width: _size.width,
                    // child: RequestCard(requestEntity: demoCarts[index]),
                    child: FoldingRequestCard(requestEntity: demoCarts[1]),
                  )
                ],
              ),
            )
          ]),
          bottomNavigationBar: CustomBottomNavBar(cIndex: 0),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: new FloatingActionButton(
            onPressed: () {
              print("floating ");
            },
            tooltip: 'Increment',
            child: new Icon(Icons.add),
            backgroundColor: kPrimaryBtnColor,
          )),
    );
  }
}
