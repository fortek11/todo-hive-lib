import 'package:dromkart_task/core/redirect.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  static const routeName = 'userprofile';

  @override
  Widget build(BuildContext context) {
    final cred = FirebaseAuth.instance.currentUser;
    return Scaffold(
        appBar: AppBar(
          title: Text('User Profile'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(cred!.email.toString()),
              ElevatedButton.icon(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context)
                        .pushReplacementNamed(Redirect.routeName);
                  },
                  icon: Icon(Icons.logout),
                  label: Text('Logout'))
            ],
          ),
        ));
  }
}
