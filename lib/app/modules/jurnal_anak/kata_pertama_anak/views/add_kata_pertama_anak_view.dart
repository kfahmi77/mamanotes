import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../data/common/style.dart';
import '../controllers/add_kata_pertama_anak_controller.dart';

class AddKataPertamaAnakView extends GetView<AddKataPertamaAnakController> {
  final String documentId;
  final String kataPertamaAnakId;
  const AddKataPertamaAnakView(
      {Key? key, required this.documentId, required this.kataPertamaAnakId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: red,
        elevation: 0,
        title: const Text('Tambah Kata Pertama Anak'),
        actions: [
          IconButton(
            onPressed: controller.isUploading.value
                ? null
                : () => controller.uploadAudio(documentId, kataPertamaAnakId),
            icon: Obx(
              () => controller.isUploading.value
                  ? const CircularProgressIndicator()
                  : const Icon(FontAwesomeIcons.floppyDisk),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(12),
              child: TextFormField(
                maxLength: 20,
                decoration: InputDecoration(
                  labelText: 'Kata Pertama',
                  labelStyle: TextStyle(color: red),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                onChanged: (value) {
                  controller.kataPertama.text = value;
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              child: Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(red),
                  ),
                  onPressed: controller.selectAudio,
                  child: const Text('Pilih File Audio'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
