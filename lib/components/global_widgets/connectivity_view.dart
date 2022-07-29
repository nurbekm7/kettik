import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ConnectivityPage extends StatefulWidget {
  final dynamic child;
  ConnectivityPage({Key? key, required this.child});

  @override
  State<ConnectivityPage> createState() => _ConnectivityPageState();
}

class _ConnectivityPageState extends State<ConnectivityPage> {
  late bool connected;
  double _width = 0;
  double _height = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        body: OfflineBuilder(
            connectivityBuilder: (
              BuildContext context,
              ConnectivityResult connectivity,
              Widget child,
            ) {
              final connected = connectivity != ConnectivityResult.none;
              _height = !connected ? 30.h : 0;

              return Stack(
                fit: StackFit.expand,
                children: [
                  child,
                  Positioned(
                    height: _height,
                    left: 0.0,
                    right: 0.0,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 350),
                      color: connected
                          ? const Color(0xFF00EE44)
                          : const Color(0xFFEE4400),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 350),
                        child: connected
                            ? AutoSizeText('online'.tr, maxLines: 1,)
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  AutoSizeText('offline'.tr, maxLines: 1,),
                                  SizedBox(width: 8.w),
                                  SizedBox(
                                    width: 12.w,
                                    height: 12.h,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.0,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                ],
              );
            },
            child: widget.child),
      ),
    );
  }
}
