import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mamanotes/app/data/common/style.dart';

import 'app/data/repository/auth.dart';
import 'app/routes/app_pages.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', 'id_ID');
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await ScreenUtil.ensureScreenSize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Get.put(AuthController(), permanent: true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return StreamBuilder<User?>(
          stream: auth.authStateChanges(),
          builder: (context, snapAuth) {
            if (snapAuth.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return GetMaterialApp(
              theme: ThemeData(primaryColor: background),
              debugShowCheckedModeBanner: false,
              title: "Mamanote",
              initialRoute: determineInitialRoute(),
              getPages: AppPages.routes,
            );
          },
        );
      },
    );
  }
}

String determineInitialRoute() {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null && user.emailVerified) {
    return Routes.dashboard;
  } else {
    return Routes.signin;
  }
}
