import 'package:flutter/cupertino.dart';
import 'package:google_map/provider/user_provider.dart';
import '../data/models/user_model.dart';

class UserLocationsProvider with ChangeNotifier {
  List<UserAddress> addresses = [];

  UserLocationsProvider() {
    getUserAddresses();
  }

  getUserAddresses() async {
    addresses = await LocalDatabase.getAllUserAddresses();
    print("CURRENT LENGTH:${addresses.length}");
    notifyListeners();
  }

  insertUserAddress(UserAddress userAddress) async {
    await LocalDatabase.insertUserAddress(userAddress);
    getUserAddresses();
  }

  deleteUserAddress(int id) async {
    await LocalDatabase.deleteUserAddress(id);
    getUserAddresses();
  }
}