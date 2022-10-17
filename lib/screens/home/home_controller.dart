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
    getPromoList();
    getCourierRequests();
    getSenderRequests();
  }

  Future<void> getPromoList() async {
    try {
      db.collection("promo").orderBy("until").get().then(
        (res) async {
          promoEntityList = res.docs.length == 0
              ? promoEntityList
              : await toPromoEntity(res.docs);
          print("promoEntityList: " + promoEntityList.toString());
        },
        onError: (e) => print("Error completing: $e"),
      );
      update();
    } catch (e) {
      Fluttertoast.showToast(msg: 'get_promo_list_exception'.tr);
    }
  }

  Future<List<PromoEntity>> toPromoEntity(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> data) async {
    return data
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
          senderEntityList = res.docs.length == 0
              ? senderEntityList
              : await toRequestEntity(RequestType.sender, res.docs);
          print("senderEntityList: " + senderEntityList.toString());
        },
        onError: (e) => print("Error completing: $e"),
      );
      update();
    } catch (e) {
      Fluttertoast.showToast(msg: 'get_sender_requests_exception'.tr);
    }
  }

  void getCourierRequests() async {
    try {
      db.collection("courier_transaction").orderBy("deadline").get().then(
        (res) async {
          courierEntityList = res.docs.length == 0
              ? courierEntityList
              : await toRequestEntity(RequestType.courier, res.docs);
          print("courierEntityList: " + courierEntityList.toString());
        },
        onError: (e) => print("Error completing: $e"),
      );
      update();
    } catch (e) {
      print("get_courier_requests_exception: " + e.toString());
      Fluttertoast.showToast(msg: 'get_courier_requests_exception'.tr);
    }
  }
}
