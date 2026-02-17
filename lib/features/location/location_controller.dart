import 'package:flutter/material.dart';
import '../../helpers/permission_helper.dart';

class LocationController extends ChangeNotifier {
  String? _currentLocation;
  bool _isLoading = false;

  String? get currentLocation => _currentLocation;
  bool get isLoading => _isLoading;

  Future<void> getLocation(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final location = await PermissionHelper.getCurrentLocation(context);

    _currentLocation = location;
    _isLoading = false;
    notifyListeners();
  }
}