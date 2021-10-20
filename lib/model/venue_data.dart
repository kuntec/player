/// status : true
/// message : "Venue Found"
/// venues : [{"id":6,"name":"Akota Stadium","description":"large stadium","open_time":"09:00","close_time":"10:00","address":"akota","city":"vadodara","sport":"cricket, football","player_id":"9","location_id":"1","image":"venues/su1KxS0bKqOl9pSXIRbRpVOXJvub7uCOfK21MHAZ.jpg","created_at":"25/11/21","facilities":"gym, parking","location_link":"linktext"}]
/// venue : {"name":"Akota Stadium","description":"large stadium","address":"akota","open_time":"09:00","close_time":"10:00","city":"vadodara","sport":"cricket, football","facilities":"gym, parking","player_id":"9","location_id":"1","location_link":"linktext","created_at":"25/11/21","image":"venues/su1KxS0bKqOl9pSXIRbRpVOXJvub7uCOfK21MHAZ.jpg","id":6}

class VenueData {
  VenueData({
    bool? status,
    String? message,
    List<Venue>? venues,
    Venue? venue,
  }) {
    _status = status;
    _message = message;
    _venues = venues;
    _venue = venue;
  }

  VenueData.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['venues'] != null) {
      _venues = [];
      json['venues'].forEach((v) {
        _venues?.add(Venue.fromJson(v));
      });
    }
    _venue = json['venue'] != null ? Venue.fromJson(json['venue']) : null;
  }
  bool? _status;
  String? _message;
  List<Venue>? _venues;
  Venue? _venue;

  bool? get status => _status;
  String? get message => _message;
  List<Venue>? get venues => _venues;
  Venue? get venue => _venue;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_venues != null) {
      map['venues'] = _venues?.map((v) => v.toJson()).toList();
    }
    if (_venue != null) {
      map['venue'] = _venue?.toJson();
    }
    return map;
  }
}

/// name : "Akota Stadium"
/// description : "large stadium"
/// address : "akota"
/// open_time : "09:00"
/// close_time : "10:00"
/// city : "vadodara"
/// sport : "cricket, football"
/// facilities : "gym, parking"
/// player_id : "9"
/// location_id : "1"
/// location_link : "linktext"
/// created_at : "25/11/21"
/// image : "venues/su1KxS0bKqOl9pSXIRbRpVOXJvub7uCOfK21MHAZ.jpg"
/// id : 6

class Venue {
  Venue({
    String? name,
    String? description,
    String? address,
    String? openTime,
    String? closeTime,
    String? city,
    String? sport,
    String? facilities,
    String? playerId,
    String? locationId,
    String? locationLink,
    String? createdAt,
    String? image,
    int? id,
  }) {
    _name = name;
    _description = description;
    _address = address;
    _openTime = openTime;
    _closeTime = closeTime;
    _city = city;
    _sport = sport;
    _facilities = facilities;
    _playerId = playerId;
    _locationId = locationId;
    _locationLink = locationLink;
    _createdAt = createdAt;
    _image = image;
    _id = id;
  }

  Venue.fromJson(dynamic json) {
    _name = json['name'];
    _description = json['description'];
    _address = json['address'];
    _openTime = json['open_time'];
    _closeTime = json['close_time'];
    _city = json['city'];
    _sport = json['sport'];
    _facilities = json['facilities'];
    _playerId = json['player_id'];
    _locationId = json['location_id'];
    _locationLink = json['location_link'];
    _createdAt = json['created_at'];
    _image = json['image'];
    _id = json['id'];
  }
  String? _name;
  String? _description;
  String? _address;
  String? _openTime;
  String? _closeTime;
  String? _city;
  String? _sport;
  String? _facilities;
  String? _playerId;
  String? _locationId;
  String? _locationLink;
  String? _createdAt;
  String? _image;
  int? _id;

