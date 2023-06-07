import 'package:get/get.dart';

import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/data_anak/bindings/data_anak_binding.dart';
import '../modules/data_anak/views/data_anak_view.dart';
import '../modules/forget_password/bindings/forget_password_binding.dart';
import '../modules/forget_password/views/forget_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/jurnal_anak/bindings/jurnal_anak_binding.dart';
import '../modules/jurnal_anak/views/jurnal_anak_view.dart';
import '../modules/kenangan/bindings/kenangan_binding.dart';
import '../modules/kenangan/views/kenangan_add_view.dart';
import '../modules/kenangan/views/kenangan_view.dart';
import '../modules/my_diary/bindings/my_diary_binding.dart';
import '../modules/my_diary/views/add_diary_view.dart';
import '../modules/my_diary/views/edit_diary_view.dart';
import '../modules/my_diary/views/my_diary_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/edit_profile_view.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/profile_keluarga/bindings/profile_keluarga_binding.dart';
import '../modules/profile_keluarga/views/add_profile_keluarga_view.dart';
import '../modules/profile_keluarga/views/profile_keluarga_view.dart';
import '../modules/signin/bindings/signin_binding.dart';
import '../modules/signin/views/signin_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/kelahiran_anak/bindings/stimulus_anak_binding.dart';
import '../modules/kelahiran_anak/views/stimulus_anak_view.dart';
import '../modules/tentang/bindings/tentang_binding.dart';
import '../modules/tentang/views/tentang_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.home;

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.signin,
      page: () => const SigninView(),
      binding: SigninBinding(),
    ),
    GetPage(
      name: _Paths.signup,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.profile,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.editProfile,
      page: () => const EditProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.dashboard,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.kenangan,
      page: () => KenanganView(),
      binding: KenanganBinding(),
    ),
    GetPage(
      name: _Paths.addKenangan,
      page: () => const KenanganAddView(),
      binding: KenanganBinding(),
    ),
    GetPage(
      name: _Paths.tentang,
      page: () => const TentangView(),
      binding: TentangBinding(),
    ),
    GetPage(
      name: _Paths.profilKeluarga,
      page: () => ProfileKeluargaView(),
      binding: ProfileKeluargaBinding(),
    ),
    GetPage(
      name: _Paths.addProfilKeluarga,
      page: () => AddProfileKeluargaView(),
      binding: ProfileKeluargaBinding(),
    ),
    GetPage(
      name: _Paths.myDiary,
      page: () => const MyDiaryView(),
      binding: MyDiaryBinding(),
    ),
    GetPage(
      name: _Paths.addDiary,
      page: () => const AddDiaryView(),
      binding: MyDiaryBinding(),
    ),
    GetPage(
      name: _Paths.editDiary,
      page: () => const EditDiaryView(),
      binding: MyDiaryBinding(),
    ),
    GetPage(
      name: _Paths.resetPassword,
      page: () => const ForgetPasswordView(),
      binding: ForgetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.tambahAnak,
      page: () => const TambahDataAnakView(),
      binding: DataAnakBinding(),
    ),
    GetPage(
      name: _Paths.jurnalAnak,
      page: () => const JurnalAnakView(),
      binding: JurnalAnakBinding(),
    ),
  ];
}
