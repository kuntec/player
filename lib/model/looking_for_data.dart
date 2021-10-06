/// status : true
/// message : "lookingFor Found"
/// lookingFor : [{"id":1,"looking_for":"A Player to Join a Team","looking_for_value":"Player","created_at":"06/11/2020"},{"id":2,"looking_for":"An opponent to Join a Team","looking_for_value":"Opponent","created_at":"06/11/2020"}]

class LookingForData {
  LookingForData({
    bool? status,
    String? message,
    List<LookingFor>? lookingFor,
  }) {
    _status = status;
    _message = message;
    _lookingFor = lookingFor;
  }

  LookingForData.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['lookingFor'] != null) {
      _lookingFor = [];
      json['lookingFor'].forEach((v) {
        _lookingFor?.add(LookingFor.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<LookingFor>? _lookingFor;

  bool? get status => _status;
  String? get message => _message;
  List<LookingFor>? get lookingFor => _lookingFor;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_lookingFor != null) {
      map['lookingFor'] = _lookingFor?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1
/// looking_for : "A Player to Join a Team"
/// looking_for_value : "Player"
/// created_at : "06/11/2020"

class LookingFor {
  LookingFor({
    int? id,
    String? lookingFor,
    String? lookingForValue,
    String? createdAt,
  }) {
    _id = id;
    _lookingFor = lookingFor;
    _lookingForValue = lookingForValue;
    _createdAt = createdAt;
  }

  LookingFor.fromJson(dynamic json) {
    _id = json['id'];
    _lookingFor = json['looking_for'];
    _lookingForValue = json['looking_for_value'];
    _createdAt = json['created_at'];
  }
  int? _id;
  String? _lookingFor;
  String? _lookingForValue;
  String? _createdAt;

  int? get id => _id;
  String? get lookingFor => _lookingFor;
  String? get lookingForValue => _lookingForValue;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['looking_for'] = _lookingFor;
    map['looking_for_value'] = _lookingForValue;
    map['created_at'] = _createdAt;
    return map;
  }
}
