import 'package:flutter/material.dart';

import 'package:get/get.dart';

class KelahirankuView extends GetView {
  const KelahirankuView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'KelahirankuView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
