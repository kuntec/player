/// status : true
/// daySlot : {"venue_id":"1","day":"2","open":"9:00","close":"12:00","status":"1","created_at":"22/10/2021","id":1}
/// dayslots : [{"id":1,"venue_id":"1","day":"2","open":"9:00","close":"12:00","status":"1","created_at":"22/10/2021"}]

class DayslotData {
  DayslotData({
    bool? status,
    DaySlot? daySlot,
    List<DaySlot>? daySlots,
  }) {
    _status = status;
    _daySlot = daySlot;
    _daySlots = daySlots;
  }

  DayslotData.fromJson(dynamic json) {
    _status = json['status'];
    _daySlot =
        json['daySlot'] != null ? DaySlot.fromJson(json['daySlot']) : null;
    if (json['daySlots'] != null) {
      _daySlots = [];
      json['daySlots'].forEach((v) {
        _daySlots?.add(DaySlot.fromJson(v));
      });
    }
  }
  bool? _status;
  DaySlot? _daySlot;
  List<DaySlot>? _daySlots;

  bool? get status => _status;
  DaySlot? get daySlot => _daySlot;
  List<DaySlot>? get daySlots => _daySlots;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_daySlot != null) {
      map['daySlot'] = _daySlot?.toJson();
    }
    if (_daySlots != null) {
      map['daySlots'] = _daySlots?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1
/// venue_id : "1"
/// day : "2"
/// open : "9:00"
/// close : "12:00"
/// status : "1"
/// created_at : "22/10/2021"

// class Dayslots {
//   Dayslots({
//     int? id,
//     String? venueId,
//     String? day,
//     String? open,
//     String? close,
//     String? status,
//     String? createdAt,
//   }) {
//     _id = id;
//     _venueId = venueId;
//     _day = day;
//     _open = open;
//     _close = close;
//     _status = status;
//     _createdAt = createdAt;
//   }
//
//   Dayslots.fromJson(dynamic json) {
//     _id = json['id'];
//     _venueId = json['venue_id'];
//     _day = json['day'];
//     _open = json['open'];
//     _close = json['close'];
//     _status = json['status'];
//     _createdAt = json['created_at'];
//   }
//   int? _id;
//   String? _venueId;
//   String? _day;
//   String? _open;
//   String? _close;
//   String? _status;
//   String? _createdAt;
//
//   int? get id => _id;
//   String? get venueId => _venueId;
//   String? get day => _day;
//   String? get open => _open;
//   String? get close => _close;
//   String? get status => _status;
//   String? get createdAt => _createdAt;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['venue_id'] = _venueId;
//     map['day'] = _day;
//     map['open'] = _open;
//     map['close'] = _close;
//     map['status'] = _status;
//     map['created_at'] = _createdAt;
//     return map;
//   }
// }

/// venue_id : "1"
/// day : "2"
/// open : "9:00"
/// close : "12:00"
/// status : "1"
/// created_at : "22/10/2021"
/// id : 1

class DaySlot {
  DaySlot({
    String? venueId,
    String? day,
    String? open,
    String? close,
    String? status,
    String? createdAt,
    int? id,
  }) {
    _venueId = venueId;
    _day = day;
    _open = open;
    _close = close;
    _status = status;
    _createdAt = createdAt;
    _id = id;
  }

  DaySlot.fromJson(dynamic json) {
    _venueId = json['venue_id'];
    _day = json['day'];
    _open = json['open'];
    _close = json['close'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _id = json['id'];
  }
  String? _venueId;
  String? _day;
  String? _open;
  String? _close;
  String? _status;
  String? _createdAt;
  int? _id;

  String? get venueId => _venueId;
  String? get day => _day;
  String? get open => _open;
  String? get close => _close;
  String? get status => _status;
  String? get createdAt => _createdAt;
  int? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['venue_id'] = _venueId;
    map['day'] = _day;
    map['open'] = _open;
    map['close'] = _close;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['id'] = _id;
    return map;
  }

  set id(int? value) {
    _id = value;
  }

  set createdAt(String? value) {
    _createdAt = value;
  }

  set status(String? value) {
    _status = value;
  }

  set close(String? value) {
    _close = value;
  }

  set open(String? value) {
    _open = value;
  }

  set day(String? value) {
    _day = value;
  }

  set venueId(String? value) {
    _venueId = value;
  }
}
