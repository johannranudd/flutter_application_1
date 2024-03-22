import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_application_1/services/weather_service.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  String locationMessage = "Current location of the user";
  String weatherInfo = "Press the button to fetch weather data";
  bool isLocationFetched = false;

  String uvIndex = "";
  late String lat;
  late String long;

  void _fetchWeather() async {
    if (!isLocationFetched || lat.isEmpty || long.isEmpty) {
      setState(() {
        weatherInfo =
            "Location not available. Please fetch the location first.";
      });
      return;
    }

    try {
      final weatherData = await WeatherService.fetchWeather(lat, long);
      setState(() {
        weatherInfo =
            "Temp: ${weatherData.tempC}°C, Description: ${weatherData.weatherDescription}";
        uvIndex = "UV Index: ${weatherData.uvIndex}";
      });
    } catch (error) {
      setState(() {
        weatherInfo = "Failed to fetch weather data: $error";
      });
      debugPrint("Failed to fetch weather data: $error");
    }
  }

  // Getting the current location
  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location services are disabled");
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permissions are denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          "Location permissions are permanently denied, we cannot request data");
    }

    return await Geolocator.getCurrentPosition();
  }

  void _liveLocation() {
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      lat = position.latitude.toString();
      long = position.longitude.toString();

      setState(() {
        locationMessage = 'Latitude: $lat , Longitude: $long';
      });
    });
  }

  Future<void> _openMap(String lat, String long) async {
    final Uri googleURL =
        Uri.parse("https://www.google.com/maps/search/?api=1&query=$lat,$long");
    if (!await launchUrl(googleURL)) {
      throw 'Could not launch $googleURL';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(locationMessage, textAlign: TextAlign.center),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _getCurrentLocation().then((value) {
                lat = '${value.latitude}';
                long = '${value.longitude}';
                setState(() {
                  locationMessage = 'Latitude: $lat , Longitude: $long';
                  isLocationFetched = true;
                });
                _liveLocation();
              });
            },
            child: const Text("get current location"),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _openMap(lat, long);
            },
            child: const Text("Open Google Map"),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: isLocationFetched
                ? _fetchWeather
                : null, // Disable button if location not fetched
            child: const Text("Fetch Weather"),
          ),
          const SizedBox(height: 20),
          Column(
            children: [Text(weatherInfo), Text(uvIndex)],
          )
        ],
      )),
    );
  }
}
