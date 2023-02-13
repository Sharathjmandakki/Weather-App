import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:weathercastapp/locationfinder.dart';
import 'package:weathercastapp/main.dart';
import 'package:weathercastapp/screens/searchbycity.dart';
// import 'dart:html' as html;

class HomeScreen extends StatefulWidget {
  var locationweather;
  HomeScreen({this.locationweather});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Gradient() {
    return LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Colors.lightBlue,
          Colors.blueAccent,
          Colors.purpleAccent,
        ]);
  }

  late int tempinc;
  late String city;
  late double wind;
  late int preassure;
  late int humidity;
  late String date;
  late int t1, t2, t3, t4; //next 4*3 hours temp in c
  late String time0, time1, time2, time3, time4;
  late String condition0, condition1, condition2, condition3, condition4;
  late String dec;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateui(widget.locationweather);
  }

  void updateui(dynamic data) {
    location locations = location();
    setState(() {
      if (data == null) {
        tempinc = 0;
        city = "";
        wind = 0;
        preassure = 0;
        humidity = 0;
      }
      double temp = jsonDecode(data)['list'][0]['main']['temp'];
      tempinc = temp.toInt(); //list[0].main.temp
      city = jsonDecode(data)['city']['name']; //city.name
      wind = jsonDecode(data)['list'][0]['wind']['speed']; //list[0].wind.speed
      preassure = jsonDecode(data)['list'][0]['main']
          ['pressure']; //list[0].main.pressure
      humidity = jsonDecode(data)['list'][0]['main']
          ['humidity']; //list[0].main.humidity
      String datetime = jsonDecode(data)['list'][0]['dt_txt']; //list[0].dt_txt
      date = datetime.substring(0, 10);
      double temp1 = jsonDecode(data)['list'][1]['main']['temp'];
      t1 = temp1.toInt(); //list[0].main.temp
      double temp2 = jsonDecode(data)['list'][2]['main']['temp'];
      t2 = temp2.toInt();
      double temp3 = jsonDecode(data)['list'][3]['main']['temp'];
      t3 = temp3.toInt();
      double temp4 = jsonDecode(data)['list'][4]['main']['temp'];
      t4 = temp4.toInt();
      String timetime0 = jsonDecode(data)['list'][0]['dt_txt']; //list[0].dt_txt
      time0 = timetime0.substring(11, 16);
      String timetime1 = jsonDecode(data)['list'][1]['dt_txt']; //list[0].dt_txt
      time1 = timetime1.substring(11, 16);
      String timetime2 = jsonDecode(data)['list'][2]['dt_txt']; //list[0].dt_txt
      time2 = timetime2.substring(11, 16);
      String timetime3 = jsonDecode(data)['list'][3]['dt_txt']; //list[0].dt_txt
      time3 = timetime3.substring(11, 16);
      String timetime4 = jsonDecode(data)['list'][4]['dt_txt']; //list[0].dt_txt
      time4 = timetime4.substring(11, 16);
      condition0 = jsonDecode(data)['list'][0]['weather'][0]['icon'];
      condition1 = jsonDecode(data)['list'][1]['weather'][0]['icon'];
      condition2 = jsonDecode(data)['list'][2]['weather'][0]['icon'];
      condition3 = jsonDecode(data)['list'][3]['weather'][0]['icon'];
      condition4 = jsonDecode(data)['list'][4]['weather'][0]['icon'];
      //list[0].weather[0].icon
      dec = jsonDecode(data)['list'][0]['weather'][0]
          ['description']; //list[0].weather[0].description
    });
  }

  @override
  Widget build(BuildContext context) {
    location locations = location();
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 1.95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.blue,
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/background.jpeg',
                      ),
                      fit: BoxFit.cover),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "$date",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "$tempinc" + '°C \t',
                          style: TextStyle(
                            fontSize: 80,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.right,
                        ),
                        Text(
                          "in" + " $city\t",
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image(
                                image: NetworkImage(
                                    'http://openweathermap.org/img/w/' +
                                        condition0 +
                                        '.png',
                                    scale: 0.6)),
                            Text(
                              '$dec',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 5,
                    width: MediaQuery.of(context).size.width / 3.7,
                    margin: EdgeInsets.only(top: 6),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: Gradient()),
                        child: columns(
                            CupertinoIcons.wind, 'Wind', '$wind' + ' km/h')),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 5,
                    width: MediaQuery.of(context).size.width / 3.7,
                    margin: EdgeInsets.only(top: 6),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: Gradient()),
                        child: columns(Icons.thermostat_rounded, 'Preassure',
                            '$preassure' + ' MB')),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 5,
                    width: MediaQuery.of(context).size.width / 3.7,
                    margin: EdgeInsets.only(top: 6),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: Gradient()),
                        child: columns(CupertinoIcons.drop_fill, 'Humidity',
                            '$humidity' + '%')),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    temprows(
                        'Now',
                        'http://openweathermap.org/img/w/' +
                            condition0 +
                            '.png',
                        tempinc),
                    temprows(
                        '$time1',
                        'http://openweathermap.org/img/w/' +
                            condition1 +
                            '.png',
                        t1),
                    temprows(
                        '$time2',
                        'http://openweathermap.org/img/w/' +
                            condition2 +
                            '.png',
                        t2),
                    temprows(
                        '$time3',
                        'http://openweathermap.org/img/w/' +
                            condition3 +
                            '.png',
                        t3),
                    temprows(
                        '$time4',
                        'http://openweathermap.org/img/w/' +
                            condition4 +
                            '.png',
                        t4)
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.black),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextButton(
                          onLongPress: () async {
                            Navigator.pop(context);
                          },
                          onPressed: () async {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return navigation();
                            }));
                          },
                          child: Icon(
                            Icons.update,
                            size: 40,
                            semanticLabel: 'UPDATE',
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 0, left: 20),
                        child: TextButton(
                          onPressed: () async {
                            var typedname = await Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return searchBycity();
                            }));
                            if (typedname == null) {
                              tempinc = 0;
                              city = "";
                            } else {
                              var data = await locations.bycity(typedname);
                              updateui(data);
                            }
                          },
                          child: Icon(
                            Icons.location_city,
                            size: 40,
                            semanticLabel: 'SEARCH BY CITY',
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class columns extends StatelessWidget {
  columns(this.icons, this.text, this.data);
  var icons;
  var text;
  var data;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icons,
          size: 40,
        ),
        Text(
          '$text',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w200,
          ),
        ),
        Text(
          "$data ",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w200,
          ),
        ),
      ],
    );
  }
}

class temprows extends StatelessWidget {
  temprows(this.Htime, this.emoji, this.temp);
  var Htime;
  var temp;
  var emoji;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 9,
      width: MediaQuery.of(context).size.width / 6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '$Htime',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w200,
            ),
          ),
          Image(
            image: NetworkImage('$emoji', scale: 1.5),
          ),
          Text(
            "$temp" + '°C',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w200,
            ),
          ),
        ],
      ),
    );
  }
}
