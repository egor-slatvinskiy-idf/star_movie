import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/model/firebase_user_email.dart';
import 'package:domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

const _usersCollection = 'star_movie_users';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  const AuthRepositoryImpl(
    this.firebaseAuth,
    this.firebaseFirestore,
  );

  @override
  Future<bool> checkUserExists(UserEmailPass user) async {
    final usersCollection = firebaseFirestore.collection(_usersCollection);
    final userCheck = await usersCollection
        .where('login', isEqualTo: user.login)
        .where('password', isEqualTo: user.password)
        .get();
    return userCheck.docs.isNotEmpty;
  }

  @override
  Future<UserEmailPass?> loginWithFacebook() async {
    final LoginResult loginResult =
        await FacebookAuth.instance.login(permissions: [
      'email',
      'public_profile',
      'user_birthday',
    ]);
    final user = await FacebookAuth.instance.getUserData();

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken?.token ?? '');

    firebaseAuth.signInWithCredential(facebookAuthCredential);
    return UserEmailPass(
      user['email'] ?? '',
      user['id'] ?? '',
    );
  }

  @override
  Future<UserEmailPass?> loginWithGoogle() async {
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: <String>["email"]).signIn();

    if (googleUser == null) return null;
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    firebaseAuth.signInWithCredential(credential);
    return UserEmailPass(
      googleUser.email,
      googleUser.id,
    );
  }
}
