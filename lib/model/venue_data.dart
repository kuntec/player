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
    String? sportId,
    String? members,
    String? onwards,
    String? ownerName,
    String? ownerNumber,
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
    _sportId = sportId;
    _members = members;
    _onwards = onwards;
    _ownerName = ownerName;
    _ownerNumber = ownerNumber;
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
    _sportId = json['sport_id'];
    _members = json['members'];
    _onwards = json['onwards'];
    _ownerName = json['owner_name'];
    _ownerNumber = json['owner_number'];
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
  String? _sportId;
  String? _members;
  String? _onwards;
  String? _ownerName;
  String? _ownerNumber;
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
  String? get sportId => _sportId;
  String? get members => _members;
  String? get onwards => _onwards;
  String? get ownerName => _ownerName;
  String? get ownerNumber => _ownerNumber;
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
    map['sport_id'] = _sportId;
    map['members'] = _members;
    map['onwards'] = _onwards;
    map['owner_name'] = _ownerName;
    map['owner_number'] = _ownerNumber;

    map['id'] = _id;
    return map;
  }

  set onwards(value) {
    _onwards = value;
  }

  set id(value) {
    _id = value;
  }

  set image(value) {
    _image = value;
  }

  set createdAt(value) {
    _createdAt = value;
  }

  set locationLink(value) {
    _locationLink = value;
  }

  set locationId(value) {
    _locationId = value;
  }

  set playerId(value) {
    _playerId = value;
  }

  set facilities(value) {
    _facilities = value;
  }

  set sport(value) {
    _sport = value;
  }

  set city(value) {
    _city = value;
  }

  set closeTime(value) {
    _closeTime = value;
  }

  set openTime(value) {
    _openTime = value;
  }

  set address(value) {
    _address = value;
  }

  set description(value) {
    _description = value;
  }

  set name(value) {
    _name = value;
  }

  set sportId(value) {
    _sportId = value;
  }

  set members(value) {
    _members = value;
  }

  set ownerNumber(value) {
    _ownerNumber = value;
  }

  set ownerName(value) {
    _ownerName = value;
  }
}
