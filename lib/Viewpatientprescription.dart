import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'aesAlgorithm.dart'; // Import the AESAlgorithm class

class ViewPrescriptionPage extends StatefulWidget {
  @override
  _ViewPrescriptionPageState createState() => _ViewPrescriptionPageState();
}

class _ViewPrescriptionPageState extends State<ViewPrescriptionPage> {
  final TextEditingController aadharController = TextEditingController(); // Add Aadhar controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: const Color(0xff2F2E40),
        title: Text(
          "Enter Patient Details",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            //textStyle: TextStyle(color: Colors.white),
            fontSize: 25,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: aadharController, // Add Aadhar controller
                decoration: InputDecoration(labelText: 'Aadhar Number'), // Add Aadhar field
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  String aadharNumber = aadharController.text;
                  String encryptedaadharNumber = AESAlgorithm.encryptData(aadharNumber.toString());
                  fetchPrescriptions(encryptedaadharNumber).then((prescriptions) {
                    if (prescriptions.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PrescriptionHistoryPage(
                            prescriptions: prescriptions,
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('No prescriptions found for the provided Aadhar number.'),
                        ),
                      );
                    }
                  });
                },
                child: Text('Prescription History'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> fetchPrescriptions(String encryptedaadharNumber) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Patients').where('Aadhar Number', isEqualTo: encryptedaadharNumber).get();
    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.reference.collection('Prescriptions').get().then((querySnapshot) {
        return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      });
    } else {
      return [];
    }
  }
}

class PrescriptionHistoryPage extends StatelessWidget {
  final List<Map<String, dynamic>> prescriptions;

  PrescriptionHistoryPage({required this.prescriptions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prescription History'),
      ),
      body: PrescriptionList(
        prescriptions: prescriptions,
      ),
    );
  }
}

class PrescriptionList extends StatelessWidget {
  final List<Map<String, dynamic>> prescriptions;

  PrescriptionList({required this.prescriptions});

  @override
  Widget build(BuildContext context) {
    if (prescriptions.isNotEmpty) {
      return ListView.builder(
        itemCount: prescriptions.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> prescription = prescriptions[index];
          String decryptedPrescriptionDetails = AESAlgorithm.decryptData(prescription['prescriptionDetails']) ?? 'Decryption Error';
          String decryptedCheckupDate = AESAlgorithm.decryptData(prescription['checkupDate']) ?? 'Decryption Error';
          String decryptedDoctorName = AESAlgorithm.decryptData(prescription['doctorName']) ?? 'Decryption Error';
          return ListTile(
            title: Text('Prescription Details: $decryptedPrescriptionDetails'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Checkup Date: $decryptedCheckupDate'),
                Text('Doctor Name: $decryptedDoctorName'),
              ],
            ),
          );
        },
      );
    } else {
      return Center(child: Text('No prescriptions available.'));
    }
  }
}
