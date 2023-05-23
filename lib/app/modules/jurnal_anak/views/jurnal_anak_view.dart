import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mamanotes/app/modules/jurnal_anak/views/kelahiranku_view.dart';
import 'package:mamanotes/app/modules/jurnal_anak/views/stimulasi_perkembangan_view.dart';

import '../controllers/jurnal_anak_controller.dart';

class JurnalAnakView extends GetView<JurnalAnakController> {
  const JurnalAnakView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('JurnalAnakView'),
          centerTitle: true,
        ),
        body: Obx(() {
          final argument = controller.argument.value;
          print(argument);
          switch (argument) {
            case 'kelahiranku':
              return KelahirankuView();
            case 'stimulus':
              return StimulasiPerkembanganView();
            default:
              return Container();
          }
        }));
  }
}
