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
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchLocation();
  }

  Future<void> _fetchLocation() async {
    setState(() => _isLoading = true);

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) throw 'Location services are disabled.';

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) throw 'Permission denied.';
      }
      if (permission == LocationPermission.deniedForever) {
        throw 'Permissions permanently denied.';
      }

      Position? position = await Geolocator.getLastKnownPosition();
      position ??= await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
        timeLimit: const Duration(seconds: 5),
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String city =
            place.locality ?? place.subAdministrativeArea ?? 'Unknown';
        String country = place.country ?? 'Country';
        _updateState('$city, $country');
      }
    } catch (e) {
      _updateState('Location not found. Tap to retry.');
    }
  }

  void _updateState(String newLocation) {
    if (mounted) {
      setState(() {
        _currentLocation = newLocation;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          30,
          MediaQuery.of(context).size.height * 0.05,
          30,
          MediaQuery.of(context).size.height * 0.05,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image(
                  height: MediaQuery.of(context).size.height * 0.05,
                  image: const AssetImage("imgs/logo.png"),
                  errorBuilder: (c, o, s) =>
                      const Icon(Icons.public, color: Color(0xff02A95C)),
                ),
                const Text(
                  "Location",
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700,
                    color: Color(0xff333333),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Confirm your location",
                  style: TextStyle(
                    fontSize: 27,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w900,
                    color: Color(0xff333333),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "We need to know where you are funding from",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w900,
                    color: Color(0xff767676),
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: _fetchLocation,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey, width: 2),
                ),
                child: Row(
                  children: [
                    _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Color(0xff02A95C),
                            ),
                          )
                        : const Icon(
                            Icons.location_on,
                            color: Color(0xff02A95C),
                          ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Text(
                        _currentLocation,
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: "Poppins",
                          color: Color(0xff333333),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _isLoading || _currentLocation.contains("not found")
                    ? null
                    : () {
                        Navigator.pop(context, _currentLocation);
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff02A95C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  "Confirm",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(home: LocationDetector()));
}
