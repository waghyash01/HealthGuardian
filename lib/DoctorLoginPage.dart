import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'Guidelines.dart';
import 'aesAlgorithm.dart';

class DoctorLoginPage extends StatelessWidget {
  final TextEditingController loginNameController = TextEditingController();
  final TextEditingController loginUidController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: const Color(0xff2F2E40),
        title: Text(
          "Doctor's Login",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            //textStyle: TextStyle(color: Colors.white),
            fontSize: 25,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: loginNameController,
              decoration: InputDecoration(
                labelText: "Doctor's Name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              obscureText: true,
              controller: loginUidController,
              decoration: InputDecoration(
                labelText: "Password",
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
                await login(context, 'Doctors', loginNameController.text, loginUidController.text);
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> login(BuildContext context, String collection, String name, String uid) async {
    try {
      final encryptedName = AESAlgorithm.encryptData(name);
      final encryptedUid = AESAlgorithm.encryptData(uid);

      var result = await FirebaseFirestore.instance
          .collection(collection)
          .where('Name', isEqualTo: encryptedName)
          .where('UID', isEqualTo: encryptedUid)
          .get();

      if (result.docs.isNotEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => GuidelinesPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Invalid name or password. Please try again.'),
        ));
      }
    } catch (e) {
      print('Error during login: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('An error occurred during login. Please try again later.'),
      ));
    }
  }
}

