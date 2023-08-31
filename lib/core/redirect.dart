import 'package:dromkart_task/features/todo_app/presentation/screens/homepage.dart';
import 'package:dromkart_task/features/todo_app/presentation/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Redirect extends StatelessWidget {
  static const routeName = 'redirect';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snap) {
              if (snap.hasData && snap.data != null) {
                return HomePage();
              } else {
                //is user not found
                return Login();
              }
            }));
  }
}
