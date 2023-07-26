import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mamanotes/app/modules/home/models/anak_model.dart';

class HomeController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final Query<Map<String, dynamic>> _menuCollection =
      FirebaseFirestore.instance.collection('anak');
  RxBool isLoading = true.obs;
  Stream<List<AnakModel>>? menuStream;

  @override
  void onInit() {
    super.onInit();
    // menuStream = _menuCollection.snapshots().map((snapshot) {
    //   return snapshot.docs.map((doc) {
    //     return AnakModel.fromJson(doc.data() as Map<String, dynamic>);
    //   }).toList();
    // });

    // ever(menuItems, (_) {
    //   isLoading.value = false;
    // });
    getMenuItems();
  }

  Stream<List<AnakModel>> getMenuItems() {
    return _menuCollection
        .where('uid', isEqualTo: auth.currentUser!.uid)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return AnakModel.fromJson(doc.data());
      }).toList();
    });
  }

  // void fetchMenuItems() async {
  //   isLoading.value = true;

  //   try {
  //     final snapshot = await _menuCollection.get();
  //     menuItems.value = snapshot.docs.map((doc) {
  //       return AnakModel.fromJson(doc.data() as Map<String, dynamic>);
  //     }).toList();
  //     isLoading.value = false;
  //   } catch (error) {
  //     print('Failed to fetch menu items: $error');
  //     isLoading.value = false;
  //   }
  // }
}
