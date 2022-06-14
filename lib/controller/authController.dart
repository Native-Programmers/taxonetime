// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxonetime/models/userData.dart';
import 'package:taxonetime/models/user.dart';
// import 'package:taxonetime/screens/auth/login.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:taxonetime/screens/onBoarding/onBoard.dart';
// import 'package:taxonetime/widgets/navbar.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:taxonetime/widgets/notification.dart';

GoogleSignInAccount? googleAccount;

class AuthController extends GetxController {
  SharedPreferences? prefs;
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static AuthController authInstance = Get.find();
  RxBool themeState = false.obs;
  Rx<bool> showHome = false.obs;
  late Rx<User?> firebaseUser;
  Rx<UsersData> userData = UsersData(
          dob: '',
          documents: [],
          email: '',
          name: '',
          uid: '',
          cnic: '',
          address: '',
          contact: '')
      .obs;
  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/user.emails.read',
      'https://www.googleapis.com/auth/userinfo.profile',
    ],
  );

  @override
  Future<void> onReady() async {
    super.onReady();
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    prefs = await SharedPreferences.getInstance();

    showHome = (prefs!.getBool('showHome') ?? false).obs;
    themeState = (prefs!.getBool('theme') ?? false).obs;
  }

  Users? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    return Users(user.uid, user.email);
  }

  Stream<Users?>? get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  Future<UserCredential> signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    return _auth.signInWithCredential(facebookAuthCredential);
  }

  Future<void> handleSignIn() async {
    _auth.signOut();

    if (!kIsWeb) {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      try {
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        final user = (await _auth.signInWithCredential(credential)).user;
      } catch (error) {
        // ignore: avoid_print
        print('Error: $error');
      }
    } else {
      signInWithGoogle();
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Create a new provider
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    googleProvider
        .addScope('https://www.googleapis.com/auth/contacts.readonly');
    googleProvider.setCustomParameters({'login_hint': 'user@gmail.com'});

    // Once signed in, return the UserCredential
    return _auth.signInWithPopup(googleProvider);
  }

  Future<void> login({required String email, required String password}) async {
    try {
      _auth
          .signInWithEmailAndPassword(
        email: email.toString().trim(),
        password: password,
      )
          .then((value) {
        if (_auth.currentUser!.emailVerified) {
          Get.snackbar('Welcome', email);
        } else {
          _auth.currentUser!.sendEmailVerification();
          Get.snackbar('Verification',
              'An email has been sent to you for verification.');
        }

        Get.snackbar('Welcome', email);

        Future.delayed(const Duration(seconds: 3), () {
          (kIsWeb ? null : Get.back());
        });
      }).onError((error, stackTrace) {
        Get.snackbar('Error', 'Unable to login. Please check your connection.');
        (kIsWeb ? null : Get.back());
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar('Error', 'No user found against this email');
      } else if (e.code == 'wrong-password') {
        Get.snackbar('Error', 'Wrong password');
      }
    }
    return;
  }

  void fbLogin() {
    FacebookAuth.i.login(permissions: [
      "public_profile",
      "email",
      "phone_number"
    ]).then((value) => FacebookAuth.i.getUserData());
  }

  void signOut() async {
    try {
      _auth.signOut().then((value) {
        showSnackBar(
            error: 'Success',
            message: 'User logged out successfully!',
            type: 's');
      });
    } catch (e) {
      showSnackBar(error: 'Error', message: 'Unable to logout!', type: 'e');
    }
  }
}
