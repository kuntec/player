/// status : true
/// message : "Player Added Successfully"
/// player : {"name":"saiyed","mobile":"9409394240","dob":"06/11/1989","gender":"female","id":5}
/// players : [{"id":1,"name":"tausif","dob":"28/01/89","gender":"male","image":null,"created_at":"0000-00-00","mobile":"9409394242"},{"id":2,"name":"farana","dob":"06/11/1989","gender":"female","image":null,"created_at":"2021-09-24","mobile":"9624514131"},{"id":3,"name":"farana","dob":"06/11/1989","gender":"female","image":null,"created_at":"2021-09-25","mobile":"9624514131"}]

class PlayerData {
  PlayerData({
    bool? status,
    String? message,
    Player? player,
    List<Player>? players,
  }) {
    _status = status;
    _message = message;
    _player = player;
    _players = players;
  }

  PlayerData.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _player = json['player'] != null ? Player.fromJson(json['player']) : null;
    if (json['players'] != null) {
      _players = [];
      json['players'].forEach((v) {
        _players?.add(Player.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  Player? _player;
  List<Player>? _players;

  bool? get status => _status;
  String? get message => _message;
  Player? get player => _player;
  List<Player>? get players => _players;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_player != null) {
      map['player'] = _player?.toJson();
    }
    if (_players != null) {
      map['players'] = _players?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1
/// name : "tausif"
/// dob : "28/01/89"
/// gender : "male"
/// image : null
/// created_at : "0000-00-00"
/// mobile : "9409394242"

// class Players {
//   Players({
//     int? id,
//     String? name,
//     String? dob,
//     String? gender,
//     dynamic image,
//     String? createdAt,
//     String? mobile,
//   }) {
//     _id = id;
//     _name = name;
//     _dob = dob;
//     _gender = gender;
//     _image = image;
//     _createdAt = createdAt;
//     _mobile = mobile;
//   }
//
//   Players.fromJson(dynamic json) {
//     _id = json['id'];
//     _name = json['name'];
//     _dob = json['dob'];
//     _gender = json['gender'];
//     _image = json['image'];
//     _createdAt = json['created_at'];
//     _mobile = json['mobile'];
//   }
//   int? _id;
//   String? _name;
//   String? _dob;
//   String? _gender;
//   dynamic _image;
//   String? _createdAt;
//   String? _mobile;
//
//   int? get id => _id;
//   String? get name => _name;
//   String? get dob => _dob;
//   String? get gender => _gender;
//   dynamic get image => _image;
//   String? get createdAt => _createdAt;
//   String? get mobile => _mobile;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['name'] = _name;
//     map['dob'] = _dob;
//     map['gender'] = _gender;
//     map['image'] = _image;
//     map['created_at'] = _createdAt;
//     map['mobile'] = _mobile;
//     return map;
//   }
// }

/// name : "saiyed"
/// mobile : "9409394240"
/// dob : "06/11/1989"
/// gender : "female"
/// id : 5

class Player {
  Player({
    String? name,
    String? mobile,
    String? dob,
    String? gender,
    String? image,
    String? email,
    String? locationId,
    String? fuid,
    int? id,
  }) {
    _name = name;
    _mobile = mobile;
    _dob = dob;
    _gender = gender;
    _image = image;
    _email = email;
    _locationId = locationId;
    _fuid = fuid;
    _id = id;
  }
  Player.fromJson(dynamic json) {
    _name = json['name'];
    _mobile = json['mobile'];
    _dob = json['dob'];
    _gender = json['gender'];
    _image = json['image'];
    _email = json['email'];
    _locationId = json['location_id'];
    _fuid = json['f_uid'];
    _id = json['id'];
  }
  String? _name;
  String? _mobile;
  String? _dob;
  String? _gender;
  String? _image;
  String? _email;
  String? _locationId;
  String? _fuid;
  int? _id;

  String? get name => _name;
  String? get mobile => _mobile;
  String? get dob => _dob;
  String? get gender => _gender;
  String? get image => _image;
  int? get id => _id;
  String? get email => _email;
  String? get locationId => _locationId;
  String? get fuid => _fuid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['mobile'] = _mobile;
    map['dob'] = _dob;
    map['gender'] = _gender;
    map['image'] = _image;
    map['email'] = _email;
    map['location_id'] = _locationId;
    map['f_uid'] = _fuid;
    map['id'] = _id;
    return map;
  }

  set id(value) {
    _id = value;
  }

  set fuid(value) {
    _fuid = value;
  }

  set locationId(value) {
    _locationId = value;
  }

  set email(value) {
    _email = value;
  }

  set image(value) {
    _image = value;
  }

  set gender(value) {
    _gender = value;
  }

  set dob(value) {
    _dob = value;
  }

  set mobile(value) {
    _mobile = value;
  }

  set name(value) {
    _name = value;
  }
}
