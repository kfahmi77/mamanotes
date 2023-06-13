import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../../../data/common/style.dart';

class Kolase1View extends StatefulWidget {
  const Kolase1View({Key? key}) : super(key: key);

  @override
  createState() => _Kolase1ViewState();
}

class _Kolase1ViewState extends State<Kolase1View> {
  List<dynamic> photos = [
    // Daftar file foto yang dipilih atau warna coklat
    Colors.brown,
    Colors.brown,
    Colors.brown,
    Colors.brown,
    Colors.brown,
    Colors.brown,
  ];

  Future<void> _pickPhoto(int index) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        photos[index] = File(pickedFile.path);
      });
    }
  }

  void _onPhotoTap(int index) {
    _pickPhoto(index);
    print('Foto ke-$index diklik');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: const [],
      ),
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 1,
                decoration: BoxDecoration(
                  color: grey,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 25.h, 0, 0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height:
                                    MediaQuery.of(context).size.height * 0.71,
                                decoration: BoxDecoration(
                                  color: white,
                                ),
                                child: StaggeredGridView.countBuilder(
                                  padding: EdgeInsets.only(
                                    top: 10.h,
                                    bottom: 10.h,
                                    left: 10.w,
                                    right: 10.w,
                                  ),
                                  crossAxisCount: 2,
                                  itemCount: 5,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    Widget photoWidget;

                                    if (photos[index] is File) {
                                      // Jika foto adalah File (dari galeri)
                                      photoWidget = Image.file(
                                        photos[index],
                                        fit: BoxFit.cover,
                                      );
                                    } else {
                                      // Jika foto adalah warna coklat
                                      photoWidget = Container(
                                        color: photos[index],
                                      );
                                    }

                                    return GestureDetector(
                                      onTap: () {
                                        _onPhotoTap(index);
                                      },
                                      child: photoWidget,
                                    );
                                  },
                                  staggeredTileBuilder: (int index) {
                                    if (index == 0) {
                                      return const StaggeredTile.count(1, 1);
                                    } else if (index == 1) {
                                      return const StaggeredTile.count(1, 1);
                                    } else if (index == 2) {
                                      return const StaggeredTile.count(3, 1);
                                    } else {
                                      return const StaggeredTile.count(1, 1);
                                    }
                                  },
                                  mainAxisSpacing: 10.0,
                                  crossAxisSpacing: 10.0,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueGrey,
                              ),
                              onPressed: () {},
                              child: const Text("tanggal"),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: TextField(
                              maxLines: null,
                              decoration: InputDecoration(
                                hintText:
                                    'Klik disini ya moms! \n untuk menulis cerita dibalik foto ini >.<',
                                border: InputBorder
                                    .none, // Menghilangkan border bagian bawah
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 16.0),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
