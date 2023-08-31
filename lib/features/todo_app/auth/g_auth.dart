import 'package:dromkart_task/features/todo_app/data/repository/firebase.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthServerr {
  //google sign in
  signInWithGoo() async {
    //begin proccess
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    //obtain auth details
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    //create new cred
    final cred = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    return await FirebaseAuth.instance
        .signInWithCredential(cred)
        .then((value) async {
      await FirebaseRepo.fetchTasks();
    });
  }
}
