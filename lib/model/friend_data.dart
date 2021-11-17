/// status : true
/// message : "Friend Listed Successfully"
/// friend : [{"id":1,"player_id1":"1","player_id2":"2","status":"0","player":{"id":1,"name":"Tausif Saiyed","dob":"28/01/1990","gender":"Male","image":"players/SfO31VYriCf7nSccatAgbNt6OM0HHoHwI1oZZ0bu.jpg","created_at":"2021-11-06","mobile":"+919409394242","email":"tausifali.mhs@gmail.com","location_id":"","city":"","type":"","f_uid":"ryo4TF1OY0QfzmMH45fsWJlNmy92"}}]

class FriendData {
  FriendData({
    bool? status,
    String? message,
    List<Friends>? friend,
  }) {
    _status = status;
    _message = message;
    _friend = friend;
  }

  FriendData.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['friend'] != null) {
      _friend = [];
      json['friend'].forEach((v) {
        _friend?.add(Friends.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Friends>? _friend;

  bool? get status => _status;
  String? get message => _message;
  List<Friends>? get friend => _friend;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_friend != null) {
      map['friend'] = _friend?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1
/// player_id1 : "1"
/// player_id2 : "2"
/// status : "0"
/// player : {"id":1,"name":"Tausif Saiyed","dob":"28/01/1990","gender":"Male","image":"players/SfO31VYriCf7nSccatAgbNt6OM0HHoHwI1oZZ0bu.jpg","created_at":"2021-11-06","mobile":"+919409394242","email":"tausifali.mhs@gmail.com","location_id":"","city":"","type":"","f_uid":"ryo4TF1OY0QfzmMH45fsWJlNmy92"}

class Friends {
  Friends({
    int? id,
    String? playerId1,
    String? playerId2,
    String? status,
    Player2? player,
  }) {
    _id = id;
    _playerId1 = playerId1;
    _playerId2 = playerId2;
    _status = status;
    _player = player;
  }

  Friends.fromJson(dynamic json) {
    _id = json['id'];
    _playerId1 = json['player_id1'];
    _playerId2 = json['player_id2'];
    _status = json['status'];
    _player = json['player'] != null ? Player2.fromJson(json['player']) : null;
  }
  int? _id;
  String? _playerId1;
  String? _playerId2;
  String? _status;
  Player2? _player;

  int? get id => _id;
  String? get playerId1 => _playerId1;
  String? get playerId2 => _playerId2;
  String? get status => _status;
  Player2? get player => _player;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['player_id1'] = _playerId1;
    map['player_id2'] = _playerId2;
    map['status'] = _status;
    if (_player != null) {
      map['player'] = _player?.toJson();
    }
    return map;
  }
}

/// id : 1
/// name : "Tausif Saiyed"
/// dob : "28/01/1990"
/// gender : "Male"
/// image : "players/SfO31VYriCf7nSccatAgbNt6OM0HHoHwI1oZZ0bu.jpg"
/// created_at : "2021-11-06"
/// mobile : "+919409394242"
/// email : "tausifali.mhs@gmail.com"
/// location_id : ""
/// city : ""
/// type : ""
/// f_uid : "ryo4TF1OY0QfzmMH45fsWJlNmy92"

class Player2 {
  Player2({
    int? id,
    String? name,
    String? dob,
    String? gender,
    String? image,
    String? createdAt,
    String? mobile,
    String? email,
    String? locationId,
    String? city,
    String? type,
    String? fUid,
  }) {
    _id = id;
    _name = name;
    _dob = dob;
    _gender = gender;
    _image = image;
    _createdAt = createdAt;
    _mobile = mobile;
    _email = email;
    _locationId = locationId;
    _city = city;
    _type = type;
    _fUid = fUid;
  }

  Player2.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _dob = json['dob'];
    _gender = json['gender'];
    _image = json['image'];
    _createdAt = json['created_at'];
    _mobile = json['mobile'];
    _email = json['email'];
    _locationId = json['location_id'];
    _city = json['city'];
    _type = json['type'];
    _fUid = json['f_uid'];
  }
  int? _id;
  String? _name;
  String? _dob;
  String? _gender;
  String? _image;
  String? _createdAt;
  String? _mobile;
  String? _email;
  String? _locationId;
  String? _city;
  String? _type;
  String? _fUid;

  int? get id => _id;
  String? get name => _name;
  String? get dob => _dob;
  String? get gender => _gender;
  String? get image => _image;
  String? get createdAt => _createdAt;
  String? get mobile => _mobile;
  String? get email => _email;
  String? get locationId => _locationId;
  String? get city => _city;
  String? get type => _type;
  String? get fUid => _fUid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['dob'] = _dob;
    map['gender'] = _gender;
    map['image'] = _image;
    map['created_at'] = _createdAt;
    map['mobile'] = _mobile;
    map['email'] = _email;
    map['location_id'] = _locationId;
    map['city'] = _city;
    map['type'] = _type;
    map['f_uid'] = _fUid;
    return map;
  }
}
