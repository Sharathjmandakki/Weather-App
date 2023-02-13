import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weathercastapp/screens/info.dart';
// import 'dart:html' as html;

class searchBycity extends StatefulWidget {
  const searchBycity({Key? key}) : super(key: key);

  @override
  State<searchBycity> createState() => _searchBycityState();
}

class _searchBycityState extends State<searchBycity> {
  String cityname = '';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/city.jpeg'), fit: BoxFit.cover),
            ),
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        CupertinoIcons.back,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return info();
                        }));
                      },
                      icon: Icon(
                        CupertinoIcons.person_fill,
                        size: 40,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                TextField(
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'enter the city name',
                    hintStyle: TextStyle(color: Colors.black),
                    icon: Icon(
                      Icons.location_city,
                      color: Colors.white,
                    ),
                  ),
                  controller: null,
                  onChanged: (value) {
                    cityname = value;
                  },
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context, cityname);
                    },
                    child: Text(
                      "get weather",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
