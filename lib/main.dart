import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:weathercastapp/locationfinder.dart';
import 'package:weathercastapp/screens/homescreen.dart';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark(),
        home: SafeArea(
          child: navigation(),
        ));
  }
}

class navigation extends StatefulWidget {
  const navigation({Key? key}) : super(key: key);

  @override
  _navigationState createState() => _navigationState();
}

class _navigationState extends State<navigation> {
  late double longitude;
  late double latitude;
  late String city = '';
  @override
  void initState() {
    mylocation();
    // TODO: implement initState
    super.initState();
  }

  void mylocation() async {
    try {
      location locations = location();
      await locations.getlocation();
      latitude = locations.thelatitude;
      longitude = locations.thelongitude;
      gethttp();
    } catch (e) {
      location locations = location();
      await locations.getlocation();
      latitude = locations.thelatitude;
      longitude = locations.thelongitude;
      gethttp();
    }
  }

  void gethttp() async {
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=6b372aed871c089c9bd949ff466bdf60&units=metric');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return HomeScreen(
          locationweather: data,
        );
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitFoldingCube(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}
