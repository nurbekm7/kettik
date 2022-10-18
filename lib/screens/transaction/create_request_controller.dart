import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kettik/models/RequestEntity.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kettik/screens/my_ads/my_ads_screen.dart';

class CreateRequestController extends GetxController {
  bool showLoadingOverlay = false;
  FirebaseFirestore db = FirebaseFirestore.instance;

  void createRequest(RequestEntity requestEntity) async {
// Add a new document with a generated ID
    showLoadingOverlay = true;
    var collection = requestEntity.requestType == RequestType.sender
        ? "sender_transaction"
        : "courier_transaction";
    update();
    db
        .collection(collection)
        .add(requestEntity.toJson())
        .then((DocumentReference doc) async {
      print('DocumentSnapshot added with ID: ${doc.id}');
      showLoadingOverlay = false;
      Get.offAll(() => MyAdsScreen());
    }).catchError((e) {
      print(e);
      showLoadingOverlay = false;
      update();
      Fluttertoast.showToast(msg: 'internal_server_error'.tr);
    });
  }
}
