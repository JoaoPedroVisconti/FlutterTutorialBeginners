import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // Location name for the UI
  String time; // Time in that location
  String flag; // URL to an flag icon
  String url; // URL for the API endpoint
  bool isDaytime; // True or false if is day time or not

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      // Make the request
      Response response =
          await get('http://worldtimeapi.org/api/timezone/$url');

      Map data = jsonDecode(response.body);
      print(data);

      // Get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(0, 3);
      // print(datetime);
      // print(offset);

      // Create a dateTime object
      DateTime now = DateTime.parse(datetime);
      // print(now);
      now = now.add(Duration(hours: int.parse(offset)));

      // Set the time property
      isDaytime = now.hour > 6 && now.hour < 19 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (err) {
      print('Caught Error: $err');
      time = 'Could not get the Data';
    }
  }
}
