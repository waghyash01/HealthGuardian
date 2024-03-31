// import 'dart:math' as math;
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'aesAlgorithm.dart'; // Import the AESAlgorithm class
//
// class PieChartWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: IconThemeData(
//           color: Colors.white, //change your color here
//         ),
//         backgroundColor: const Color(0xff2F2E40),
//         title: Text(
//           "Disease Breakout",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//             //textStyle: TextStyle(color: Colors.white),
//             fontSize: 25,
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: FutureBuilder<Map<String, dynamic>>(
//           future: fetchData(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Center(child: Text('Error: ${snapshot.error}'));
//             } else {
//               Map<String, dynamic> data = snapshot.data ?? {};
//               List<String> diseaseLabels = data['labels'] ?? [];
//               List<Color> sectionColors =
//                   List<Color>.from(data['colors'] ?? []);
//
//               // Calculate frequency of each disease label
//               Map<String, int> frequencyMap =
//                   _calculateFrequencyMap(diseaseLabels);
//
//               return _buildPieChartWidget(
//                   diseaseLabels, sectionColors, frequencyMap);
//             }
//           },
//         ),
//       ),
//     );
//   }
//
//   Future<Map<String, dynamic>> fetchData() async {
//     List<String> labels = [];
//     List<Color> colors = [];
//
//     CollectionReference<Map<String, dynamic>> collectionReference =
//         FirebaseFirestore.instance.collection('Patients');
//     QuerySnapshot<Map<String, dynamic>> snapshot =
//         await collectionReference.get();
//     for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
//       QuerySnapshot<Map<String, dynamic>> subCollectionSnapshot =
//           await doc.reference.collection('Prescriptions').get();
//       for (QueryDocumentSnapshot<Map<String, dynamic>> subDoc
//           in subCollectionSnapshot.docs) {
//         if (subDoc.data().containsKey('Disease')) {
//           String decryptedDisease =
//               await AESAlgorithm.decryptData(subDoc.data()['Disease']);
//           labels.add(decryptedDisease);
//           colors.add(_getRandomColor());
//         }
//       }
//     }
//
//     return {'labels': labels, 'colors': colors};
//   }
//
//   Color _getRandomColor() {
//     return Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
//         .withOpacity(1.0);
//   }
//
//   Map<String, int> _calculateFrequencyMap(List<String> labels) {
//     Map<String, int> frequencyMap = {};
//     labels.forEach(
//         (label) => frequencyMap[label] = (frequencyMap[label] ?? 0) + 1);
//     return frequencyMap;
//   }
//
//   Widget _buildPieChartWidget(
//       List<String> labels, List<Color> colors, Map<String, int> frequencyMap) {
//     List<PieChartSectionData> sections = [];
//     int totalSections = labels.length;
//
//     frequencyMap.forEach((label, frequency) {
//       double percentage = (frequency / totalSections) * 100;
//       sections.add(
//         PieChartSectionData(
//           color: colors[labels.indexOf(label)],
//           value: percentage,
//           title: '${(percentage).toStringAsFixed(2)}%',
//           radius: 180,
//           titleStyle: TextStyle(
//               fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black),
//         ),
//       );
//     });
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Card(
//               elevation: 4,
//               color: Colors.white,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12)),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   children: [
//                     Expanded(
//                       flex: 3,
//                       child: AspectRatio(
//                         aspectRatio: 1.5,
//                         child: PieChart(
//                           PieChartData(
//                             sections: sections,
//                             borderData: FlBorderData(show: false),
//                             sectionsSpace: 0,
//                             centerSpaceRadius: 0,
//                             pieTouchData: PieTouchData(enabled: false),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     Expanded(
//                       flex: 2,
//                       child: ListView(
//                         children: frequencyMap.entries.map((entry) {
//                           return Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 4),
//                             child: Row(
//                               children: [
//                                 Container(
//                                   width: 20,
//                                   height: 20,
//                                   color: colors[labels.indexOf(entry.key)],
//                                 ),
//                                 SizedBox(width: 8),
//                                 Text(entry.key, style: TextStyle(fontSize: 16)),
//                                 Spacer(),
//                                 Text(
//                                     '${(entry.value / totalSections * 100).toStringAsFixed(2)}%',
//                                     style: TextStyle(fontSize: 16)),
//                               ],
//                             ),
//                           );
//                         }).toList(),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
//

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'aesAlgorithm.dart'; // Import the AESAlgorithm class

class PieChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<Map<String, dynamic>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            Map<String, dynamic> data = snapshot.data ?? {};
            List<String> labels = data['labels'] ?? [];
            List<Color> colors = List<Color>.from(data['colors'] ?? []);
            List<PieChartSectionData> sections = [];

            // Calculate frequency of each label
            Map<String, int> frequencyMap = {};
            labels.forEach((label) => frequencyMap[label] = (frequencyMap[label] ?? 0) + 1);

            // Calculate total number of sections
            int totalSections = labels.length;

            // Create pie chart sections
            frequencyMap.forEach((label, frequency) {
              double percentage = (frequency / totalSections) * 100;
              sections.add(
                PieChartSectionData(
                  color: colors[labels.indexOf(label)],
                  value: percentage,
                  title: '${(percentage).toStringAsFixed(2)}%',
                  radius: 80,
                  titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              );
            });

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  color: Colors.white,
                  child: Text(
                    'Percentage of Disease',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 4,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 3,
                              child: AspectRatio(
                                aspectRatio: 1.5,
                                child: PieChart(
                                  PieChartData(
                                    sections: sections,
                                    borderData: FlBorderData(show: false),
                                    sectionsSpace: 0,
                                    centerSpaceRadius: 0,
                                    pieTouchData: PieTouchData(enabled: false),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Expanded(
                              flex: 2,
                              child: ListView(
                                children: frequencyMap.entries.map((entry) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 4),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 20,
                                          height: 20,
                                          color: colors[labels.indexOf(entry.key)],
                                        ),
                                        SizedBox(width: 8),
                                        Text(entry.key, style: TextStyle(fontSize: 16)),
                                        Spacer(),
                                        Text('${(entry.value / totalSections * 100).toStringAsFixed(2)}%', style: TextStyle(fontSize: 16)),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Future<Map<String, dynamic>> fetchData() async {
    List<String> labels = [];
    List<Color> colors = [];

    CollectionReference<Map<String, dynamic>> collectionReference = FirebaseFirestore.instance.collection('Patients');
    QuerySnapshot<Map<String, dynamic>> snapshot = await collectionReference.get();
    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
      QuerySnapshot<Map<String, dynamic>> subCollectionSnapshot = await doc.reference.collection('Prescriptions').get();
      for (QueryDocumentSnapshot<Map<String, dynamic>> subDoc in subCollectionSnapshot.docs) {
        if (subDoc.data().containsKey('Disease')) {
          String decryptedDisease = await AESAlgorithm.decryptData(subDoc.data()['Disease']);
          labels.add(decryptedDisease);
          colors.add(getRandomColor());
        }
      }
    }

    return {'labels': labels, 'colors': colors};
  }

  Color getRandomColor() {
    return Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  }
}
