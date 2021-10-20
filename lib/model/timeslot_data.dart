/// status : true
/// timeslot : {"day":"2","start_time":"10:15","end_time":"22:30","venue_id":"1","no_slot":"10","price":"2000","id":4}
/// timeslots : [{"id":1,"day":"1","start_time":"09:15:00","end_time":"21:00:00","created_at":"2021-10-20 07:39:17","venue_id":"1","no_slot":"20","price":"500"},{"id":4,"day":"2","start_time":"10:15:00","end_time":"22:30:00","created_at":"2021-10-20 09:26:50","venue_id":"1","no_slot":"10","price":"2000"}]

class TimeslotData {
  TimeslotData({
    bool? status,
    Timeslot? timeslot,
    List<Timeslot>? timeslots,
  }) {
    _status = status;
    _timeslot = timeslot;
    _timeslots = timeslots;
  }

  TimeslotData.fromJson(dynamic json) {
    _status = json['status'];
    _timeslot =
        json['timeslot'] != null ? Timeslot.fromJson(json['timeslot']) : null;
    if (json['timeslots'] != null) {
      _timeslots = [];
      json['timeslots'].forEach((v) {
        _timeslots?.add(Timeslot.fromJson(v));
      });
    }
  }
  bool? _status;
  Timeslot? _timeslot;
  List<Timeslot>? _timeslots;

  bool? get status => _status;
  Timeslot? get timeslot => _timeslot;
  List<Timeslot>? get timeslots => _timeslots;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_timeslot != null) {
      map['timeslot'] = _timeslot?.toJson();
    }
    if (_timeslots != null) {
      map['timeslots'] = _timeslots?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1
/// day : "1"
/// start_time : "09:15:00"
/// end_time : "21:00:00"
/// created_at : "2021-10-20 07:39:17"
/// venue_id : "1"
/// no_slot : "20"
/// price : "500"
//
// class Timeslots {
//   Timeslots({
//     int? id,
//     String? day,
//     String? startTime,
//     String? endTime,
//     String? createdAt,
//     String? venueId,
//     String? noSlot,
//     String? price,
//   }) {
//     _id = id;
//     _day = day;
//     _startTime = startTime;
//     _endTime = endTime;
//     _createdAt = createdAt;
//     _venueId = venueId;
//     _noSlot = noSlot;
//     _price = price;
//   }
//
//   Timeslots.fromJson(dynamic json) {
//     _id = json['id'];
//     _day = json['day'];
//     _startTime = json['start_time'];
//     _endTime = json['end_time'];
//     _createdAt = json['created_at'];
//     _venueId = json['venue_id'];
//     _noSlot = json['no_slot'];
//     _price = json['price'];
//   }
//   int? _id;
//   String? _day;
//   String? _startTime;
//   String? _endTime;
//   String? _createdAt;
//   String? _venueId;
//   String? _noSlot;
//   String? _price;
//
//   int? get id => _id;
//   String? get day => _day;
//   String? get startTime => _startTime;
//   String? get endTime => _endTime;
//   String? get createdAt => _createdAt;
//   String? get venueId => _venueId;
//   String? get noSlot => _noSlot;
//   String? get price => _price;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['day'] = _day;
//     map['start_time'] = _startTime;
//     map['end_time'] = _endTime;
//     map['created_at'] = _createdAt;
//     map['venue_id'] = _venueId;
//     map['no_slot'] = _noSlot;
//     map['price'] = _price;
//     return map;
//   }
// }

/// day : "2"
/// start_time : "10:15"
/// end_time : "22:30"
/// venue_id : "1"
/// no_slot : "10"
/// price : "2000"
/// id : 4

class Timeslot {
  Timeslot({
    String? day,
    String? startTime,
    String? endTime,
    String? venueId,
    String? noSlot,
    String? price,
    int? id,
  }) {
    _day = day;
    _startTime = startTime;
    _endTime = endTime;
    _venueId = venueId;
    _noSlot = noSlot;
    _price = price;
    _id = id;
  }

  Timeslot.fromJson(dynamic json) {
    _day = json['day'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _venueId = json['venue_id'];
    _noSlot = json['no_slot'];
    _price = json['price'];
    _id = json['id'];
  }
  String? _day;
  String? _startTime;
  String? _endTime;
  String? _venueId;
  String? _noSlot;
  String? _price;
  int? _id;

  String? get day => _day;
  String? get startTime => _startTime;
  String? get endTime => _endTime;
  String? get venueId => _venueId;
  String? get noSlot => _noSlot;
  String? get price => _price;
  int? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['day'] = _day;
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    map['venue_id'] = _venueId;
    map['no_slot'] = _noSlot;
    map['price'] = _price;
    map['id'] = _id;
    return map;
  }

  set id(int? value) {
    _id = value;
  }

  set price(String? value) {
    _price = value;
  }

  set noSlot(String? value) {
    _noSlot = value;
  }

  set venueId(String? value) {
    _venueId = value;
  }

  set endTime(String? value) {
    _endTime = value;
  }

  set startTime(String? value) {
    _startTime = value;
  }

  set day(String? value) {
    _day = value;
  }
}
