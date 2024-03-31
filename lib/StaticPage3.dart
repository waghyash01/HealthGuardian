import 'package:flutter/material.dart';

import 'StaticPage4.dart';
//import 'package:healthapp/StaticPage4.dart';

class Static3 extends StatelessWidget {
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
              imagePath: 'assets/images/img_5.png',
              text:
               "We never sell your data to anyone, as we prioritize your privacy and take data protection very seriously.",
            ),
            SizedBox(height: 25),
            PrivacyContainer(
              imagePath: 'assets/images/img_4.png',
              text:
              "Your information shared on HealthGuardian remains confidential. Only you have access to it, and you have full control over who can view it.",
            ),
            SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Static4()),
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

class PrivacyContainer extends StatelessWidget {
  final String imagePath;
  final String text;

  const PrivacyContainer({
    required this.imagePath,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(65),
        color: Color(0xFFC5E1A5),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(1),
            spreadRadius: 3,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Image.asset(
            imagePath,
            width: 150,
            height: 150,
          ),
          SizedBox(height: 10),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Page'),
      ),
      body: Center(
        child: Text('This is the next page.'),
      ),
    );
  }
}

