/// status : true
/// message : "Host Activity Added Successfully"
/// activity : {"sport_id":"1","sport_name":"cricket","looking_for_id":"1","looking_for":"player to join","looking_for_value":"opponent","area":"gotri","start_date":"25/11/2020","timing":"8:50 AM","ball_type":"tennis","player_id":"1","player_name":"tausif","location_id":"1","created_at":"25/11/2020","id":4}
/// activites : [{"id":1,"sport_id":"1","sport_name":"cricket","looking_for_id":"1","looking_for":"player to join","looking_for_value":"opponent","area":"gotri","start_date":"25/11/2020","timing":"8:50 AM","ball_type":"tennis","player_id":"1","player_name":"tausif","location_id":"1","created_at":"25/11/2020"},{"id":3,"sport_id":"1","sport_name":"cricket","looking_for_id":"1","looking_for":"player to join","looking_for_value":"opponent","area":"gotri","start_date":"25/11/2020","timing":"8:50 AM","ball_type":"tennis","player_id":"1","player_name":"tausif","location_id":"1","created_at":"25/11/2020"},{"id":4,"sport_id":"1","sport_name":"cricket","looking_for_id":"1","looking_for":"player to join","looking_for_value":"opponent","area":"gotri","start_date":"25/11/2020","timing":"8:50 AM","ball_type":"tennis","player_id":"1","player_name":"tausif","location_id":"1","created_at":"25/11/2020"}]

class HostActivity {
  HostActivity({
    bool? status,
    String? message,
    Activity? activity,
    List<Activites>? activites,
  }) {
    _status = status;
    _message = message;
    _activity = activity;
    _activites = activites;
  }

