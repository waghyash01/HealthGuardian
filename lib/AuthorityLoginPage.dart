

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'aesAlgorithm.dart';
import 'authorityDashboard.dart';

class AuthorityLoginPage extends StatelessWidget {
  final TextEditingController loginNameController = TextEditingController();
  final TextEditingController loginPasskeyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: const Color(0xff2F2E40),
        title: Text(
          "Authority Login",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            //textStyle: TextStyle(color: Colors.white),
            fontSize: 25,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: loginNameController,
              decoration: InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              obscureText: true,
              controller: loginPasskeyController,
              decoration: InputDecoration(
                labelText: "Passkey",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff2F2E40),
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                await login(context, loginNameController.text, loginPasskeyController.text);
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> login(BuildContext context, String name, String passkey) async {
    try {
      final encryptedName = AESAlgorithm.encryptData(name);
      final encryptedPasskey = AESAlgorithm.encryptData(passkey);

      var result = await FirebaseFirestore.instance
          .collection('authority')
          .doc(name)
          .get();

      if (result.exists) {
        final data = result.data();
        if (data != null &&
            data.containsKey('passkey') &&
            data['passkey'] == encryptedPasskey) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Authpage()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                'Invalid login credentials. Authority not found or incorrect passkey.'),
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Authority not found.'),
        ));
      }
    } catch (e) {
      print('Error during login: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('An error occurred during login.'),
      ));
    }
  }
}

