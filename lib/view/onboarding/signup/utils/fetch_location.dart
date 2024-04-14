import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../utils/const/colors.dart';

class LocationFetcher {
  static void fetchLocation(BuildContext context) {
    // Implement your location fetching logic here
    // For example, you can use packages like geolocator or location to fetch the device's location
    // Once you have the location data, you can use it as needed
    // This is just a placeholder function
    log('Fetching location...');
  }
}

class LocationCaller extends StatelessWidget {
  const LocationCaller({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.0112,
          horizontal: MediaQuery.of(context).size.width * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Business Location'),
          SizedBox(
            height: height * 0.1,
            width: width * 0.9,
            child: InkWell(
              onTap: () {
                // Call the static method to fetch the location
                LocationFetcher.fetchLocation(context);
              },
              child: const Card(
                color: CustomColor.secondarybackgroundColor,
                child: Center(child: Text('Click to fetch location')),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
