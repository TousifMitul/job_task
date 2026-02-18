import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';

class PermissionHelper {
  static Future<String?> getCurrentLocation(BuildContext context) async {
    try {
      // First check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _showDialog(
          context,
          'Location Services Disabled',
          'Please enable location services to use this feature.',
        );
        return null;
      }

      // Check and request permissions
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _showDialog(
            context,
            'Permission Denied',
            'Location permission is required to set your travel location.',
          );
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _showSettingsDialog(context);
        return null;
      }

      // Get the current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );

      // Get address from coordinates
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String location = '';

        if (place.locality != null && place.locality!.isNotEmpty) {
          location += place.locality!;
        } else if (place.subAdministrativeArea != null) {
          location += place.subAdministrativeArea!;
        }

        if (place.country != null && place.country!.isNotEmpty) {
          location += location.isEmpty ? place.country! : ', ${place.country!}';
        }

        return location.isEmpty ? 'Unknown Location' : location;
      }
    } catch (e) {
      debugPrint('Error getting location: $e');
      _showDialog(
        context,
        'Error',
        'Failed to get your location. Please try again.',
      );
    }
    return null;
  }

  static void _showDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  static void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Location Permission Required'),
        content: const Text(
            'Location permission is permanently denied. Please enable it in app settings.'
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Geolocator.openAppSettings();
              Navigator.pop(context);
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }
}