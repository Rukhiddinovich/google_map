import 'package:flutter/material.dart';
import '../data/models/map/map_model.dart';
import '../data/network/api_repository.dart';

class AddressProvider extends ChangeNotifier {
  List<Address> _addresses = [];
  bool savedAddressCondition = false;

  List<Address> get addresses => _addresses;

  AddressProvider() {
    DatabaseHelper.initializeDatabase().then((_) {
      loadAddresses();
    });
  }

  Future<void> loadAddresses() async {
    _addresses = await DatabaseHelper.getAddresses();
    _addresses.isEmpty
        ? savedAddressCondition = false
        : savedAddressCondition = true;
    notifyListeners();
  }

  Future<void> addAddress(Address address) async {
    await DatabaseHelper.insertAddress(address);
    await loadAddresses();
  }

  Future<void> deleteAddress(int index) async {
    final addressToDelete = _addresses[index];
    await DatabaseHelper.deleteAddress(addressToDelete.id);
    await loadAddresses();
  }

  Future<void> deleteAllAddresses() async {
    await DatabaseHelper.deleteAllAddresses();
    await loadAddresses();
  }
}
