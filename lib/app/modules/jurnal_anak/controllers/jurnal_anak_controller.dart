import 'package:get/get.dart';
import 'package:mamanotes/app/modules/jurnal_anak/views/jurnal_anak_view.dart';

class JurnalAnakController extends GetxController {
  var argument = ''.obs;

  void navigateTo(String argument) {
    Get.find<JurnalAnakController>().argument.value = argument;
    Get.to(const JurnalAnakView(), arguments: argument);
  }
}
