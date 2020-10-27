import 'package:flutter/material.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  void getData() async {
    // Simulate request for a username
    String username = await Future.delayed(Duration(seconds: 3), () {
      return 'Yoshi';
    });

    // Simulate request for a bio using the username
    String bio = await Future.delayed(Duration(seconds: 1), () {
      return 'Vegan, Musitcian and Egg Collector';
    });

    print('$username - $bio');
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Choose a Location'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Text('Choose Location Screen'),
    );
  }
}
