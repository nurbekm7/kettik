import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kettik/models/PromoEntity.dart';
import 'package:kettik/models/RequestEntity.dart';
import 'package:kettik/models/UserProfile.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  List<RequestEntity> senderEntityList = List.empty();
  List<RequestEntity> courierEntityList = List.empty();
  List<PromoEntity> promoEntityList = List.empty();
  bool showLoadingOverlay = false;
  FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  @override
  void onReady() {
    super.onReady();
    loadData();
  }

  @override
  void onClose() {
    loadData();
  }

  void loadData() async {
    showLoadingOverlay = true;
    getPromoList();
    getCourierRequests();
    getSenderRequests();
    showLoadingOverlay = false;
  }

  Future<void> getPromoList() async {
    try {
      db.collection("promo").orderBy("until").get().then(
        (res) async {
          print("promoEntityList res.docs: " + res.docs.toString());
          promoEntityList = res.docs.length == 0
              ? promoEntityList
              : await toPromoEntity(res.docs);
          print("promoEntityList: " + promoEntityList.toString());
        },
        onError: (e) => print("Error completing: $e"),
      );
      Future.delayed(Duration(milliseconds: 20), () {
        update();
      });
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
          msg: 'get_promo_list_exception'.tr + " " + e.toString());
    }
  }

  Future<List<PromoEntity>> toPromoEntity(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> data) async {
    return data
        .where((element) =>
            compareDateTime((element.data()["deadline"] as Timestamp).toDate()))
        .map((e) => PromoEntity(
              id: e.id,
              name: e.data()["name"],
              imageUrl: e.data()["imageUrl"],
              description: e.data()["description"],
              price: e.data()["price"],
              from: Destination(
                  country: e.data()["from"]["country"],
                  region: e.data()["from"]["region"],
                  city: e.data()["from"]["city"]),
              until: (e.data()["until"] as Timestamp).toDate(),
              user: UserProfile(
                  id: e.data()["user"]["id"],
                  name: e.data()["user"]["name"],
                  phoneNumber: e.data()["user"]["phoneNumber"],
                  photoURL: e.data()["user"]["photoURL"]),
            ))
        .toList();
  }

  Future<List<RequestEntity>> toRequestEntity(RequestType requestType,
      List<QueryDocumentSnapshot<Map<String, dynamic>>> data) async {
    return data
        .where((element) =>
            compareDateTime((element.data()["deadline"] as Timestamp).toDate()))
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

  void getSenderRequests() async {
    try {
      db.collection("sender_transaction").orderBy("deadline").get().then(
        (res) async {
          print("senderEntityList res.docs: " + res.docs.toString());

          senderEntityList = res.docs.length == 0
              ? senderEntityList
              : await toRequestEntity(RequestType.sender, res.docs);
          print("senderEntityList: " + senderEntityList.toString());
        },
        onError: (e) => print("Error completing: $e"),
      );
      Future.delayed(Duration(milliseconds: 20), () {
        update();
      });
    } catch (e) {
      Fluttertoast.showToast(msg: 'get_sender_requests_exception'.tr);
    }
  }

  void getCourierRequests() async {
    try {
      db.collection("courier_transaction").orderBy("deadline").get().then(
        (res) async {
          print("courierEntityList res.docs: " + res.docs.toString());

          courierEntityList = res.docs.length == 0
              ? courierEntityList
              : await toRequestEntity(RequestType.courier, res.docs);
          print("courierEntityList: " + courierEntityList.toString());
        },
        onError: (e) => print("Error completing: $e"),
      );
      Future.delayed(Duration(milliseconds: 20), () {
        update();
      });
    } catch (e) {
      print("get_courier_requests_exception: " + e.toString());
      Fluttertoast.showToast(msg: 'get_courier_requests_exception'.tr);
    }
  }

  bool compareDateTime(DateTime deadline) {
    var now = DateTime.now();
    return now.year <= deadline.year &&
        now.month <= deadline.month &&
        now.day <= deadline.day;
  }
}
