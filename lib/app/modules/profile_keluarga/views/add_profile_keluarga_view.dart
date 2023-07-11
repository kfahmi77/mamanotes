import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/common/style.dart';
import '../../../data/common/widget/logo_widget.dart';
import '../controllers/add_profile_keluarga_controller.dart';

class AddProfileKeluargaView extends GetView<AddProfileKeluargaController> {
  const AddProfileKeluargaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: background,
        title: const LogoWidget(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: controller.namaKeluargaController,
                  decoration: const InputDecoration(labelText: 'Nama Keluarga'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Nama Keluarga tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: controller.mottoKeluargaController,
                  decoration:
                      const InputDecoration(labelText: 'Motto Keluarga'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Motto Keluarga tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: controller.visiMisiController,
                  decoration: const InputDecoration(labelText: 'Visi dan Misi'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Visi dan Misi tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: controller.alamatRumahController,
                  decoration: const InputDecoration(labelText: 'Alamat Rumah'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Alamat Rumah tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: controller.namaAyahController,
                  decoration: const InputDecoration(labelText: 'Nama Ayah'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Nama Ayah tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: controller.pickFotoAyah,
                  child: const Text('Pilih Foto Ayah'),
                ),
                Obx(() {
                  if (controller.fotoAyah.value != null) {
                    return Image.file(controller.fotoAyah.value!);
                  } else {
                    return const SizedBox.shrink();
                  }
                }),
                TextFormField(
                  controller: controller.namaIbuController,
                  decoration: const InputDecoration(labelText: 'Nama Ibu'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Nama Ibu tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: controller.pickFotoIbu,
                  child: const Text('Pilih Foto Ibu'),
                ),
                Obx(() {
                  if (controller.fotoIbu.value != null) {
                    return Image.file(controller.fotoIbu.value!);
                  } else {
                    return const SizedBox.shrink();
                  }
                }),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: controller.submitForm,
                  child: const Text('Simpan'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
