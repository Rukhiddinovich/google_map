class LocationUserModelFields{
  static const String id="id";
  static const String lat="lat";
  static const String long="long";
  static const String city="city";
  static const String created="created";

  static const String userLocationTable = "userLocationTable";
}

class LocationUserModel {
  int? id;
  double lat;
  double long;
  String city;
  String created;


  LocationUserModel({
    this.id,
    required this.lat,
    required this.long,
    required this.city,
    required this.created,

  });

  LocationUserModel copyWith({
    String? created,
    String? city,
    double? long,
    double? lat,
    int? id,
  }) {
    return LocationUserModel(
      lat: lat ?? this.lat,
      long: long ?? this.long,
      city: city ?? this.city,
      created: created ?? this.created,
      id: id ?? this.id,
    );
  }

  factory LocationUserModel.fromJson(Map<String, dynamic> jsonData) {
    return LocationUserModel(
      id: jsonData[LocationUserModelFields.id] ?? 0,
      lat: jsonData['lat'] as double? ?? 0.0,
      long: jsonData['long'] as double? ?? 0.0,
      city: jsonData['city'] as String? ?? '',
      created: jsonData['created'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'long': long,
      'city': city,
      'created': created,
    };
  }

  @override
  String toString() {
    return ''''
       lat : $lat,
       long : $long,
       city : $city,
       created : $created,
       id: $id, 
      ''';
  }
}