/// status : true
/// message : "Location Found"
/// location : [{"id":1,"name":"Vadodara","created_at":"2021-11-19 00:13:20"},{"id":2,"name":"Ahmedabad","created_at":"2021-11-19 00:13:20"},{"id":3,"name":"Anand","created_at":"2021-11-19 00:13:36"},{"id":4,"name":"Surat","created_at":"2021-11-19 00:13:36"}]

class LocationData {
  LocationData({
    bool? status,
    String? message,
    List<Location>? location,
  }) {
    _status = status;
    _message = message;
    _location = location;
  }

  LocationData.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['location'] != null) {
      _location = [];
      json['location'].forEach((v) {
        _location?.add(Location.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Location>? _location;

  bool? get status => _status;
  String? get message => _message;
  List<Location>? get location => _location;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_location != null) {
      map['location'] = _location?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1
/// name : "Vadodara"
/// created_at : "2021-11-19 00:13:20"

class Location {
  Location({
    int? id,
    String? name,
    String? createdAt,
  }) {
    _id = id;
    _name = name;
    _createdAt = createdAt;
  }

  Location.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _createdAt = json['created_at'];
  }
  int? _id;
  String? _name;
  String? _createdAt;

  int? get id => _id;
  String? get name => _name;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['created_at'] = _createdAt;
    return map;
  }
}
