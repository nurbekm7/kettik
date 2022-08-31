import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kettik/components/coustom_bottom_nav_bar.dart';
import 'package:kettik/enums.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kettik/models/RequestEntity.dart';
import 'package:kettik/screens/filter/filter_binding.dart';
import 'package:kettik/screens/filter/filter_screen.dart';
import 'package:kettik/screens/home/components/folding_request_card.dart';
import 'package:kettik/screens/transaction/transaction_screen.dart';
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
  String? _selected = "";
  List<RequestEntity> requestEntityList = demoCarts;
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
                icon: Image.asset('assets/icons/filter.png'),
                onPressed: () {
                  _openDialog();
                },
              )
            ],
            bottom: TabBar(tabs: [
              Tab(
                icon: Icon(Icons.post_add),
                child: AutoSizeText('sender'.tr),
              ),
              Tab(
                icon: Icon(FontAwesomeIcons.personWalking),
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
            ),
          ]),
          bottomNavigationBar: CustomBottomNavBar(cIndex: 0),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: new FloatingActionButton(
            onPressed: () {
              _openAddTransDialog();
            },
            tooltip: 'Increment',
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
              return new CreateTransactionScreen();
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
