import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/gigi_pertama_anak_controller.dart';

class ImageDisplayScreen extends StatelessWidget {
  final GigiPertamaAnakController controller = Get.put(GigiPertamaAnakController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Display'),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.imagesList.length,
          itemBuilder: (context, index) {
            final imageUrl = controller.imagesList[index].imageUrl;
            return Container(
              padding: EdgeInsets.all(8.0),
              child: Image.network(imageUrl),
            );
          },
        ),
      ),
    );
  }
}