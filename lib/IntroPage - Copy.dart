import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'StaticPage2 - Copy.dart';
class ImageWithTaglinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff90ee90), // Set background color
      appBar: AppBar(
        title: Text(''), // Empty title
        backgroundColor: Colors.transparent, // Make app bar transparent
        elevation: 0, // Remove app bar shadow
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo or image
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60), // Add border radius
                color: Colors.white, // Set container background color
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Add shadow color
                    spreadRadius: 8, // Set spread radius
                    blurRadius: 10, // Set blur radius
                    offset: Offset(0, 3), // Offset of shadow
                  ),
                ],
              ),
              padding: EdgeInsets.all(20), // Add padding to container
              child: ElevatedButton(

                onPressed: () {  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Static2()),
                ); },
                child: Image.asset(
                  'assets/images/assetlogo.jpg', // Replace 'your_image.png' with your image asset path
                  width: 300, // Adjust width as needed
                  height: 300, // Adjust height as needed
                ),
              ),
            ),
            SizedBox(height: 20), // Add some spacing
            // Tagline text
            Text(
              'Your Health, Our Priority \n  Your Data, Our Responsibility',
              textAlign: TextAlign.center, // Center align text
              style:TextStyle(
                fontWeight: FontWeight.bold,
                //textStyle: const TextStyle(color: Color(0XFF2F2E40)),
                fontSize: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
