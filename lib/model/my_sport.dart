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
    String? sportIcon,
    String? activeIcon,
  }) {
    _id = id;
    _playerId = playerId;
    _sportId = sportId;
    _createdAt = createdAt;
    _sportName = sportName;
    _sportIcon = sportIcon;
    _activeIcon = activeIcon;
  }

  Sports.fromJson(dynamic json) {
    _id = json['id'];
    _playerId = json['player_id'];
    _sportId = json['sport_id'];
    _createdAt = json['created_at'];
    _sportName = json['sport_name'];
    _sportIcon = json['sport_icon'];
    _activeIcon = json['active_icon'];
  }
  int? _id;
  String? _playerId;
  String? _sportId;
  String? _createdAt;
  String? _sportName;
  String? _sportIcon;
  String? _activeIcon;

  int? get id => _id;
  String? get playerId => _playerId;
  String? get sportId => _sportId;
  String? get createdAt => _createdAt;
  String? get sportName => _sportName;
  String? get sportIcon => _sportIcon;
  String? get activeIcon => _activeIcon;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['player_id'] = _playerId;
    map['sport_id'] = _sportId;
    map['created_at'] = _createdAt;
    map['sport_name'] = _sportName;
    map['sport_icon'] = _sportIcon;
    map['active_icon'] = _activeIcon;
    return map;
  }

  set sportName(value) {
    _sportName = value;
  }

  set sportIcon(value) {
    _sportIcon = value;
  }

  set activeIcon(value) {
    _activeIcon = value;
  }

  set createdAt(value) {
    _createdAt = value;
  }

  set sportId(value) {
    _sportId = value;
  }

  set playerId(value) {
    _playerId = value;
  }

  set id(value) {
    _id = value;
  }
}
