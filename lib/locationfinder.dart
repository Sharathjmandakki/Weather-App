import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import 'package:permission_handler/permission_handler.dart';
import 'package:weathercastapp/main.dart';

class location {
  late double thelatitude;
  late double thelongitude;

  Future<void> getlocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      thelatitude = position.latitude;
      thelongitude = position.longitude;
    } catch (e) {
      if (await Permission.location.request().isGranted) {
        Map<Permission, PermissionStatus> statuses = await [
          Permission.location,
        ].request();
      }
    }
  }

  Future<String> bycity(typedname) async {
    String cityname = typedname;
    if (cityname == '') {
      var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?q=hamsabhavi&appid=6b372aed871c089c9bd949ff466bdf60&units=metric',
      );
      http.Response response = await http.get(url);
      String data = response.body;
      return data;
    } else {
      var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?q=$cityname&appid=6b372aed871c089c9bd949ff466bdf60&units=metric',
      );
      http.Response response = await http.get(url);
      String data = response.body;
      return data;
    }
  }
}
