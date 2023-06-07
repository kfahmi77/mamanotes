import 'package:flutter/material.dart';

import 'package:get/get.dart';

class StimulasiPerkembanganView extends GetView {
  const StimulasiPerkembanganView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'StimulasiPerkembanganView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
