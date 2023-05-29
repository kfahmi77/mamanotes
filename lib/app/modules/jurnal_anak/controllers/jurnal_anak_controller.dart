import 'package:get/get.dart';
import 'package:mamanotes/app/modules/jurnal_anak/views/jurnal_anak_view.dart';

import '../../home/models/anak_model.dart';

class JurnalAnakController extends GetxController {
  var argument = ''.obs;
  Rx<AnakModel?> selectedAnak = Rx<AnakModel?>(null);
  void selectAnak(AnakModel anak) {
    selectedAnak.value = anak;
  }

  void changeSelectedAnak(AnakModel anak) {
    selectedAnak.value = anak;
  }

  void navigateTo(String argument) {
    Get.find<JurnalAnakController>().argument.value = argument;
    Get.to(const JurnalAnakView(), arguments: argument);
  }
}
