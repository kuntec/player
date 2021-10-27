/// status : true
/// message : "Event Added Successfully"
/// event : {"name":"league","description":"premier league","status":"1","created_at":"21-10-2021","address":"bandra","start_date":"21-10-2021","end_date":"21-10-2021","location_id":"1","type":"open","location_link":"link","start_time":"09:00","end_time":"18:00","entry_fees":"500","members":"5","details":"additional info","player_id":"9","image":"events/pZRHU5za8YhULiy0mEauc3hrh2IqfLK0aEIz9EyU.jpg","id":1}
/// events : [{"id":1,"name":"league","description":"premier league","status":"1","created_at":"21-10-2021","address":"bandra","start_date":"21-10-2021","end_date":"21-10-2021","location_id":"1","type":"open","image":"events/pZRHU5za8YhULiy0mEauc3hrh2IqfLK0aEIz9EyU.jpg","location_link":"link","start_time":"09:00","end_time":"18:00","entry_fees":"500","members":"5","details":"additional info","player_id":"9"}]

class EventData {
  EventData({
    bool? status,
    String? message,
    Event? event,
    List<Event>? events,
  }) {
    _status = status;
    _message = message;
    _event = event;
    _events = events;
  }

  EventData.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _event = json['event'] != null ? Event.fromJson(json['event']) : null;
    if (json['events'] != null) {
      _events = [];
      json['events'].forEach((v) {
        _events?.add(Event.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  Event? _event;
  List<Event>? _events;

  bool? get status => _status;
  String? get message => _message;
  Event? get event => _event;
  List<Event>? get events => _events;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_event != null) {
      map['event'] = _event?.toJson();
    }
    if (_events != null) {
      map['events'] = _events?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1
/// name : "league"
/// description : "premier league"
/// status : "1"
/// created_at : "21-10-2021"
/// address : "bandra"
/// start_date : "21-10-2021"
/// end_date : "21-10-2021"
/// location_id : "1"
/// type : "open"
/// image : "events/pZRHU5za8YhULiy0mEauc3hrh2IqfLK0aEIz9EyU.jpg"
/// location_link : "link"
/// start_time : "09:00"
/// end_time : "18:00"
/// entry_fees : "500"
/// members : "5"
/// details : "additional info"
/// player_id : "9"

// class Events {
//   Events({
//     int? id,
//     String? name,
//     String? description,
//     String? status,
//     String? createdAt,
//     String? address,
//     String? startDate,
//     String? endDate,
//     String? locationId,
//     String? type,
//     String? image,
//     String? locationLink,
//     String? startTime,
//     String? endTime,
//     String? entryFees,
//     String? members,
//     String? details,
//     String? playerId,
//   }) {
//     _id = id;
//     _name = name;
//     _description = description;
//     _status = status;
//     _createdAt = createdAt;
//     _address = address;
//     _startDate = startDate;
//     _endDate = endDate;
//     _locationId = locationId;
//     _type = type;
//     _image = image;
//     _locationLink = locationLink;
//     _startTime = startTime;
//     _endTime = endTime;
//     _entryFees = entryFees;
//     _members = members;
//     _details = details;
//     _playerId = playerId;
//   }
//
//   Events.fromJson(dynamic json) {
//     _id = json['id'];
//     _name = json['name'];
//     _description = json['description'];
//     _status = json['status'];
//     _createdAt = json['created_at'];
//     _address = json['address'];
//     _startDate = json['start_date'];
//     _endDate = json['end_date'];
//     _locationId = json['location_id'];
//     _type = json['type'];
//     _image = json['image'];
//     _locationLink = json['location_link'];
//     _startTime = json['start_time'];
//     _endTime = json['end_time'];
//     _entryFees = json['entry_fees'];
//     _members = json['members'];
//     _details = json['details'];
//     _playerId = json['player_id'];
//   }
//   int? _id;
//   String? _name;
//   String? _description;
//   String? _status;
//   String? _createdAt;
//   String? _address;
//   String? _startDate;
//   String? _endDate;
//   String? _locationId;
//   String? _type;
//   String? _image;
//   String? _locationLink;
//   String? _startTime;
//   String? _endTime;
//   String? _entryFees;
//   String? _members;
//   String? _details;
//   String? _playerId;
//
//   int? get id => _id;
//   String? get name => _name;
//   String? get description => _description;
//   String? get status => _status;
//   String? get createdAt => _createdAt;
//   String? get address => _address;
//   String? get startDate => _startDate;
//   String? get endDate => _endDate;
//   String? get locationId => _locationId;
//   String? get type => _type;
//   String? get image => _image;
//   String? get locationLink => _locationLink;
//   String? get startTime => _startTime;
//   String? get endTime => _endTime;
//   String? get entryFees => _entryFees;
//   String? get members => _members;
//   String? get details => _details;
//   String? get playerId => _playerId;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['name'] = _name;
//     map['description'] = _description;
//     map['status'] = _status;
//     map['created_at'] = _createdAt;
//     map['address'] = _address;
//     map['start_date'] = _startDate;
//     map['end_date'] = _endDate;
//     map['location_id'] = _locationId;
//     map['type'] = _type;
//     map['image'] = _image;
//     map['location_link'] = _locationLink;
//     map['start_time'] = _startTime;
//     map['end_time'] = _endTime;
//     map['entry_fees'] = _entryFees;
//     map['members'] = _members;
//     map['details'] = _details;
//     map['player_id'] = _playerId;
//     return map;
//   }
// }

/// name : "league"
/// description : "premier league"
/// status : "1"
/// created_at : "21-10-2021"
/// address : "bandra"
/// start_date : "21-10-2021"
/// end_date : "21-10-2021"
/// location_id : "1"
/// type : "open"
/// location_link : "link"
/// start_time : "09:00"
/// end_time : "18:00"
/// entry_fees : "500"
/// members : "5"
/// details : "additional info"
/// player_id : "9"
/// image : "events/pZRHU5za8YhULiy0mEauc3hrh2IqfLK0aEIz9EyU.jpg"
/// id : 1

class Event {
  Event({
    String? name,
    String? description,
    String? status,
    String? createdAt,
    String? address,
    String? startDate,
    String? endDate,
    String? locationId,
    String? type,
    String? locationLink,
    String? startTime,
    String? endTime,
    String? entryFees,
    String? members,
    String? details,
    String? playerId,
    String? image,
    String? organizerName,
    String? number,
    String? secondaryNumber,
    int? id,
  }) {
    _name = name;
    _description = description;
    _status = status;
    _createdAt = createdAt;
    _address = address;
    _startDate = startDate;
    _endDate = endDate;
    _locationId = locationId;
    _type = type;
    _locationLink = locationLink;
    _startTime = startTime;
    _endTime = endTime;
    _entryFees = entryFees;
    _members = members;
    _details = details;
    _playerId = playerId;
    _image = image;

    _organizerName = organizerName;
    _number = number;
    _secondaryNumber = secondaryNumber;
    _id = id;
  }

  Event.fromJson(dynamic json) {
    _name = json['name'];
    _description = json['description'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _address = json['address'];
    _startDate = json['start_date'];
    _endDate = json['end_date'];
    _locationId = json['location_id'];
    _type = json['type'];
    _locationLink = json['location_link'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _entryFees = json['entry_fees'];
    _members = json['members'];
    _details = json['details'];
    _playerId = json['player_id'];
    _image = json['image'];

    _organizerName = json['organizer_name'];
    _number = json['number'];
    _secondaryNumber = json['secondary_number'];

    _id = json['id'];
  }
  String? _name;
  String? _description;
  String? _status;
  String? _createdAt;
  String? _address;
  String? _startDate;
  String? _endDate;
  String? _locationId;
  String? _type;
  String? _locationLink;
  String? _startTime;
  String? _endTime;
  String? _entryFees;
  String? _members;
  String? _details;
  String? _playerId;
  String? _image;

  String? _organizerName;
  String? _number;
  String? _secondaryNumber;

  int? _id;

  String? get name => _name;
  String? get description => _description;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get address => _address;
  String? get startDate => _startDate;
  String? get endDate => _endDate;
  String? get locationId => _locationId;
  String? get type => _type;
  String? get locationLink => _locationLink;
  String? get startTime => _startTime;
  String? get endTime => _endTime;
  String? get entryFees => _entryFees;
  String? get members => _members;
  String? get details => _details;
  String? get playerId => _playerId;
  String? get image => _image;

  String? get organizerName => _organizerName;
  String? get number => _number;
  String? get secondaryNumber => _secondaryNumber;

  int? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['description'] = _description;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['address'] = _address;
    map['start_date'] = _startDate;
    map['end_date'] = _endDate;
    map['location_id'] = _locationId;
    map['type'] = _type;
    map['location_link'] = _locationLink;
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    map['entry_fees'] = _entryFees;
    map['members'] = _members;
    map['details'] = _details;
    map['player_id'] = _playerId;
    map['image'] = _image;

    map['organizer_name'] = _organizerName;
    map['number'] = _number;
    map['secondary_number'] = _secondaryNumber;

    map['id'] = _id;
    return map;
  }

  set id(int? value) {
    _id = value;
  }

  set image(String? value) {
    _image = value;
  }

  set playerId(String? value) {
    _playerId = value;
  }

  set details(String? value) {
    _details = value;
  }

  set members(String? value) {
    _members = value;
  }

  set entryFees(String? value) {
    _entryFees = value;
  }

  set endTime(String? value) {
    _endTime = value;
  }

  set startTime(String? value) {
    _startTime = value;
  }

  set locationLink(String? value) {
    _locationLink = value;
  }

  set type(String? value) {
    _type = value;
  }

  set locationId(String? value) {
    _locationId = value;
  }

  set endDate(String? value) {
    _endDate = value;
  }

  set startDate(String? value) {
    _startDate = value;
  }

  set address(String? value) {
    _address = value;
  }

  set createdAt(String? value) {
    _createdAt = value;
  }

  set status(String? value) {
    _status = value;
  }

  set description(String? value) {
    _description = value;
  }

  set name(String? value) {
    _name = value;
  }

  set secondaryNumber(String? value) {
    _secondaryNumber = value;
  }

  set number(String? value) {
    _number = value;
  }

  set organizerName(String? value) {
    _organizerName = value;
  }
}
