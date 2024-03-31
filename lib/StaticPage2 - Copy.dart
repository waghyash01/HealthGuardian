import 'package:flutter/material.dart';
//import 'package:healthapp/StaticPage3.dart';

import 'StaticPage3.dart';

class Static2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffCCCDCC),
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
            SizedBox(height: 15),
            PrivacyContainer(
              imagePath: 'assets/images/a1aes.jpg',
              text:
              "All your data is safeguarded with 256-bit encryption. HealthGuardian employs top-tier security standards to protect your information, ensuring it remains secure.",
            ),
            SizedBox(height: 15),
            PrivacyContainer(
              imagePath: 'assets/images/a2sec.jpg',
              text:
              "With HealthGuardian, your privacy is paramount. We never compromise on safeguarding your health data, ensuring it remains confidential and secure.",
            ),
            SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Static3()),
                );
              },
              child: Icon(
                Icons.arrow_forward,
                size: 50,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}





