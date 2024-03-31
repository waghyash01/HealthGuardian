import 'package:flutter/material.dart';
import 'package:sampleandro/UpVault.dart';
import 'package:sampleandro/Viewpatientprescription.dart';
import 'package:sampleandro/about.dart';
import 'package:sampleandro/helppage.dart';
import 'package:sampleandro/settings.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'DecryptPatientData.dart';
import 'mainchatbot.dart';

class Patientpage extends StatelessWidget {
  const Patientpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffCCCDCC),

      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: const Color(0xff2F2E40),
        title: Text(
          "Patient's Dashboard",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            //textStyle: const TextStyle(color: Colors.white),
            fontSize: 25,
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
                decoration: BoxDecoration(color: Colors.blueGrey),
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/patient1.jpg"),
                )),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AboutPage(),));
              },
              child: const Card(
                child: ListTile(
                  title: Text("About"),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HelpPage(),));
              },
              child: const Card(
                child: ListTile(
                  title: Text("Helpline"),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage(),));
              },
              child: const Card(
                child: ListTile(
                  title: Text("Settings"),
                ),
              ),
            ),
     ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CardItempatient('Checkups', 'assets/images/Checkups.png', () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ViewPrescriptionPage();
                            },
                  ),
                );
                },),

                CardItempatient('Vault', 'assets/images/Receipts.png', () {
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadImageAndMore()));

                }),
              ],
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CardItempatient('AI Co-doctor', 'assets/images/Prescriptions.png', () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Mychatbot()));

              }),
              CardItempatient('Records', 'assets/images/Records.png', () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AESDecryptionPage()));

              }),
            ],
          ),

        ],
      ),
    );
  }
}

class CardItempatient extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;


  CardItempatient(this.title, this.imagePath, this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5.0,
        margin: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 150.0,
              width: 165.0,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10.0),
            Text(
              title,
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}