import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:fund_bridge/reusable-widgets/longButton.dart';

class LocationDetector extends StatefulWidget {
  const LocationDetector({super.key});

  @override
  State<LocationDetector> createState() => _LocationDetectorState();
}

class _LocationDetectorState extends State<LocationDetector> {
  String _currentLocation = 'Initializing...';
  bool _isLoading = true;
  String? _errorMsg;

  @override
  void initState() {
    super.initState();
    _fetchLocation();
  }

  Future<void> _fetchLocation() async {
    setState(() {
      _isLoading = true;
      _errorMsg = null;
      _currentLocation = "Fetching location...";
    });

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _updateErrorState('Location services are disabled.');
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _updateErrorState('Location permissions denied.');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _updateErrorState(
        'Location permissions permanently denied. Enable in settings.',
      );
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String city =
            place.locality ?? place.subAdministrativeArea ?? 'Unknown City';
        String country = place.country ?? 'Unknown Country';
        _updateSuccessState('$city, $country');
      } else {
        _updateErrorState('Could not find address.');
      }
    } catch (e) {
      _updateErrorState('Error: $e');
    }
  }

  void _updateSuccessState(String newLocation) {
    if (mounted) {
      setState(() {
        _currentLocation = newLocation;
        _isLoading = false;
      });
    }
  }

  void _updateErrorState(String error) {
    if (mounted) {
      setState(() {
        _errorMsg = error;
        _currentLocation = "Location not found";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determine screen height for responsive padding
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          30,
          screenHeight * 0.05,
          30,
          screenHeight * 0.05,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Header Section (Logo + Step) ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image(
                  height: screenHeight * 0.05,
                  // Ensure this path exists or remove this line
                  image: AssetImage("imgs/logo.png"),
                  errorBuilder: (c, o, s) =>
                      Icon(Icons.public, color: Color(0xff02A95C), size: 40),
                ),
                // You can remove this or change "Done" if it's not a step
                Text(
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

            Spacer(flex: 1),

            // --- Title Section ---
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
              "We need to know where you are funding from.",
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Poppins",
                fontWeight:
                    FontWeight.w900, // Matching your previous subtitle weight
                color: Color(0xff767676),
              ),
            ),

            SizedBox(height: 30),

            // --- Location Display Box (Styled like TextFormField) ---
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  // Turn border red if error, Green if success/loading
                  color: _errorMsg != null ? Colors.red : Color(0xff02A95C),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  _isLoading
                      ? SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Color(0xff02A95C),
                          ),
                        )
                      : Icon(
                          _errorMsg != null
                              ? Icons.error_outline
                              : Icons.location_on,
                          color: _errorMsg != null
                              ? Colors.red
                              : Color(0xff02A95C),
                          size: 28,
                        ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      _errorMsg ?? _currentLocation,
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                        color: Color(0xff333333),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Show retry button only if there is an error
            if (_errorMsg != null) ...[
              SizedBox(height: 10),
              TextButton.icon(
                onPressed: _fetchLocation,
                icon: Icon(Icons.refresh, color: Color(0xff02A95C)),
                label: Text(
                  "Try Again",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    color: Color(0xff02A95C),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],

            Spacer(flex: 3),

            // --- Action Button ---
            // Replaced LongButton with a standard styled button
            // in case the import is missing, otherwise uncomment LongButton
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _isLoading || _errorMsg != null
                    ? null
                    : () {
                        // Handle confirmation logic here
                        Navigator.pop(context, _currentLocation);
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff02A95C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  "Confirm Location",
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
