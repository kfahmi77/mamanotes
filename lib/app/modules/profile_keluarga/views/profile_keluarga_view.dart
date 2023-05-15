import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mamanotes/app/data/common/style.dart';
import 'package:mamanotes/app/data/common/widget/logo_widget.dart';

import '../controllers/profile_keluarga_controller.dart';

class ProfileKeluargaView extends GetView<ProfileKeluargaController> {
  const ProfileKeluargaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const LogoWidget(),
        backgroundColor: background,
        centerTitle: true,
        elevation: 0,
      ),
      body: const Center(
        child: Text(
          'ProfileKeluargaView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
