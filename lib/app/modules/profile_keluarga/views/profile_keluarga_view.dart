import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mamanotes/app/modules/profile_keluarga/bindings/profile_keluarga_binding.dart';
import 'package:mamanotes/app/modules/profile_keluarga/views/add_profile_keluarga_view.dart';
import 'package:mamanotes/app/modules/profile_keluarga/views/edit_profile_keluarga_view.dart';

import '../../../data/common/style.dart';
import '../../../data/common/widget/logo_widget.dart';
import '../../jurnal_anak/kelahiran_anak/views/stimulus_anak_view.dart';
import '../models/profile_keluarga_model.dart';
import 'detail_profile_keluarga_view.dart';

class ProfileKeluargaView extends StatelessWidget {
  const ProfileKeluargaView({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('keluarga')
          .where('uid', isEqualTo: user!.uid)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          // Data profil keluarga tersedia
          DocumentSnapshot document = snapshot.data!.docs.first;
          Keluarga keluarga = Keluarga.fromFirestore(document);

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: background,
              centerTitle: true,
              title: const LogoWidget(),
              actions: [
                IconButton(
                  onPressed: () {
                    Get.to(
                        () => EditProfileKeluargaView(
                              keluargaModel: keluarga,
                            ),
                        binding: ProfileKeluargaBinding());
                  },
                  icon: const Icon(FontAwesomeIcons.pencil),
                ),
              ],
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    CarouselSlider(
                      items: [
                        _buildImageStack(
                          keluarga.ayah.foto,
                          keluarga.ayah.nama,
                          onTap: () => Navigator.push(
                              context, _createRoute(keluarga.ayah.foto)),
                        ),
                        _buildImageStack(
                          keluarga.ibu.foto,
                          keluarga.ibu.nama,
                          onTap: () => Navigator.push(
                              context, _createRoute(keluarga.ibu.foto)),
                        )
                      ],
                      options: CarouselOptions(
                        height: 200.h,
                        viewportFraction:
                            0.5, // Mengatur fraksi dari lebar viewport
                        aspectRatio: 16 / 9, // Mengatur rasio aspek gambar
                        enlargeCenterPage:
                            true, // Perbesar gambar saat ditampilkan di tengah
                        enableInfiniteScroll: true,
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Nama Keluarga',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                keluarga.namaKeluarga,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Motto Keluarga',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                keluarga.mottoKeluarga,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Visi dan Misi',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                keluarga.visiMisi,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Alamat Rumah',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                keluarga.alamatRumah,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          // Data profil keluarga tidak tersedia
          return Scaffold(
            appBar: AppBar(
                backgroundColor: background,
                centerTitle: true,
                title: const LogoWidget()),
            body: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: red,
                ),
                onPressed: () {
                  Get.to(() => const AddProfileKeluargaView(),
                      binding: ProfileKeluargaBinding());
                },
                child: const Text('Tambah Profil Keluarga'),
              ),
            ),
          );
        }
      },
    );
  }
}

Widget _buildImageStack(String imageUrl, String labelText,
    {required Future? Function() onTap}) {
  return GestureDetector(
    onTap: () => onTap(),
    child: Stack(
      fit: StackFit.expand,
      children: [
        CachedNetworkImage(
          imageUrl: imageUrl,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            color: Colors.black54,
            child: Text(labelText,
                style: redTextStyle.copyWith(
                  fontSize: 16.sp,
                  fontWeight: bold,
                  color: white,
                )),
          ),
        ),
      ],
    ),
  );
}

Route _createRoute(String imageUrl) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => DetailFotoView(
      urlImage: imageUrl,
    ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
