import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tentang_controller.dart';

class TentangView extends GetView<TentangController> {
  const TentangView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TentangView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TentangView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
