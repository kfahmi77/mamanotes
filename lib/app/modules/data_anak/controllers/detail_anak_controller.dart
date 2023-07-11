import 'package:get/get.dart';

import '../../home/models/anak_model.dart';

class DetailAnakController extends GetxController {
 final selectedAnak = Rx<AnakModel?>(null);
 final previewJurnalLoading = false.obs;
  final buatJurnalLoading = false.obs;

  void setSelectedAnak(AnakModel anak) {
  selectedAnak.value = anak;
}

AnakModel? getSelectedAnak() {
  return selectedAnak.value;
}

  void previewJurnal() {
    // Implementasi logika untuk tombol "Preview Jurnal"
    print('Mengambil data jurnal anak...');
  }

  void buatJurnal() {
    // Implementasi logika untuk tombol "Buat Jurnal"
    print('Menyimpan data jurnal anak...');
  }

  void navigateTo(String route) {
    // Implementasi logika navigasi ke halaman tertentu
    print('Navigasi ke halaman $route...');
  }


}
