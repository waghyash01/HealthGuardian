import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sampleandro/patientsDashboard.dart';

import 'aesAlgorithm.dart';

class PatientLoginPage extends StatelessWidget {
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPatientIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: const Color(0xff2F2E40),
        title: Text(
          "Patient's Login",
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
              controller: loginEmailController,
              decoration: InputDecoration(
                labelText: "Patient's Email",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              obscureText: true,
              controller: loginPatientIdController,
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
                await login(context, 'Patients', loginEmailController.text, loginPatientIdController.text);
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> login(BuildContext context, String collection, String email, String patientId) async {
    try {
      final encryptedEmail = AESAlgorithm.encryptData(email);
      final encryptedPatientId = AESAlgorithm.encryptData(patientId);

      var result = await FirebaseFirestore.instance
          .collection(collection)
          .get();

      if (result.docs.isNotEmpty) {
        for (var doc in result.docs) {
          final patientData = doc.data();
          final storedEncryptedEmail = patientData['Email'];
          final storedEncryptedPatientId = patientData['Aadhar Number'];

          if (storedEncryptedEmail == encryptedEmail && storedEncryptedPatientId == encryptedPatientId) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Patientpage()),
            );
            return; // Exit the loop if the login is successful
          }
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Invalid email or password. Please try again.'),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('No patients found. Please try again later.'),
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

