import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mamanotes/app/data/common/style.dart';
import 'package:mamanotes/app/modules/kenangan/bindings/kenangan_binding.dart';
import 'package:mamanotes/app/modules/kenangan/views/kolase/kolase2_view.dart';
import 'package:mamanotes/app/modules/kenangan/views/kolase1_view.dart';

class KolaseFotoView extends StatefulWidget {
  const KolaseFotoView({Key? key}) : super(key: key);

  @override
  createState() => _KolaseFotoViewState();
}

class _KolaseFotoViewState extends State<KolaseFotoView> {
  int selectedCollageType = 1;

  void navigateToNextScreen() {
    // Lakukan navigasi ke halaman berikutnya berdasarkan selectedCollageType
    switch (selectedCollageType) {
      case 1:
        Get.off(() => const Kolase1View(), binding: KenanganBinding());
        break;
      case 2:
        Get.to(() => Kolase2View(), binding: KenanganBinding());
        break;
      default:
        // Handle default case
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: grey,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Text(
                  'kembali',
                  style: TextStyle(
                    fontWeight: normal,
                    fontSize: 14.sp,
                    color: black,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  navigateToNextScreen();
                },
                child: Text(
                  'lanjut',
                  style: TextStyle(
                    fontWeight: normal,
                    fontSize: 14.sp,
                    color: black,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: grey,
          ),
          child: PreviewKolase(
            selectedCollageType: selectedCollageType,
            onCollageTypeSelected: (int collageType) {
              setState(() {
                selectedCollageType = collageType;
              });
            },
          ),
        ),
      ),
    );
  }
}

class PreviewKolase extends StatelessWidget {
  final int selectedCollageType;
  final ValueChanged<int> onCollageTypeSelected;

  const PreviewKolase({
    Key? key,
    required this.selectedCollageType,
    required this.onCollageTypeSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget collageWidget;

    switch (selectedCollageType) {
      case 1:
        collageWidget = kolase1Widget();
        break;
      case 2:
        collageWidget = kolase2Widget();
        break;
      case 3:
        collageWidget = kolase3Widget();
        break;
      case 4:
        collageWidget = kolase4Widget();
        break;
      case 5:
        collageWidget = kolase5Widget();
        break;
      default:
        collageWidget = Container();
        break;
    }

    return Stack(
      children: [
        Align(
          alignment: const AlignmentDirectional(0, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: const AlignmentDirectional(0, 0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  child: collageWidget,
                ),
              ),
              BottomKolaseList(onCollageTypeSelected: onCollageTypeSelected)
            ],
          ),
        ),
      ],
    );
  }
}

class BottomKolaseList extends StatefulWidget {
  const BottomKolaseList({
    Key? key,
    required this.onCollageTypeSelected,
  }) : super(key: key);

  final ValueChanged<int> onCollageTypeSelected;

  @override
  createState() => _BottomKolaseListState();
}

class _BottomKolaseListState extends State<BottomKolaseList> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160.h,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) {
            bool isSelected = index == selectedIndex;

            switch (index + 1) {
              case 1:
                return BottomKolase1(
                  onCollageTypeSelected: widget.onCollageTypeSelected,
                  isSelected: isSelected,
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                    widget.onCollageTypeSelected(index + 1);
                  },
                );
              case 2:
                return BottomKolase2(
                  onCollageTypeSelected: widget.onCollageTypeSelected,
                  isSelected: isSelected,
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                    widget.onCollageTypeSelected(index + 1);
                  },
                );
              case 3:
                return BottomKolase3(
                  onCollageTypeSelected: widget.onCollageTypeSelected,
                  isSelected: isSelected,
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                    widget.onCollageTypeSelected(index + 1);
                  },
                );
              case 4:
                return BottomKolase4(
                  onCollageTypeSelected: widget.onCollageTypeSelected,
                  isSelected: isSelected,
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                    widget.onCollageTypeSelected(index + 1);
                  },
                );
              case 5:
                return BottomKolase5(
                  onCollageTypeSelected: widget.onCollageTypeSelected,
                  isSelected: isSelected,
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                    widget.onCollageTypeSelected(index + 1);
                  },
                );
              default:
                return Container();
            }
          },
        ),
      ),
    );
  }
}

