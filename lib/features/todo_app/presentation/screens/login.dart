import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../auth/g_auth.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'TASK',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 60),
            ),
            const SizedBox(
              height: 30,
            ),
            const Row(
              children: [
                Expanded(
                  child: Divider(
                    indent: 40,
                  ),
                ),
                Text(' Sign In '),
                Expanded(
                    child: Divider(
                  endIndent: 40,
                ))
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  try {
                    await GoogleAuthServerr().signInWithGoo();
                  } on FirebaseException catch (err) {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(err.message ?? 'Failed, Try Again')));
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(30)),
                    padding: EdgeInsets.symmetric(
                        vertical: 17,
                        horizontal: MediaQuery.sizeOf(context).width * 0.2)),
                child: _isLoading
                    ? LinearProgressIndicator(
                        color: Colors.orange,
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                            Container(
                              height: 20,
                              child: Image.asset(
                                  'assets/google-search-icon-google-product-illustration-free-png.webp',
                                  fit: BoxFit.contain),
                            ),
                            Text("Continue with Google")
                          ]),
              ),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
