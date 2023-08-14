import 'package:flutter/cupertino.dart';
import '../data/models/user_model.dart';
import '../local/db/local_database.dart';

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