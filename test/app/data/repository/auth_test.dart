import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';

void main() {
  group('Tes Autentikasi:', () {
    late MockFirebaseAuth auth;

    setUp(() {
      auth = MockFirebaseAuth();
    });

    test('User harus Login', () async {
      final googleSignIn = MockGoogleSignIn();
      final signinAccount = await googleSignIn.signIn();
      final googleAuth = await signinAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final user = MockUser(
        isAnonymous: false,
        uid: 'abcd12345',
        email: 'test@gmail.com',
        displayName: 'test',
      );
      auth.mockUser = user;
      final result = await auth.signInWithCredential(credential);
      final userLogin = result.user;

      expect(userLogin, isNotNull);
    });

    test('User Logout', () async {
      await auth.signOut();
      final user = auth.currentUser;

      expect(user, isNull);
    });

    test('Email user harus diverifikasi', () async {
      final googleSignIn = MockGoogleSignIn();
      final signinAccount = await googleSignIn.signIn();
      final googleAuth = await signinAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final user = MockUser(
        isAnonymous: false,
        uid: 'abcd12345',
        email: 'test@gmail.com',
        displayName: 'test',
        isEmailVerified: true,
      );
      final auth = MockFirebaseAuth(mockUser: user);
      final result = await auth.signInWithCredential(credential);
      final user2 = result.user;

      expect(user2, isNotNull);
      expect(user2?.email, equals(user.email));
      expect(user2?.emailVerified, isTrue);
    });

    test('User harus ada', () async {
      const email = 'test@example.com';
      const password = 'testPassword';
      final result = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = result.user;

      expect(user, isNotNull);
      expect(user?.email, equals(email));
    });
  });
}
