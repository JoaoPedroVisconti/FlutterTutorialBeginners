import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void getTime() async {
    // Make the request
    Response response =
        await get('http://worldtimeapi.org/api/timezone/Europe/Lisbon');

    Map data = jsonDecode(response.body);
    // print(data);

    // Get properties from data
    String datetime = data['datetime'];
    String offset = data['utc_offset'];
    print(datetime);
    print(offset);
  }

  @override
  void initState() {
    super.initState();
    getTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text('Loading Screen'));
  }
}
