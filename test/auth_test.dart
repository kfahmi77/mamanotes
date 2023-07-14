import 'dart:io';

import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:get/get_instance/src/lifecycle.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_platform_interface/src/types/image_source.dart';
import 'package:mamanotes/app/data/repository/auth.dart';
import 'package:mamanotes/app/modules/signup/controllers/signup_controller.dart';

main() async {
   // Mock sign in with Google.
    final googleSignIn = MockGoogleSignIn();
    final signinAccount = await googleSignIn.signIn();
    final googleAuth = await signinAccount!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // Sign in.
    final user = MockUser(
      isAnonymous: false,
      uid: 'someuid',
      email: 'bob@somedomain.com',
      displayName: 'Bob',
    );
    final auth = MockFirebaseAuth(mockUser: user);
    final result = await auth.signInWithCredential(credential);
    final currentUser = await result.user;
    print(currentUser!.displayName);
    print(user.displayName);
}
class MockUpdateProfile   implements AuthController {
  @override
  late FirebaseAuth auth;

  @override
  late SignupController authC;

  @override
  late Rx<GoogleSignInAccount?> googleSignInAccount;

  @override
  late Rx<File?> image;

  @override
  late RxBool isLoading;

  @override
  String? uid;

  @override
  void $configureLifeCycle() {
    // TODO: implement $configureLifeCycle
  }

  @override
  Disposer addListener(GetStateUpdate listener) {
    // TODO: implement addListener
    throw UnimplementedError();
  }

  @override
  Disposer addListenerId(Object? key, GetStateUpdate listener) {
    // TODO: implement addListenerId
    throw UnimplementedError();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void disposeId(Object id) {
    // TODO: implement disposeId
  }

  @override
  Future<void> getImage(ImageSource source) {
    // TODO: implement getImage
    throw UnimplementedError();
  }

  @override
  // TODO: implement hasListeners
  bool get hasListeners => throw UnimplementedError();

  @override
  // TODO: implement initialized
  bool get initialized => throw UnimplementedError();

  @override
  // TODO: implement isClosed
  bool get isClosed => throw UnimplementedError();

  @override
  // TODO: implement listeners
  int get listeners => throw UnimplementedError();

  @override
  Future<Map<String, dynamic>> login(String email, String pass) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  void notifyChildrens() {
    // TODO: implement notifyChildrens
  }

  @override
  void onClose() {
    // TODO: implement onClose
  }

  @override
  // TODO: implement onDelete
  InternalFinalCallback<void> get onDelete => throw UnimplementedError();

  @override
  void onInit() {
    // TODO: implement onInit
  }

  @override
  void onReady() {
    // TODO: implement onReady
  }

  @override
  // TODO: implement onStart
  InternalFinalCallback<void> get onStart => throw UnimplementedError();

  @override
  // TODO: implement picker
  ImagePicker get picker => throw UnimplementedError();

  @override
  void refresh() {
    // TODO: implement refresh
  }

  @override
  void refreshGroup(Object id) {
    // TODO: implement refreshGroup
  }

  @override
  Future<Map<String, dynamic>> register(String email, String password, String name) {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  void removeListener(VoidCallback listener) {
    // TODO: implement removeListener
  }

  @override
  void removeListenerId(Object id, VoidCallback listener) {
    // TODO: implement removeListenerId
  }

  @override
  Future<void> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  void update([List<Object>? ids, bool condition = true]) {
    // TODO: implement update
  }

  @override
  Future<String> uploadDefaultImage(String uid) {
    // TODO: implement uploadDefaultImage
    throw UnimplementedError();
  }

  @override
  Future<String> uploadImage(File file, String uid) {
    // TODO: implement uploadImage
    throw UnimplementedError();
  }
 
}