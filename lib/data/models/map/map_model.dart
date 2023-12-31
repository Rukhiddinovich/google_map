class Location {
  final double latitude;
  final double longitude;

  Location({required this.latitude, required this.longitude});
}

class Address {
  final int id;
  final String name;
  final Location location;
  final String address;

  Address(
      {required this.address,
      required this.id,
      required this.name,
      required this.location});
}
