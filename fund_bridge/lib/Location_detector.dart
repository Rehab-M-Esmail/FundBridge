import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationDetector extends StatefulWidget {
  const LocationDetector({super.key});

  @override
  State<LocationDetector> createState() => _LocationDetectorState();
}

class _LocationDetectorState extends State<LocationDetector> {
  String _currentLocation = 'Fetching location...';

  @override
  void initState() {
    super.initState();
    _fetchLocation();
  }

  Future<void> _fetchLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _updateLocationState('Location services are disabled.');
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _updateLocationState('Location permissions denied.');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _updateLocationState(
        'Location permissions permanently denied. Enable in settings.',
      );
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
      );

      // 4. Convert Coordinates to Address
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String city =
            place.locality ?? place.subAdministrativeArea ?? 'Unknown City';
        String country = place.country ?? 'Unknown Country';
        _updateLocationState('$city, $country');
      } else {
        _updateLocationState('Could not reverse geocode coordinates.');
      }
    } catch (e) {
      _updateLocationState('Error: $e');
    }
  }

  void _updateLocationState(String newLocation) {
    if (mounted) {
      setState(() {
        _currentLocation = newLocation;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.location_on,
          size: 18,
          color: Color.fromARGB(255, 44, 163, 70),
        ),
        const SizedBox(width: 6),
        Text(
          _currentLocation,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 86, 142, 84),
          ),
        ),
      ],
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Funding App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green, useMaterial3: true),
      home: const LocationDetector(),
    );
  }
}
