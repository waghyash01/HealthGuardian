import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sampleandro/Guidelines.dart';
import 'package:sampleandro/doctorsDashboard.dart';
import 'package:sampleandro/patientsDashboard.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'AuthorityLoginPage.dart';
import 'DoctorLoginPage.dart';
import 'PatientLoginPage.dart';
import 'authorityDashboard.dart';
import 'carditem.dart';
import 'aesAlgorithm.dart';

class UserTypeSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff2F2E40),
        title: Center(
          child: Text(
            "Select User",
            style: TextStyle(
              fontWeight: FontWeight.bold,
             color: Colors.white,
             // textStyle: TextStyle(color: Colors.white),
              fontSize: 25,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CardItem('Patient', 'assets/images/Patients.png', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PatientLoginPage()),
              );
            }),
            SizedBox(height: 70.0),
            CardItem('Doctor', 'assets/images/Doctors.png', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DoctorLoginPage()),
              );
            }),

            SizedBox(height: 70.0),
            CardItem('Authority', 'assets/images/Doctors.png', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AuthorityLoginPage()),
              );
            }),
          ],
        ),
      ),
    );
  }
}

