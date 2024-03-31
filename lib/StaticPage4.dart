import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Login.dart';
//import 'HomePage.dart';

class Static4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0E0E0),
      appBar: AppBar(
        backgroundColor: const Color(0xff2F2E40),
        centerTitle: true,
        title: const Text(
          'Privacy Information',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 5),
            PrivacyContainer(
              text:
              "Data Security for Patients:\n\n- Your data is for your eyes only\n- No one at HealthGuardian can view your data\n- We do not send you messages without your permission\n- We send promotional messages with an option to opt out any time\n- We do not share data with any third party",
            ),
            SizedBox(height: 5),
            PrivacyContainer(
              text:
              "Data Security for Doctors:\n\n- We do not have access to read or view your practice data\n- We do not share data with any third party\n- Doctors are in full control to decide what communication has to be sent to their patients\n- We follow stringent data policies to ensure users’ privacy and security",
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserTypeSelectionPage()),
                );
              },
              child: Icon(
                Icons.arrow_forward,
                size: 55,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PrivacyContainer extends StatelessWidget {
  final String text;

  const PrivacyContainer({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xFFC5E1A5),
        boxShadow: [
          BoxShadow(
            color: Colors.black .withOpacity(0.1),
            spreadRadius: 6,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(20),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18, // Increased font size for better visibility
          fontWeight: FontWeight.bold, // Bold font weight
          color: Colors.black87,
        ),
      ),
    );
  }
}
