import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildLogoWidget extends StatelessWidget {
  const BuildLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/logo_mamanote.png',
        fit: BoxFit.contain, width: 150.w);
  }
}
