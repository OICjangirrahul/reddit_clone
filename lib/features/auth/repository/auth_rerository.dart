import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reddit/core/constants/constants.dart';
import 'package:reddit/core/constants/firebase_constants.dart';
import 'package:reddit/core/providers/firebase_provider.dart';
import 'package:reddit/models/user_model.dart';

final AuthRepositoryProvider = Provider((ref) => AuthRepository(
    firestore: ref.read(firebaseProvider),
    auth: ref.read(authProvider),
    googleSignIn: ref.read(googleProvider)));

class AuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthRepository(
      {required FirebaseFirestore firestore,
      required FirebaseAuth auth,
      required GoogleSignIn googleSignIn})
      : _auth = auth,
        _firestore = firestore,
        _googleSignIn = googleSignIn;

  CollectionReference get _user =>
      _firestore.collection(FirebaseConstants.usersCollection);

  void signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      final googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      //save data to firebase
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      // _firestore
      //     .collection('user')
      //     .doc(userCredential.user!.uid)
      //     .set(credential);
      UserModel userModel = UserModel(
          name: userCredential.user!.displayName ?? ' no name',
          profilePic: userCredential.user!.photoURL ?? Constants.avatarDefault,
          banner: Constants.bannerDefault,
          uid: userCredential.user!.uid,
          isAuthenticated: true,
          karma: 0,
          award: []);
      await _user.doc(userCredential.user!.uid).set(userModel.toMap());
    } catch (e) {
      print(e);
    }
  }
}
