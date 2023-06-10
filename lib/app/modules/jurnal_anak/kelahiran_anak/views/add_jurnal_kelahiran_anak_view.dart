import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/add_jurnal_kelahiran_anak.dart';

class AddStimulusAnakView extends StatelessWidget {
  final String anakId;
  final String kelahiranAnakId;

  AddStimulusAnakView(
      {Key? key, required this.anakId, required this.kelahiranAnakId})
      : super(key: key);

  final AddStimulusAnakController controller =
      Get.put(AddStimulusAnakController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Kelahiran $anakId'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    controller.selectTime(context);
                  },
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Waktu Lahir'),
                    enabled: false,
                    controller: controller.timeController,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Waktu lahir harus diisi.';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Tempat Lahir'),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Tempat lahir harus diisi.';
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    controller.birthPlace = value!;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Dokter/Bidan'),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Dokter/Bidan yang melayani harus diisi.';
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    controller.medicalPersonnel = value!;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Berat Badan (kg)'),
                  keyboardType: TextInputType.number,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Berat badan harus diisi.';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Berat badan harus berupa angka.';
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    controller.weight = double.parse(value!);
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Tinggi Badan (cm)'),
                  keyboardType: TextInputType.number,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Tinggi badan harus diisi.';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Tinggi badan harus berupa angka.';
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    controller.height = double.parse(value!);
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Doa dari Bunda'),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Doa dari Bunda harus diisi.';
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    controller.motherPrayer = value!;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Doa dari Ayah'),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Doa dari Ayah harus diisi.';
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    controller.fatherPrayer = value!;
                  },
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: controller.pickBirthPhoto,
                      child: const Text('Pilih Foto Anak Lahir'),
                    ),
                    const SizedBox(height: 8),
                    Obx(() {
                      return controller.birthPhotoPath.value != null
                          ? Image.file(controller.birthPhotoPath.value!)
                          : const SizedBox.shrink();
                    }),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: controller.pickFootPrintPhoto,
                      child: const Text('Pilih Foto Cap Kaki Anak'),
                    ),
                    const SizedBox(height: 8),
                    Obx(() {
                      return controller.footPrintPhotoPath.value != null
                          ? Image.file(controller.footPrintPhotoPath.value!)
                          : const SizedBox.shrink();
                    }),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: controller.pickDeliveryPhoto,
                      child: const Text('Pilih Foto Persalinan'),
                    ),
                    const SizedBox(height: 8),
                    Obx(() {
                      return controller.deliveryPhotoPath.value != null
                          ? Image.file(controller.deliveryPhotoPath.value!)
                          : const SizedBox.shrink();
                    }),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () =>
                          controller.submitForm(anakId, kelahiranAnakId),
                      child: const Text('Simpan Data'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