class BottomKolase1 extends StatelessWidget {
  const BottomKolase1({
    Key? key,
    required this.onCollageTypeSelected,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  final ValueChanged<int> onCollageTypeSelected;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.r),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: isSelected ? white : Colors.grey,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: SizedBox(
              width: 80.w,
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected ? white : Colors.grey,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: isSelected ? white : Colors.grey,
                    width: 2,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: grey,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            SizedBox(width: 2.w),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: grey,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: grey,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: grey,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            SizedBox(width: 2.w),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: grey,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BottomKolase2 extends StatelessWidget {
  const BottomKolase2({
    Key? key,
    required this.onCollageTypeSelected,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  final ValueChanged<int> onCollageTypeSelected;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.r),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: isSelected ? white : Colors.grey,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: SizedBox(
              width: 80.w,
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected ? white : Colors.grey,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: isSelected ? white : Colors.grey,
                    width: 2,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: grey,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            SizedBox(width: 2.w),
                            Container(
                              decoration: BoxDecoration(
                                color: grey,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: grey,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: grey,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            SizedBox(width: 2.w),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: grey,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BottomKolase3 extends StatelessWidget {
  const BottomKolase3({
    Key? key,
    required this.onCollageTypeSelected,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  final ValueChanged<int> onCollageTypeSelected;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.r),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: isSelected ? white : Colors.grey,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: SizedBox(
              width: 80.w,
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected ? white : Colors.grey,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: isSelected ? white : Colors.grey,
                    width: 2,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: grey,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            SizedBox(width: 2.w),
                            Container(
                              decoration: BoxDecoration(
                                color: grey,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: grey,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            SizedBox(width: 2.w),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: grey,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: grey,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            SizedBox(width: 2.w),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: grey,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BottomKolase4 extends StatelessWidget {
  const BottomKolase4({
    Key? key,
    required this.onCollageTypeSelected,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  final ValueChanged<int> onCollageTypeSelected;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.r),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: isSelected ? white : Colors.grey,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: SizedBox(
              width: 80.w,
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected ? white : Colors.grey,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: isSelected ? white : Colors.grey,
                    width: 2,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: grey,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            SizedBox(width: 2.w),
                            Container(
                              decoration: BoxDecoration(
                                color: grey,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: grey,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            SizedBox(width: 2.w),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: grey,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BottomKolase5 extends StatelessWidget {
  const BottomKolase5({
    Key? key,
    required this.onCollageTypeSelected,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  final ValueChanged<int> onCollageTypeSelected;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.r),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: isSelected ? white : Colors.grey,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: SizedBox(
              width: 80.w,
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected ? white : Colors.grey,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: isSelected ? white : Colors.grey,
                    width: 2,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: grey,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            SizedBox(width: 2.w),
                            Container(
                              decoration: BoxDecoration(
                                color: grey,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 2.h),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: grey,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            SizedBox(width: 2.w),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: grey,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FrameKolase extends StatelessWidget {
  const FrameKolase({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 250.w,
        height: 400.h,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 7,
              blurRadius: 25,
              offset: const Offset(1, 3), // changes position of shadow
            ),
          ],
          color: white,
          border: Border.all(
            color: white,
            width: 10,
          ),
        ),
        child: child);
  }
}

Widget kolase1Widget() {
  return FrameKolase(
    child: Column(
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: grey,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Container(
                  color: grey,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        Expanded(
          child: Container(
            color: grey,
          ),
        ),
        SizedBox(height: 10.h),
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: grey,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Container(
                  color: grey,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget kolase2Widget() {
  return FrameKolase(
    child: Column(
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: grey,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        Expanded(
          child: Container(
            color: grey,
          ),
        ),
        SizedBox(height: 10.h),
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: grey,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget kolase3Widget() {
  return FrameKolase(
    child: Column(
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: grey,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: grey,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Container(
                  color: grey,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: grey,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget kolase4Widget() {
  return FrameKolase(
    child: Column(
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: grey,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: grey,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget kolase5Widget() {
  return FrameKolase(
    child: Row(
      children: <Widget>[
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: grey,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Container(
                decoration: BoxDecoration(
                  color: grey,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 10.h),
        Expanded(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: grey,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
