/// status : true
/// sports : [{"id":41,"player_id":"9","sport_id":"4","created_at":"18-10-2021","sport_name":"Tennis"},{"id":40,"player_id":"9","sport_id":"5","created_at":"18-10-2021","sport_name":"Cricket"}]

class MySport {
  MySport({
    bool? status,
    List<Sports>? sports,
  }) {
    _status = status;
    _sports = sports;
  }

  MySport.fromJson(dynamic json) {
    _status = json['status'];
    if (json['sports'] != null) {
      _sports = [];
      json['sports'].forEach((v) {
        _sports?.add(Sports.fromJson(v));
      });
    }
  }
  bool? _status;
  List<Sports>? _sports;

  bool? get status => _status;
  List<Sports>? get sports => _sports;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_sports != null) {
      map['sports'] = _sports?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 41
/// player_id : "9"
/// sport_id : "4"
/// created_at : "18-10-2021"
/// sport_name : "Tennis"

class Sports {
  Sports({
    int? id,
    String? playerId,
    String? sportId,
    String? createdAt,
    String? sportName,
  }) {
    _id = id;
    _playerId = playerId;
    _sportId = sportId;
    _createdAt = createdAt;
    _sportName = sportName;
  }

  Sports.fromJson(dynamic json) {
    _id = json['id'];
    _playerId = json['player_id'];
    _sportId = json['sport_id'];
    _createdAt = json['created_at'];
    _sportName = json['sport_name'];
  }
  int? _id;
  String? _playerId;
  String? _sportId;
  String? _createdAt;
  String? _sportName;

  int? get id => _id;
  String? get playerId => _playerId;
  String? get sportId => _sportId;
  String? get createdAt => _createdAt;
  String? get sportName => _sportName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['player_id'] = _playerId;
    map['sport_id'] = _sportId;
    map['created_at'] = _createdAt;
    map['sport_name'] = _sportName;
    return map;
  }

  set sportName(String? value) {
    _sportName = value;
  }

  set createdAt(String? value) {
    _createdAt = value;
  }

  set sportId(String? value) {
    _sportId = value;
  }

  set playerId(String? value) {
    _playerId = value;
  }

  set id(int? value) {
    _id = value;
  }
}