  String? get name => _name;
  String? get description => _description;
  String? get address => _address;
  String? get openTime => _openTime;
  String? get closeTime => _closeTime;
  String? get city => _city;
  String? get sport => _sport;
  String? get facilities => _facilities;
  String? get playerId => _playerId;
  String? get locationId => _locationId;
  String? get locationLink => _locationLink;
  String? get createdAt => _createdAt;
  String? get image => _image;
  int? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['description'] = _description;
    map['address'] = _address;
    map['open_time'] = _openTime;
    map['close_time'] = _closeTime;
    map['city'] = _city;
    map['sport'] = _sport;
    map['facilities'] = _facilities;
    map['player_id'] = _playerId;
    map['location_id'] = _locationId;
    map['location_link'] = _locationLink;
    map['created_at'] = _createdAt;
    map['image'] = _image;
    map['id'] = _id;
    return map;
  }

  set id(int? value) {
    _id = value;
  }

  set image(String? value) {
    _image = value;
  }

  set createdAt(String? value) {
    _createdAt = value;
  }

  set locationLink(String? value) {
    _locationLink = value;
  }

  set locationId(String? value) {
    _locationId = value;
  }

  set playerId(String? value) {
    _playerId = value;
  }

  set facilities(String? value) {
    _facilities = value;
  }

  set sport(String? value) {
    _sport = value;
  }

  set city(String? value) {
    _city = value;
  }

  set closeTime(String? value) {
    _closeTime = value;
  }

  set openTime(String? value) {
    _openTime = value;
  }

  set address(String? value) {
    _address = value;
  }

  set description(String? value) {
    _description = value;
  }

  set name(String? value) {
    _name = value;
  }
}

/// id : 6
/// name : "Akota Stadium"
/// description : "large stadium"
/// open_time : "09:00"
/// close_time : "10:00"
/// address : "akota"
/// city : "vadodara"
/// sport : "cricket, football"
/// player_id : "9"
/// location_id : "1"
/// image : "venues/su1KxS0bKqOl9pSXIRbRpVOXJvub7uCOfK21MHAZ.jpg"
/// created_at : "25/11/21"
/// facilities : "gym, parking"
/// location_link : "linktext"
//
// class Venues {
//   Venues({
//     int? id,
//     String? name,
//     String? description,
//     String? openTime,
//     String? closeTime,
//     String? address,
//     String? city,
//     String? sport,
//     String? playerId,
//     String? locationId,
//     String? image,
//     String? createdAt,
//     String? facilities,
//     String? locationLink,
//   }) {
//     _id = id;
//     _name = name;
//     _description = description;
//     _openTime = openTime;
//     _closeTime = closeTime;
//     _address = address;
//     _city = city;
//     _sport = sport;
//     _playerId = playerId;
//     _locationId = locationId;
//     _image = image;
//     _createdAt = createdAt;
//     _facilities = facilities;
//     _locationLink = locationLink;
//   }
//
//   Venues.fromJson(dynamic json) {
//     _id = json['id'];
//     _name = json['name'];
//     _description = json['description'];
//     _openTime = json['open_time'];
//     _closeTime = json['close_time'];
//     _address = json['address'];
//     _city = json['city'];
//     _sport = json['sport'];
//     _playerId = json['player_id'];
//     _locationId = json['location_id'];
//     _image = json['image'];
//     _createdAt = json['created_at'];
//     _facilities = json['facilities'];
//     _locationLink = json['location_link'];
//   }
//   int? _id;
//   String? _name;
//   String? _description;
//   String? _openTime;
//   String? _closeTime;
//   String? _address;
//   String? _city;
//   String? _sport;
//   String? _playerId;
//   String? _locationId;
//   String? _image;
//   String? _createdAt;
//   String? _facilities;
//   String? _locationLink;
//
//   int? get id => _id;
//   String? get name => _name;
//   String? get description => _description;
//   String? get openTime => _openTime;
//   String? get closeTime => _closeTime;
//   String? get address => _address;
//   String? get city => _city;
//   String? get sport => _sport;
//   String? get playerId => _playerId;
//   String? get locationId => _locationId;
//   String? get image => _image;
//   String? get createdAt => _createdAt;
//   String? get facilities => _facilities;
//   String? get locationLink => _locationLink;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['name'] = _name;
//     map['description'] = _description;
//     map['open_time'] = _openTime;
//     map['close_time'] = _closeTime;
//     map['address'] = _address;
//     map['city'] = _city;
//     map['sport'] = _sport;
//     map['player_id'] = _playerId;
//     map['location_id'] = _locationId;
//     map['image'] = _image;
//     map['created_at'] = _createdAt;
//     map['facilities'] = _facilities;
//     map['location_link'] = _locationLink;
//     return map;
//   }
// }
