import 'package:flutter/material.dart';



class MyAnalyticsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      routes: {
        '/details1': (context) => DetailsPage('Details 1'),
        '/details2': (context) => DetailsPage('Details 2'),
        '/details3': (context) => DetailsPage('Details 3'),
        '/details4': (context) => DetailsPage('Details 4'),
        '/details5': (context) => DetailsPage('Details 5'),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: const Color(0xff2F2E40),
        title: Text(
          "Analytics",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            //textStyle: const TextStyle(color: Colors.white),
            fontSize: 25,
          ),
        ),
      ),
      body: ListView(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/details1');
            },
            child: InfoCard('Card 1'),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/details2');
            },
            child: InfoCard('Card 2'),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/details3');
            },
            child: InfoCard('Card 3'),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/details4');
            },
            child: InfoCard('Card 4'),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/details5');
            },
            child: InfoCard('Card 5'),
          ),
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;

  InfoCard(this.title);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          title,
          style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  final String title;

  DetailsPage(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: const Color(0xff2F2E40),
        title: Text(title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 25,
          ),),
      ),
      body: Center(
        child: Text(
          'Details for $title',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
