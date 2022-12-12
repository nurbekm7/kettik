import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kettik/models/RequestEntity.dart';
import 'package:kettik/models/UserProfile.dart';
import 'package:get/get.dart';
import 'package:kettik/screens/filter/filter_result_screen.dart';

class FilterController extends GetxController {
  List<RequestEntity> filteredSenderEntityList = List.empty();
  List<RequestEntity> filteredCourierEntityList = List.empty();
  bool showLoadingOverlay = false;
  RequestType selectedRequestType = RequestType.sender;
  FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  void onInit() {
    super.onInit();
    showLoadingOverlay = false;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    print("onClose: FilterController");
    showLoadingOverlay = false;
    filteredSenderEntityList = List.empty();
    filteredCourierEntityList = List.empty();
  }

  void filterRequest(RequestEntity requestEntity) async {
    showLoadingOverlay = true;
    selectedRequestType = requestEntity.requestType;
    var collection = requestEntity.requestType == RequestType.sender
        ? "sender_transaction"
        : "courier_transaction";
    update();
    var filterQuery =
        requestEntity.from.city.isNotEmpty && requestEntity.to.city.isNotEmpty
            ? db
                .collection(collection)
                .where("deadline",
                    isLessThanOrEqualTo: requestEntity.deadline,
                    isGreaterThanOrEqualTo: DateTime.now())
                .where("from.city", isEqualTo: requestEntity.from.city)
                .where("to.city", isEqualTo: requestEntity.to.city)
            : requestEntity.from.city.isNotEmpty
                ? db
                    .collection(collection)
                    .where("deadline",
                        isLessThanOrEqualTo: requestEntity.deadline,
                        isGreaterThanOrEqualTo: DateTime.now())
                    .where("from.city", isEqualTo: requestEntity.from.city)
                : requestEntity.to.city.isNotEmpty
                    ? db
                        .collection(collection)
                        .where("deadline",
                            isLessThanOrEqualTo: requestEntity.deadline,
                            isGreaterThanOrEqualTo: DateTime.now())
                        .where("to.city", isEqualTo: requestEntity.to.city)
                    : db.collection(collection).where("deadline",
                        isLessThan: requestEntity.deadline,
                        isGreaterThanOrEqualTo: DateTime.now());

    filterQuery.get().then((res) async {
      print('filterRequest filtered: ${res.docs}');

      if (requestEntity.requestType == RequestType.sender) {
        filteredSenderEntityList = res.docs.length == 0
            ? filteredSenderEntityList
            : await toRequestEntity(
                RequestType.sender, res.docs, requestEntity);
      } else {
        filteredCourierEntityList = res.docs.length == 0
            ? filteredCourierEntityList
            : await toRequestEntity(
                RequestType.courier, res.docs, requestEntity);
      }

      showLoadingOverlay = false;
      Get.to(() => FilterResultScreen());
    }).catchError((e) {
      print(e);
      showLoadingOverlay = false;
      update();
      Fluttertoast.showToast(msg: 'internal_server_error'.tr);
    });
  }

  Future<List<RequestEntity>> toRequestEntity(
      RequestType requestType,
      List<QueryDocumentSnapshot<Map<String, dynamic>>> data,
      RequestEntity requestEntity) async {
    return data
        .where((element) => element.data()["price"] <= requestEntity.price!)
        .where((element) => element.data()["weight"] <= requestEntity.weight!)
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
}
