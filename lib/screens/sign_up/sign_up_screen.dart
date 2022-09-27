import 'package:flutter/material.dart';
import 'package:kettik/components/global_widgets/loading_overlay.dart';

import 'components/body.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Container(
          color: Colors.black,
          child: Scaffold(
            body: Body(),
          ),
        ),
      ),
    );
  }
}
