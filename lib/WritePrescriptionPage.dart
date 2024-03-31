// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'aesAlgorithm.dart'; // Import the AESAlgorithm class
// // //import 'package:google_fonts/google_fonts.dart';
// //
// //
// // class WritePrescriptionPage extends StatefulWidget {
// //   @override
// //   _WritePrescriptionPageState createState() => _WritePrescriptionPageState();
// // }
// //
// // class _WritePrescriptionPageState extends State<WritePrescriptionPage> {
// //   final TextEditingController prescriptionController = TextEditingController();
// //   final TextEditingController checkupDateController = TextEditingController();
// //   final TextEditingController doctorNameController = TextEditingController();
// //   final TextEditingController aadharController = TextEditingController(); // Add Aadhar controller
// //   final TextEditingController DiseaseController = TextEditingController(); // Add Aadhar controller
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         iconTheme: const IconThemeData(
// //           color: Colors.white, //change your color here
// //         ),
// //         backgroundColor: const Color(0xff2F2E40),
// //         title: Text(
// //           "Write Prescription",
// //           style: TextStyle(
// //             fontWeight: FontWeight.bold,
// //             color: Colors.white,
// //             //textStyle: const TextStyle(color: Colors.white),
// //             fontSize: 25,
// //           ),
// //         ),
// //       ),
// //       body: SingleChildScrollView(
// //         child: Container(
// //           margin: EdgeInsets.only(top: 15),
// //           child: Padding(
// //             padding: EdgeInsets.all(16.0),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.stretch,
// //               children: [
// //                 TextField(
// //                 controller: aadharController, // Add Aadhar controller
// //                 decoration: InputDecoration(labelText: 'Aadhar Number'), // Add Aadhar field
// //               ),
// //                 SizedBox(height: 16.0),
// //                 TextField(
// //                   controller: prescriptionController,
// //                   decoration: InputDecoration(labelText: 'Prescription Details'),
// //                 ),
// //                 SizedBox(height: 16.0),
// //                 TextField(
// //                   controller: checkupDateController,
// //                   decoration: InputDecoration(labelText: 'Checkup Date'),
// //                 ),
// //                 SizedBox(height: 16.0),
// //                 TextField(
// //                   controller: DiseaseController,
// //                   decoration: InputDecoration(labelText: 'Disease'),
// //                 ),
// //                 SizedBox(height: 16.0),
// //                 TextField(
// //                   controller: doctorNameController,
// //                   decoration: InputDecoration(labelText: 'Doctor Name'),
// //                 ),
// //                 SizedBox(height: 16.0),
// //
// //                 ElevatedButton(
// //                   style: ElevatedButton.styleFrom(
// //                       backgroundColor: const Color(0xff2F2E40),
// //                       foregroundColor: Colors.white),                  onPressed: () {
// //                     validateAndWritePrescription(context);
// //                   },
// //                   child: Text('Submit Prescription', style: TextStyle(color: Colors.white)),
// //                 ),
// //                 SizedBox(height: 16.0),
// //                 ElevatedButton(
// //                   style: ElevatedButton.styleFrom(
// //                       backgroundColor: const Color(0xff2F2E40),
// //                       foregroundColor: Colors.white),                  onPressed: () {
// //                     String aadharNumber = aadharController.text;
// //                     String encryptedaadharNumber = AESAlgorithm.encryptData(aadharNumber.toString());
// //                     fetchPrescriptions(encryptedaadharNumber).then((prescriptions) {
// //                       if (prescriptions.isNotEmpty) {
// //                         Navigator.push(
// //                           context,
// //                           MaterialPageRoute(
// //                             builder: (context) => PrescriptionHistoryPage(
// //                               prescriptions: prescriptions,
// //                             ),
// //                           ),
// //                         );
// //                       } else {
// //                         ScaffoldMessenger.of(context).showSnackBar(
// //                           SnackBar(
// //                             content: Text('No prescriptions found for the provided Aadhar number.'),
// //                           ),
// //                         );
// //                       }
// //                     });
// //                   },
// //                   child: Text('Prescription History', style: TextStyle(color: Colors.white)),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   void validateAndWritePrescription(BuildContext context) async {
// //     String prescriptionDetails = prescriptionController.text;
// //     String checkupDate = checkupDateController.text;
// //     String doctorName = doctorNameController.text;
// //     String aadharNumber = aadharController.text;
// //     String Disease = DiseaseController.text;
// //
// //     String encryptedaadharNumber = AESAlgorithm.encryptData(aadharNumber.toString());
// //
// //     // Encrypt prescription details, checkup date, and doctor name
// //     String encryptedPrescriptionDetails = AESAlgorithm.encryptData(prescriptionDetails);
// //     String encryptedCheckupDate = AESAlgorithm.encryptData(checkupDate);
// //     String encryptedDoctorName = AESAlgorithm.encryptData(doctorName);
// //     String encryptedDisease = AESAlgorithm.encryptData(Disease);
// //
// //     bool isValid = await fetchPatient(encryptedaadharNumber);
// //     if (isValid) {
// //       // Store the prescription data in Firestore
// //       await FirebaseFirestore.instance.collection('Patients').where('Aadhar Number', isEqualTo: encryptedaadharNumber).get().then((querySnapshot) async {
// //         if (querySnapshot.docs.isNotEmpty) {
// //           await querySnapshot.docs.first.reference.collection('Prescriptions').add({
// //             'prescriptionDetails': encryptedPrescriptionDetails,
// //             'checkupDate': encryptedCheckupDate,
// //             'doctorName': encryptedDoctorName,
// //             'Disease': encryptedDisease,
// //           });
// //
// //           ScaffoldMessenger.of(context).showSnackBar(
// //             SnackBar(
// //               content: Text('Prescription added successfully!'),
// //             ),
// //           );
// //         }
// //       });
// //     } else {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //           content: Text('No patient found with the provided Aadhar number.'),
// //         ),
// //       );
// //     }
// //   }
// //
// //   Future<bool> fetchPatient(String encryptedaadharNumber) async {
// //
// //     QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Patients').where('Aadhar Number', isEqualTo: encryptedaadharNumber).get();
// //     return querySnapshot.docs.isNotEmpty;
// //   }
// //
// //   Future<List<Map<String, String>>> fetchPrescriptions(String encryptedaadharNumber) async {
// //     List<Map<String, String>> prescriptions = [];
// //
// //     QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Patients').where('Aadhar Number', isEqualTo: encryptedaadharNumber).get();
// //     if (querySnapshot.docs.isNotEmpty) {
// //       // Get the first document which should be the only one as Aadhar Number should be unique
// //       DocumentSnapshot patientDoc = querySnapshot.docs.first;
// //       // Fetch prescriptions from subcollection
// //       QuerySnapshot prescriptionsSnapshot = await patientDoc.reference.collection('Prescriptions').get();
// //       prescriptionsSnapshot.docs.forEach((prescriptionDoc) {
// //         Map<String, String> prescription = {
// //           'prescriptionDetails': AESAlgorithm.decryptData(prescriptionDoc['prescriptionDetails']) ?? 'Decryption Error',
// //           'checkupDate': AESAlgorithm.decryptData(prescriptionDoc['checkupDate']) ?? 'Decryption Error',
// //           'doctorName': AESAlgorithm.decryptData(prescriptionDoc['doctorName']) ?? 'Decryption Error',
// //           'Disease': AESAlgorithm.decryptData(prescriptionDoc['Disease']) ?? 'Decryption Error',
// //         };
// //         prescriptions.add(prescription);
// //       });
// //     }
// //     return prescriptions;
// //   }
// // }
// //
// // class PrescriptionHistoryPage extends StatelessWidget {
// //   final List<Map<String, String>> prescriptions;
// //
// //   PrescriptionHistoryPage({required this.prescriptions});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Prescription History'),
// //       ),
// //       body: ListView.builder(
// //         itemCount: prescriptions.length,
// //         itemBuilder: (context, index) {
// //           Map<String, String> prescription = prescriptions[index];
// //           return ListTile(
// //             title: Text('Prescription Details: ${prescription['prescriptionDetails']}'),
// //             subtitle: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text('Checkup Date: ${prescription['checkupDate']}'),
// //                 Text('Doctor Name: ${prescription['doctorName']}'),
// //               ],
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
//
//
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'aesAlgorithm.dart';
//
// class WritePrescriptionPage extends StatefulWidget {
//   @override
//   _WritePrescriptionPageState createState() => _WritePrescriptionPageState();
// }
//
// class _WritePrescriptionPageState extends State<WritePrescriptionPage> {
//   final TextEditingController prescriptionController = TextEditingController();
//   final TextEditingController checkupDateController = TextEditingController();
//   final TextEditingController doctorNameController = TextEditingController();
//   final TextEditingController aadharController = TextEditingController();
//   final TextEditingController DiseaseController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: const IconThemeData(
//           color: Colors.white,
//         ),
//         backgroundColor: const Color(0xff2F2E40),
//         title: Text(
//           "Write Prescription",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//             fontSize: 25,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           margin: EdgeInsets.only(top: 15),
//           child: Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 TextField(
//                   controller: aadharController,
//                   decoration: InputDecoration(labelText: 'Aadhar Number'),
//                 ),
//                 SizedBox(height: 16.0),
//                 TextField(
//                   controller: prescriptionController,
//                   decoration: InputDecoration(labelText: 'Prescription Details'),
//                 ),
//                 SizedBox(height: 16.0),
//                 TextField(
//                   controller: checkupDateController,
//                   decoration: InputDecoration(labelText: 'Checkup Date'),
//                 ),
//                 SizedBox(height: 16.0),
//                 TextField(
//                   controller: DiseaseController,
//                   decoration: InputDecoration(labelText: 'Disease'),
//                 ),
//                 SizedBox(height: 16.0),
//                 TextField(
//                   controller: doctorNameController,
//                   decoration: InputDecoration(labelText: 'Doctor Name'),
//                 ),
//                 SizedBox(height: 16.0),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xff2F2E40),
//                     foregroundColor: Colors.white,
//                   ),
//                   onPressed: () {
//                     validateAndWritePrescription(context);
//                   },
//                   child: Text('Submit Prescription', style: TextStyle(color: Colors.white)),
//                 ),
//                 SizedBox(height: 16.0),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xff2F2E40),
//                     foregroundColor: Colors.white,
//                   ),
//                   onPressed: () {
//                     String aadharNumber = aadharController.text;
//                     String encryptedaadharNumber = AESAlgorithm.encryptData(aadharNumber.toString());
//                     fetchPrescriptions(encryptedaadharNumber).then((prescriptions) {
//                       if (prescriptions.isNotEmpty && validateAndWritePrescription == 1) {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => PrescriptionHistoryPage(
//                               prescriptions: prescriptions,
//                             ),
//                           ),
//                         );
//                       } else if (prescriptions.isEmpty && validateAndWritePrescription == 1) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text('No prescriptions found for the provided Aadhar number.'),
//                           ),
//                         );
//                       }
//                     });
//                   },
//                   child: Text('Prescription History', style: TextStyle(color: Colors.white)),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void validateAndWritePrescription(BuildContext context) async {
//     String prescriptionDetails = prescriptionController.text;
//     String checkupDate = checkupDateController.text;
//     String doctorName = doctorNameController.text;
//     String aadharNumber = aadharController.text;
//     String Disease = DiseaseController.text;
//
//     String encryptedaadharNumber = AESAlgorithm.encryptData(aadharNumber.toString());
//     String encrypteddoctorName = AESAlgorithm.encryptData(doctorName.toString());
//
//     // Encrypt prescription details, checkup date, and doctor name
//     String encryptedPrescriptionDetails = AESAlgorithm.encryptData(prescriptionDetails);
//     String encryptedCheckupDate = AESAlgorithm.encryptData(checkupDate);
//     String encryptedDoctorName = AESAlgorithm.encryptData(doctorName);
//     String encryptedDisease = AESAlgorithm.encryptData(Disease);
//
//     bool isValid = await fetchPatient(encryptedaadharNumber);
//     if (isValid) {
//       bool isLocationValid = await checkDoctorLocation(encryptedaadharNumber, encrypteddoctorName);
//       if (!isLocationValid) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Location Based Restriction: Doctor does not match Aadhar Number address.'),
//           ),
//         );
//         return;
//       }
//
//       await FirebaseFirestore.instance.collection('Patients').where('Aadhar Number', isEqualTo: encryptedaadharNumber).get().then((querySnapshot) async {
//         if (querySnapshot.docs.isNotEmpty) {
//           await querySnapshot.docs.first.reference.collection('Prescriptions').add({
//             'prescriptionDetails': encryptedPrescriptionDetails,
//             'checkupDate': encryptedCheckupDate,
//             'doctorName': encryptedDoctorName,
//             'Disease': encryptedDisease,
//           });
//
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('Prescription added successfully!'),
//             ),
//           );
//         }
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('No patient found with the provided Aadhar number.'),
//         ),
//       );
//     }
//   }
//
//   Future<bool> checkDoctorLocation(String encryptedaadharNumber, String encrypteddoctorName) async {
//     QuerySnapshot doctorSnapshot = await FirebaseFirestore.instance.collection('Doctors').where('Name', isEqualTo: encrypteddoctorName).get();
//     if (doctorSnapshot.docs.isNotEmpty) {
//       DocumentSnapshot doctorDoc = doctorSnapshot.docs.first;
//       String doctorAddress = doctorDoc['Address'];
//       QuerySnapshot patientSnapshot = await FirebaseFirestore.instance.collection('Patients').where('Aadhar Number', isEqualTo: encryptedaadharNumber).get();
//       if (patientSnapshot.docs.isNotEmpty) {
//         DocumentSnapshot patientDoc = patientSnapshot.docs.first;
//         String patientAddress = patientDoc['Address'];
//         return doctorAddress == patientAddress;
//       }
//     }
//     return false;
//   }
//
//   Future<bool> fetchPatient(String encryptedaadharNumber) async {
//     QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Patients').where('Aadhar Number', isEqualTo: encryptedaadharNumber).get();
//     return querySnapshot.docs.isNotEmpty;
//   }
//
//   Future<List<Map<String, String>>> fetchPrescriptions(String encryptedaadharNumber) async {
//     List<Map<String, String>> prescriptions = [];
//
//     QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Patients').where('Aadhar Number', isEqualTo: encryptedaadharNumber).get();
//     if (querySnapshot.docs.isNotEmpty) {
//       DocumentSnapshot patientDoc = querySnapshot.docs.first;
//       QuerySnapshot prescriptionsSnapshot = await patientDoc.reference.collection('Prescriptions').get();
//       prescriptionsSnapshot.docs.forEach((prescriptionDoc) {
//         Map<String, String> prescription = {
//           'prescriptionDetails': AESAlgorithm.decryptData(prescriptionDoc['prescriptionDetails']) ?? 'Decryption Error',
//           'checkupDate': AESAlgorithm.decryptData(prescriptionDoc['checkupDate']) ?? 'Decryption Error',
//           'doctorName': AESAlgorithm.decryptData(prescriptionDoc['doctorName']) ?? 'Decryption Error',
//           'Disease': AESAlgorithm.decryptData(prescriptionDoc['Disease']) ?? 'Decryption Error',
//         };
//         prescriptions.add(prescription);
//       });
//     }
//     return prescriptions;
//   }
// }
//
// class PrescriptionHistoryPage extends StatelessWidget {
//   final List<Map<String, String>> prescriptions;
//
//   PrescriptionHistoryPage({required this.prescriptions});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Prescription History'),
//       ),
//       body: ListView.builder(
//         itemCount: prescriptions.length,
//         itemBuilder: (context, index) {
//           Map<String, String> prescription = prescriptions[index];
//           return ListTile(
//             title: Text('Prescription Details: ${prescription['prescriptionDetails']}'),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Checkup Date: ${prescription['checkupDate']}'),
//                 Text('Doctor Name: ${prescription['doctorName']}'),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'aesAlgorithm.dart';
//
// class WritePrescriptionPage extends StatefulWidget {
//   @override
//   _WritePrescriptionPageState createState() => _WritePrescriptionPageState();
// }
//
// class _WritePrescriptionPageState extends State<WritePrescriptionPage> {
//   final TextEditingController prescriptionController = TextEditingController();
//   final TextEditingController checkupDateController = TextEditingController();
//   final TextEditingController doctorNameController = TextEditingController();
//   final TextEditingController aadharController = TextEditingController();
//   final TextEditingController DiseaseController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: const IconThemeData(
//           color: Colors.white,
//         ),
//         backgroundColor: const Color(0xff2F2E40),
//         title: Text(
//           "Write Prescription",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//             fontSize: 25,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           margin: EdgeInsets.only(top: 15),
//           child: Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 TextField(
//                   controller: aadharController,
//                   decoration: InputDecoration(labelText: 'Aadhar Number'),
//                 ),
//                 SizedBox(height: 16.0),
//                 TextField(
//                   controller: prescriptionController,
//                   decoration: InputDecoration(labelText: 'Prescription Details'),
//                 ),
//                 SizedBox(height: 16.0),
//                 TextField(
//                   controller: checkupDateController,
//                   decoration: InputDecoration(labelText: 'Checkup Date'),
//                 ),
//                 SizedBox(height: 16.0),
//                 TextField(
//                   controller: DiseaseController,
//                   decoration: InputDecoration(labelText: 'Disease'),
//                 ),
//                 SizedBox(height: 16.0),
//                 TextField(
//                   controller: doctorNameController,
//                   decoration: InputDecoration(labelText: 'Doctor Name'),
//                 ),
//                 SizedBox(height: 16.0),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xff2F2E40),
//                     foregroundColor: Colors.white,
//                   ),
//                   onPressed: () {
//                     validateAndWritePrescription(context);
//                   },
//                   child: Text('Submit Prescription', style: TextStyle(color: Colors.white)),
//                 ),
//                 SizedBox(height: 16.0),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xff2F2E40),
//                     foregroundColor: Colors.white,
//                   ),
//                   onPressed: () {
//                     String aadharNumber = aadharController.text;
//                     String encryptedaadharNumber = AESAlgorithm.encryptData(aadharNumber.toString());
//                     fetchPrescriptions(encryptedaadharNumber).then((prescriptions) {
//                       if (prescriptions.isNotEmpty) {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => PrescriptionHistoryPage(
//                               prescriptions: prescriptions,
//                             ),
//                           ),
//                         );
//                       } else {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text('No prescriptions found for the provided Aadhar number.'),
//                           ),
//                         );
//                       }
//                     });
//                   },
//                   child: Text('Prescription History', style: TextStyle(color: Colors.white)),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void validateAndWritePrescription(BuildContext context) async {
//     String prescriptionDetails = prescriptionController.text;
//     String checkupDate = checkupDateController.text;
//     String doctorName = doctorNameController.text;
//     String aadharNumber = aadharController.text;
//     String Disease = DiseaseController.text;
//
//     String encryptedaadharNumber = AESAlgorithm.encryptData(aadharNumber.toString());
//     String encrypteddoctorName = AESAlgorithm.encryptData(doctorName.toString());
//
//     // Encrypt prescription details, checkup date, and doctor name
//     String encryptedPrescriptionDetails = AESAlgorithm.encryptData(prescriptionDetails);
//     String encryptedCheckupDate = AESAlgorithm.encryptData(checkupDate);
//     String encryptedDoctorName = AESAlgorithm.encryptData(doctorName);
//     String encryptedDisease = AESAlgorithm.encryptData(Disease);
//
//     bool isValid = await fetchPatient(encryptedaadharNumber);
//     if (isValid) {
//       bool isLocationValid = await checkDoctorLocation(encryptedaadharNumber, encrypteddoctorName);
//       if (!isLocationValid) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Location Based Restriction: Doctor does not match Aadhar Number address.'),
//           ),
//         );
//         return;
//       }
//
//       await FirebaseFirestore.instance.collection('Patients').where('Aadhar Number', isEqualTo: encryptedaadharNumber).get().then((querySnapshot) async {
//         if (querySnapshot.docs.isNotEmpty) {
//           await querySnapshot.docs.first.reference.collection('Prescriptions').add({
//             'prescriptionDetails': encryptedPrescriptionDetails,
//             'checkupDate': encryptedCheckupDate,
//             'doctorName': encryptedDoctorName,
//             'Disease': encryptedDisease,
//           });
//
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('Prescription added successfully!'),
//             ),
//           );
//         }
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('No patient found with the provided Aadhar number.'),
//         ),
//       );
//     }
//   }
//
//   Future<bool> checkDoctorLocation(String encryptedaadharNumber, String encrypteddoctorName) async {
//     QuerySnapshot doctorSnapshot = await FirebaseFirestore.instance.collection('Doctors').where('Name', isEqualTo: encrypteddoctorName).get();
//     if (doctorSnapshot.docs.isNotEmpty) {
//       DocumentSnapshot doctorDoc = doctorSnapshot.docs.first;
//       String doctorAddress = doctorDoc['Address'];
//
//       QuerySnapshot patientSnapshot = await FirebaseFirestore.instance.collection('Patients').where('Aadhar Number', isEqualTo: encryptedaadharNumber).get();
//       if (patientSnapshot.docs.isNotEmpty) {
//         DocumentSnapshot patientDoc = patientSnapshot.docs.first;
//         String patientAddress = patientDoc['Address'];
//
//         // Check if patient's address matches doctor's address
//         return doctorAddress == patientAddress;
//       }
//     }
//     return false;
//   }
//
//   Future<bool> fetchPatient(String encryptedaadharNumber) async {
//     QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Patients').where('Aadhar Number', isEqualTo: encryptedaadharNumber).get();
//     return querySnapshot.docs.isNotEmpty;
//   }
//
//   Future<List<Map<String, String>>> fetchPrescriptions(String encryptedaadharNumber) async {
//     List<Map<String, String>> prescriptions = [];
//
//     QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Patients').where('Aadhar Number', isEqualTo: encryptedaadharNumber).get();
//     if (querySnapshot.docs.isNotEmpty) {
//       DocumentSnapshot patientDoc = querySnapshot.docs.first;
//       QuerySnapshot prescriptionsSnapshot = await patientDoc.reference.collection('Prescriptions').get();
//       prescriptionsSnapshot.docs.forEach((prescriptionDoc) {
//         Map<String, String> prescription = {
//           'prescriptionDetails': AESAlgorithm.decryptData(prescriptionDoc['prescriptionDetails']) ?? 'Decryption Error',
//           'checkupDate': AESAlgorithm.decryptData(prescriptionDoc['checkupDate']) ?? 'Decryption Error',
//           'doctorName': AESAlgorithm.decryptData(prescriptionDoc['doctorName']) ?? 'Decryption Error',
//           'Disease': AESAlgorithm.decryptData(prescriptionDoc['Disease']) ?? 'Decryption Error',
//         };
//         prescriptions.add(prescription);
//       });
//     }
//     return prescriptions;
//   }
// }
//
// class PrescriptionHistoryPage extends StatelessWidget {
//   final List<Map<String, String>> prescriptions;
//
//   PrescriptionHistoryPage({required this.prescriptions});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Prescription History'),
//       ),
//       body: ListView.builder(
//         itemCount: prescriptions.length,
//         itemBuilder: (context, index) {
//           Map<String, String> prescription = prescriptions[index];
//           return ListTile(
//             title: Text('Prescription Details: ${prescription['prescriptionDetails']}'),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Checkup Date: ${prescription['checkupDate']}'),
//                 Text('Doctor Name: ${prescription['doctorName']}'),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'aesAlgorithm.dart';

class WritePrescriptionPage extends StatefulWidget {
  @override
  _WritePrescriptionPageState createState() => _WritePrescriptionPageState();
}

class _WritePrescriptionPageState extends State<WritePrescriptionPage> {
  final TextEditingController prescriptionController = TextEditingController();
  final TextEditingController checkupDateController = TextEditingController();
  final TextEditingController doctorNameController = TextEditingController();
  final TextEditingController aadharController = TextEditingController();
  final TextEditingController DiseaseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: const Color(0xff2F2E40),
        title: Text(
          "Write Prescription",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 15),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: aadharController,
                  decoration: InputDecoration(labelText: 'Aadhar Number'),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: prescriptionController,
                  decoration: InputDecoration(labelText: 'Prescription Details'),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: checkupDateController,
                  decoration: InputDecoration(labelText: 'Checkup Date'),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: DiseaseController,
                  decoration: InputDecoration(labelText: 'Disease'),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: doctorNameController,
                  decoration: InputDecoration(labelText: 'Doctor Name'),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff2F2E40),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    validateAndWritePrescription(context);
                  },
                  child: Text('Submit Prescription', style: TextStyle(color: Colors.white)),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff2F2E40),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    validateAndWritePrescription1(context);
                    // String aadharNumber = aadharController.text;
                    // String encryptedaadharNumber = AESAlgorithm.encryptData(aadharNumber.toString());
                    // fetchPrescriptions(encryptedaadharNumber).then((prescriptions) {
                    //   if (prescriptions.isNotEmpty) {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => PrescriptionHistoryPage(
                    //           prescriptions: prescriptions,
                    //         ),
                    //       ),
                    //     );
                    //   } else {
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       SnackBar(
                    //         content: Text('No prescriptions found for the provided Aadhar number.'),
                    //       ),
                    //     );
                    //   }
                    //});
                  },
                  child: Text('Prescription History', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validateAndWritePrescription(BuildContext context) async {
    String prescriptionDetails = prescriptionController.text;
    String checkupDate = checkupDateController.text;
    String doctorName = doctorNameController.text;
    String aadharNumber = aadharController.text;
    String Disease = DiseaseController.text;

    String encryptedaadharNumber = AESAlgorithm.encryptData(aadharNumber.toString());
    String encrypteddoctorName = AESAlgorithm.encryptData(doctorName.toString());

    // Encrypt prescription details, checkup date, and doctor name
    String encryptedPrescriptionDetails = AESAlgorithm.encryptData(prescriptionDetails);
    String encryptedCheckupDate = AESAlgorithm.encryptData(checkupDate);
    String encryptedDoctorName = AESAlgorithm.encryptData(doctorName);
    String encryptedDisease = AESAlgorithm.encryptData(Disease);

    bool isValid = await fetchPatient(encryptedaadharNumber);
    if (isValid) {
      bool isLocationValid = await checkDoctorLocation(encryptedaadharNumber, encrypteddoctorName);
      if (!isLocationValid) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Location Based Restriction: Doctor does not match Aadhar Number address.'),
          ),
        );
        return;
      }

      await FirebaseFirestore.instance.collection('Patients').where('Aadhar Number', isEqualTo: encryptedaadharNumber).get().then((querySnapshot) async {
        if (querySnapshot.docs.isNotEmpty) {
          await querySnapshot.docs.first.reference.collection('Prescriptions').add({
            'prescriptionDetails': encryptedPrescriptionDetails,
            'checkupDate': encryptedCheckupDate,
            'doctorName': encryptedDoctorName,
            'Disease': encryptedDisease,
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Prescription added successfully!'),
            ),
          );
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No patient found with the provided Aadhar number.'),
        ),
      );
    }
  }

  /////////////////////////////
  void validateAndWritePrescription1(BuildContext context) async {
    String doctorName = doctorNameController.text;
    String aadharNumber = aadharController.text;

    String encryptedaadharNumber = AESAlgorithm.encryptData(aadharNumber.toString());
    String encrypteddoctorName = AESAlgorithm.encryptData(doctorName.toString());



    bool isValid = await fetchPatient(encryptedaadharNumber);
    if (isValid) {
      bool isLocationValid = await checkDoctorLocation(encryptedaadharNumber, encrypteddoctorName);
      if (!isLocationValid) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Location Based Restriction: Doctor does not match Aadhar Number address.'),
          ),
        );
        return;
      }

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
    }
  }

  ///////////////////////////////
  Future<bool> checkDoctorLocation(String encryptedaadharNumber, String encrypteddoctorName) async {
    QuerySnapshot doctorSnapshot = await FirebaseFirestore.instance.collection('Doctors').where('Name', isEqualTo: encrypteddoctorName).get();
    if (doctorSnapshot.docs.isNotEmpty) {
      DocumentSnapshot doctorDoc = doctorSnapshot.docs.first;
      String doctorAddress = doctorDoc['Address'];

      QuerySnapshot patientSnapshot = await FirebaseFirestore.instance.collection('Patients').where('Aadhar Number', isEqualTo: encryptedaadharNumber).get();
      if (patientSnapshot.docs.isNotEmpty) {
        DocumentSnapshot patientDoc = patientSnapshot.docs.first;
        String patientAddress = patientDoc['Address'];

        // Check if patient's address matches doctor's address
        return doctorAddress == patientAddress;
      }
    }
    return false;
  }

  Future<bool> fetchPatient(String encryptedaadharNumber) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Patients').where('Aadhar Number', isEqualTo: encryptedaadharNumber).get();
    return querySnapshot.docs.isNotEmpty;
  }

  Future<List<Map<String, String>>> fetchPrescriptions(String encryptedaadharNumber) async {
    List<Map<String, String>> prescriptions = [];

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Patients').where('Aadhar Number', isEqualTo: encryptedaadharNumber).get();
    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot patientDoc = querySnapshot.docs.first;
      QuerySnapshot prescriptionsSnapshot = await patientDoc.reference.collection('Prescriptions').get();
      prescriptionsSnapshot.docs.forEach((prescriptionDoc) {
        Map<String, String> prescription = {
          'prescriptionDetails': AESAlgorithm.decryptData(prescriptionDoc['prescriptionDetails']) ?? 'Decryption Error',
          'checkupDate': AESAlgorithm.decryptData(prescriptionDoc['checkupDate']) ?? 'Decryption Error',
          'doctorName': AESAlgorithm.decryptData(prescriptionDoc['doctorName']) ?? 'Decryption Error',
          'Disease': AESAlgorithm.decryptData(prescriptionDoc['Disease']) ?? 'Decryption Error',
        };
        prescriptions.add(prescription);
      });
    }
    return prescriptions;
  }
}

class PrescriptionHistoryPage extends StatelessWidget {
  final List<Map<String, String>> prescriptions;

  PrescriptionHistoryPage({required this.prescriptions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prescription History'),
      ),
      body: ListView.builder(
        itemCount: prescriptions.length,
        itemBuilder: (context, index) {
          Map<String, String> prescription = prescriptions[index];
          return ListTile(
            title: Text('Prescription Details: ${prescription['prescriptionDetails']}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Checkup Date: ${prescription['checkupDate']}'),
                Text('Doctor Name: ${prescription['doctorName']}'),
              ],
            ),
          );
        },
      ),
    );
  }
}

