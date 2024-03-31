import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sampleandro/AgePIEchart.dart';
import 'package:sampleandro/Analytics.dart';
import 'package:sampleandro/GenderWisePieChart.dart';
import 'package:sampleandro/Login.dart';
import 'package:sampleandro/pieChart.dart';
import 'package:sampleandro/statewiseDoctorsPie.dart';
import 'IntroPage - Copy.dart';
import 'StateWisePieCharts.dart';
import 'UpVault.dart';
import 'jailbreak.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDXOVcE8-POU-1D1bCr1AjtFdD1HUJEP84",
      appId: "1:472305237336:android:57b049f20d3bafc6d9792d",
      messagingSenderId: "472305237336",
      projectId: "health360-5ba1a",
      storageBucket: 'health360-5ba1a.appspot.com',
    ),
  );

  // Request permissions
  await requestPermissions();

  // Check for jailbreak/root status
  bool isJailbroken = await FlutterJailbreakDetection.jailbroken;

  runApp(MyApp(isJailbroken: isJailbroken));
}

Future<void> requestPermissions() async {
  await [
    Permission.camera,
    Permission.microphone,
    Permission.storage,
    Permission.mediaLibrary,
    Permission.location,
    Permission.photos,
    Permission.audio,
    // Add more permissions as needed
  ].request();
}

class MyApp extends StatefulWidget {
  final bool isJailbroken;

  const MyApp({Key? key, required this.isJailbroken}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // Handle app lifecycle state changes here
    if (state == AppLifecycleState.paused) {
      // App is in the background
      // Perform actions to restrict background access here
      stopBackgroundAccess();
    }
  }

  void stopBackgroundAccess() {
    // Implement background access restriction logic here
    // For example, stop background tasks or clear sensitive data
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: widget.isJailbroken ? JailbreakDetectedPage() : PieChartWidget(),
    );
  }
}