  HostActivity.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _activity =
        json['activity'] != null ? Activity.fromJson(json['activity']) : null;
    if (json['activites'] != null) {
      _activites = [];
      json['activites'].forEach((v) {
        _activites?.add(Activites.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  Activity? _activity;
  List<Activites>? _activites;

  bool? get status => _status;
  String? get message => _message;
  Activity? get activity => _activity;
  List<Activites>? get activites => _activites;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_activity != null) {
      map['activity'] = _activity?.toJson();
    }
    if (_activites != null) {
      map['activites'] = _activites?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1
/// sport_id : "1"
/// sport_name : "cricket"
/// looking_for_id : "1"
/// looking_for : "player to join"
/// looking_for_value : "opponent"
/// area : "gotri"
/// start_date : "25/11/2020"
/// timing : "8:50 AM"
/// ball_type : "tennis"
/// player_id : "1"
/// player_name : "tausif"
/// location_id : "1"
/// created_at : "25/11/2020"

class Activites {
  Activites({
    int? id,
    String? sportId,
    String? sportName,
    String? lookingForId,
    String? lookingFor,
    String? lookingForValue,
    String? area,
    String? startDate,
    String? timing,
    String? ballType,
    String? playerId,
    String? playerName,
    String? locationId,
    String? createdAt,
  }) {
    _id = id;
    _sportId = sportId;
    _sportName = sportName;
    _lookingForId = lookingForId;
    _lookingFor = lookingFor;
    _lookingForValue = lookingForValue;
    _area = area;
    _startDate = startDate;
    _timing = timing;
    _ballType = ballType;
    _playerId = playerId;
    _playerName = playerName;
    _locationId = locationId;
    _createdAt = createdAt;
  }

  Activites.fromJson(dynamic json) {
    _id = json['id'];
    _sportId = json['sport_id'];
    _sportName = json['sport_name'];
    _lookingForId = json['looking_for_id'];
    _lookingFor = json['looking_for'];
    _lookingForValue = json['looking_for_value'];
    _area = json['area'];
    _startDate = json['start_date'];
    _timing = json['timing'];
    _ballType = json['ball_type'];
    _playerId = json['player_id'];
    _playerName = json['player_name'];
    _locationId = json['location_id'];
    _createdAt = json['created_at'];
  }
  int? _id;
  String? _sportId;
  String? _sportName;
  String? _lookingForId;
  String? _lookingFor;
  String? _lookingForValue;
  String? _area;
  String? _startDate;
  String? _timing;
  String? _ballType;
  String? _playerId;
  String? _playerName;
  String? _locationId;
  String? _createdAt;

  int? get id => _id;
  String? get sportId => _sportId;
  String? get sportName => _sportName;
  String? get lookingForId => _lookingForId;
  String? get lookingFor => _lookingFor;
  String? get lookingForValue => _lookingForValue;
  String? get area => _area;
  String? get startDate => _startDate;
  String? get timing => _timing;
  String? get ballType => _ballType;
  String? get playerId => _playerId;
  String? get playerName => _playerName;
  String? get locationId => _locationId;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['sport_id'] = _sportId;
    map['sport_name'] = _sportName;
    map['looking_for_id'] = _lookingForId;
    map['looking_for'] = _lookingFor;
    map['looking_for_value'] = _lookingForValue;
    map['area'] = _area;
    map['start_date'] = _startDate;
    map['timing'] = _timing;
    map['ball_type'] = _ballType;
    map['player_id'] = _playerId;
    map['player_name'] = _playerName;
    map['location_id'] = _locationId;
    map['created_at'] = _createdAt;
    return map;
  }
}

/// sport_id : "1"
/// sport_name : "cricket"
/// looking_for_id : "1"
/// looking_for : "player to join"
/// looking_for_value : "opponent"
/// area : "gotri"
/// start_date : "25/11/2020"
/// timing : "8:50 AM"
/// ball_type : "tennis"
/// player_id : "1"
/// player_name : "tausif"
/// location_id : "1"
/// created_at : "25/11/2020"
/// id : 4

class Activity {
  Activity({
    String? sportId,
    String? sportName,
    String? lookingForId,
    String? lookingFor,
    String? lookingForValue,
    String? area,
    String? startDate,
    String? timing,
    String? ballType,
    String? playerId,
    String? playerName,
    String? roleOfPlayer,
    String? details,
    String? locationId,
    String? createdAt,
    int? id,
  }) {
    _sportId = sportId;
    _sportName = sportName;
    _lookingForId = lookingForId;
    _lookingFor = lookingFor;
    _lookingForValue = lookingForValue;
    _area = area;
    _startDate = startDate;
    _timing = timing;
    _ballType = ballType;
    _playerId = playerId;
    _playerName = playerName;
    _roleOfPlayer = roleOfPlayer;
    _details = details;
    _locationId = locationId;
    _createdAt = createdAt;
    _id = id;
  }

  Activity.fromJson(dynamic json) {
    _sportId = json['sport_id'];
    _sportName = json['sport_name'];
    _lookingForId = json['looking_for_id'];
    _lookingFor = json['looking_for'];
    _lookingForValue = json['looking_for_value'];
    _area = json['area'];
    _startDate = json['start_date'];
    _timing = json['timing'];
    _ballType = json['ball_type'];
    _playerId = json['player_id'];
    _playerName = json['player_name'];
    _roleOfPlayer = json['role_of_player'];
    _details = json['details'];
    _locationId = json['location_id'];
    _createdAt = json['created_at'];
    _id = json['id'];
  }
  String? _sportId;
  String? _sportName;
  String? _lookingForId;
  String? _lookingFor;
  String? _lookingForValue;
  String? _area;
  String? _startDate;
  String? _timing;
  String? _ballType;
  String? _playerId;
  String? _playerName;
  String? _details;
  String? _roleOfPlayer;
  String? _locationId;
  String? _createdAt;
  int? _id;

  String? get sportId => _sportId;
  String? get sportName => _sportName;
  String? get lookingForId => _lookingForId;
  String? get lookingFor => _lookingFor;
  String? get lookingForValue => _lookingForValue;
  String? get area => _area;
  String? get startDate => _startDate;
  String? get timing => _timing;
  String? get ballType => _ballType;
  String? get playerId => _playerId;
  String? get playerName => _playerName;
  String? get roleOfPlayer => _roleOfPlayer;
  String? get details => _details;
  String? get locationId => _locationId;
  String? get createdAt => _createdAt;
  int? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sport_id'] = _sportId;
    map['sport_name'] = _sportName;
    map['looking_for_id'] = _lookingForId;
    map['looking_for'] = _lookingFor;
    map['looking_for_value'] = _lookingForValue;
    map['area'] = _area;
    map['start_date'] = _startDate;
    map['timing'] = _timing;
    map['ball_type'] = _ballType;
    map['player_id'] = _playerId;
    map['player_name'] = _playerName;
    map['role_of_player'] = _roleOfPlayer;
    map['details'] = _details;
    map['location_id'] = _locationId;
    map['created_at'] = _createdAt;
    map['id'] = _id;
    return map;
  }

  set details(value) {
    _details = value;
  }

  set roleOfPlayer(value) {
    _roleOfPlayer = value;
  }

  set sportName(value) {
    _sportName = value;
  }

  set area(value) {
    _area = value;
  }

  set sportId(value) {
    _sportId = value;
  }

  set lookingForId(value) {
    _lookingForId = value;
  }

  set lookingFor(value) {
    _lookingFor = value;
  }

  set lookingForValue(value) {
    _lookingForValue = value;
  }

  set startDate(value) {
    _startDate = value;
  }

  set timing(value) {
    _timing = value;
  }

  set ballType(value) {
    _ballType = value;
  }

  set playerId(value) {
    _playerId = value;
  }

  set playerName(value) {
    _playerName = value;
  }

  set locationId(value) {
    _locationId = value;
  }

  set createdAt(value) {
    _createdAt = value;
  }

  set id(value) {
    _id = value;
  }
}
