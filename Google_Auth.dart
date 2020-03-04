import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert' show json;

import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  GoogleSignInAccount _currentUser;
  String _contactText;
  final cFirebaseAuth = FirebaseAuth.instance;

  Future<void> _handleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    final FirebaseUser user =
        (await cFirebaseAuth.signInWithCredential(credential)).user;

    print(user.displayName);
    return user;
  }

   Future<void> _handleSignOut() => _googleSignIn.disconnect();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: _currentUser != null
              ? ListTile(
                title: Text(_currentUser.displayName),
                trailing: IconButton(icon: Icon(Icons.delete), onPressed: _handleSignOut),
              )
              : RaisedButton(
                  onPressed: _handleSignIn,
                  child: Text('google signin'),
                )),
    );
  }
}
