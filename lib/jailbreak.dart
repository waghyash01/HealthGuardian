import 'package:flutter/material.dart';

class JailbreakDetectedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jailbreak Detected'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.warning,
              size: 100,
              color: Colors.red,
            ),
            SizedBox(height: 20),
            Text(
              'Jailbroken/Rooted Device Detected',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement any action you want to perform
                // when jailbreak is detected, such as logging out
                // or restricting access to certain features.
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
