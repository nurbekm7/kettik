import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kettik/components/settings_service.dart';
import 'package:kettik/models/PromoEntity.dart';
import 'package:kettik/models/RequestEntity.dart';
import 'package:kettik/models/UserProfile.dart';
import 'package:get/get.dart';

class MyAdsController extends GetxController {
  List<RequestEntity> mySenderEntityList = List.empty();
  List<RequestEntity> myCourierEntityList = List.empty();
  List<PromoEntity> promoEntityList = List.empty();
  bool showLoadingOverlay = false;
  FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  void onInit() {
    super.onInit();
    if (Get.find<SettingsService>().isLoggedIn) {
      loadData();
    }
  }

  @override
  void onReady() {
    super.onReady();
    if (Get.find<SettingsService>().isLoggedIn) {
      loadData();
    }
  }

  @override
  void onClose() {
    if (Get.find<SettingsService>().isLoggedIn) {
      loadData();
    }
  }

  void loadData() {
    showLoadingOverlay = true;
    print("loadData request: ");
    getCourierRequests();
    getSenderRequests();
    showLoadingOverlay = false;
  }

  Future<List<RequestEntity>> toRequestEntity(RequestType requestType,
      List<QueryDocumentSnapshot<Map<String, dynamic>>> data) async {
    return data
        .map((e) => RequestEntity(
            id: e.id,
            description: e.data()["description"],
            price: e.data()["price"],
            weight: e.data()["weight"],
            from: Destination(
                country: e.data()["from"]["country"],
                region: e.data()["from"]["region"],
                city: e.data()["from"]["city"]),
            to: Destination(
                country: e.data()["to"]["country"],
                region: e.data()["to"]["region"],
                city: e.data()["to"]["city"]),
            deadline: (e.data()["deadline"] as Timestamp).toDate(),
            user: UserProfile(
                id: e.data()["user"]["id"],
                name: e.data()["user"]["name"],
                phoneNumber: e.data()["user"]["phoneNumber"],
                photoURL: e.data()["user"]["photoURL"]),
            requestType: requestType))
        .toList();
  }

  Future<List<RequestEntity>> getSenderRequests() async {
    try {
      return db
          .collection("sender_transaction")
          .where("user.phoneNumber",
              isEqualTo: Get.find<SettingsService>().userProfile!.phoneNumber)
          .orderBy("deadline", descending: true)
          .get()
          .then(
        (res) async {
          print("mySenderEntityList res.docs: " + res.docs.toString());
          return mySenderEntityList = res.docs.length == 0
              ? mySenderEntityList
              : await toRequestEntity(RequestType.sender, res.docs);
        },
        onError: (e) => print("Error completing: $e"),
      );
    } catch (e) {
      Fluttertoast.showToast(msg: 'get_sender_requests_exception'.tr);
      return mySenderEntityList;
    }
  }

  Future<List<RequestEntity>> getCourierRequests() async {
    try {
      return db
          .collection("courier_transaction")
          .where("user.phoneNumber",
              isEqualTo: Get.find<SettingsService>().userProfile!.phoneNumber)
          .orderBy("deadline", descending: true)
          .get()
          .then(
        (res) async {
          print("myCourierEntityList res.docs: " + res.docs.toString());
          return myCourierEntityList = res.docs.length == 0
              ? myCourierEntityList
              : await toRequestEntity(RequestType.courier, res.docs);
        },
        onError: (e) => print("Error completing: $e"),
      );
    } catch (e) {
      print("get_courier_requests_exception: " + e.toString());
      Fluttertoast.showToast(msg: 'get_courier_requests_exception'.tr);
      return myCourierEntityList;
    }
  }

  bool compareDateTime(DateTime deadline) {
    var now = DateTime.now();
    return now.year <= deadline.year &&
        now.month <= deadline.month &&
        now.day <= deadline.day;
  }
}
