/// status : true
/// message : "Conversation Found"
/// conversation : [{"id":2,"player1":{"id":3,"name":"Farana Kazi","dob":"11-11-2021","gender":"Female","image":null,"created_at":"2021-11-27","mobile":"+919624514131","email":null,"location_id":"3","city":"Vadodara","type":null,"f_uid":"ccDgVVJztSUoJkxOdfhMZ2IyHuz1","device_token":"fEqL_-P3SMaILQDwIsV8bg:APA91bFZuElNcMsE7ARkade_qOJ63y33u_vV-BxqXI4iJ37tp_hyfSWJ9gwPQQQNF1om0zS8EEhdXjOzoq1n0tVRzyJkFkgk1indIaUGBft0SMMKD6brVsT03_fzGNH2kXxlf-vqzBXR"},"player2":{"id":2,"name":"Saiyed","dob":"25-11-2009","gender":"Female","image":"players/iGmafgP0ryYnDcdfqr80ERl0tMFhgQFmWG5ZAAJO.jpg","created_at":"2021-11-27","mobile":"+919106396734","email":null,"location_id":"3","city":"Vadodara","type":null,"f_uid":"ikyrgK8VKbUJ04DQWnP81eD9rvU2","device_token":"fEqL_-P3SMaILQDwIsV8bg:APA91bFZuElNcMsE7ARkade_qOJ63y33u_vV-BxqXI4iJ37tp_hyfSWJ9gwPQQQNF1om0zS8EEhdXjOzoq1n0tVRzyJkFkgk1indIaUGBft0SMMKD6brVsT03_fzGNH2kXxlf-vqzBXR"},"status":"0","created_at":"2021-11-27 07:10:52","updated_at":"2021-11-27 07:10:52","updated":"2021-11-27 12:41:41","reply":[{"id":3,"conversation_id":"2","player_id":"3","message":"Hello","created_at":"2021-11-27 07:10:52","status":"0"},{"id":5,"conversation_id":"2","player_id":"3","message":"hii","created_at":"2021-11-27 07:11:16","status":"0"},{"id":6,"conversation_id":"2","player_id":"3","message":"test","created_at":"2021-11-27 07:11:24","status":"0"},{"id":8,"conversation_id":"2","player_id":"3","message":"yeah222444","created_at":"2021-11-27 07:24:55","status":"0"},{"id":9,"conversation_id":"2","player_id":"3","message":"yeah222444","created_at":"2021-11-27 07:33:32","status":"0"},{"id":10,"conversation_id":"2","player_id":"3","message":"yeah222444","created_at":"2021-11-27 07:35:12","status":"0"},{"id":13,"conversation_id":"2","player_id":"3","message":"yeah222444","created_at":"2021-11-27 07:39:38","status":"0"},{"id":15,"conversation_id":"2","player_id":"3","message":"yeah222444","created_at":"2021-11-27 07:40:49","status":"0"},{"id":16,"conversation_id":"2","player_id":"3","message":"Hello saiyed","created_at":"2021-11-27 07:41:41","status":"0"}]},{"id":3,"player1":{"id":3,"name":"Farana Kazi","dob":"11-11-2021","gender":"Female","image":null,"created_at":"2021-11-27","mobile":"+919624514131","email":null,"location_id":"3","city":"Vadodara","type":null,"f_uid":"ccDgVVJztSUoJkxOdfhMZ2IyHuz1","device_token":"fEqL_-P3SMaILQDwIsV8bg:APA91bFZuElNcMsE7ARkade_qOJ63y33u_vV-BxqXI4iJ37tp_hyfSWJ9gwPQQQNF1om0zS8EEhdXjOzoq1n0tVRzyJkFkgk1indIaUGBft0SMMKD6brVsT03_fzGNH2kXxlf-vqzBXR"},"player2":{"id":1,"name":"Tausif Saiyed","dob":"28-1-1989","gender":"Male","image":"players/vmrDwGCKTgsSU2MQQbrWRGPffmTxlw7IVMpIma39.jpg","created_at":"2021-11-27","mobile":"+919409394242","email":"tausifali.mhs@gmail.com","location_id":"3","city":"Vadodara","type":null,"f_uid":"ryo4TF1OY0QfzmMH45fsWJlNmy92","device_token":"fEqL_-P3SMaILQDwIsV8bg:APA91bFZuElNcMsE7ARkade_qOJ63y33u_vV-BxqXI4iJ37tp_hyfSWJ9gwPQQQNF1om0zS8EEhdXjOzoq1n0tVRzyJkFkgk1indIaUGBft0SMMKD6brVsT03_fzGNH2kXxlf-vqzBXR"},"status":"0","created_at":"2021-11-27 07:11:02","updated_at":"2021-11-27 07:11:02","updated":"2021-11-27 12:41:55","reply":[{"id":4,"conversation_id":"3","player_id":"3","message":"hi","created_at":"2021-11-27 07:11:02","status":"0"},{"id":7,"conversation_id":"3","player_id":"3","message":"test","created_at":"2021-11-27 07:11:31","status":"0"},{"id":11,"conversation_id":"3","player_id":"3","message":"yeah222444","created_at":"2021-11-27 07:35:27","status":"0"},{"id":12,"conversation_id":"3","player_id":"3","message":"yeah222444","created_at":"2021-11-27 07:39:21","status":"0"},{"id":14,"conversation_id":"3","player_id":"3","message":"yeah222444","created_at":"2021-11-27 07:40:24","status":"0"},{"id":17,"conversation_id":"3","player_id":"3","message":"Hello tausifali","created_at":"2021-11-27 07:41:55","status":"0"}]}]

class ConversationData {
  ConversationData({
    bool? status,
    String? message,
    List<Conversation>? conversation,
  }) {
    _status = status;
    _message = message;
    _conversation = conversation;
  }

  ConversationData.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['conversation'] != null) {
      _conversation = [];
      json['conversation'].forEach((v) {
        _conversation?.add(Conversation.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Conversation>? _conversation;

  bool? get status => _status;
  String? get message => _message;
  List<Conversation>? get conversation => _conversation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_conversation != null) {
      map['conversation'] = _conversation?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 2
/// player1 : {"id":3,"name":"Farana Kazi","dob":"11-11-2021","gender":"Female","image":null,"created_at":"2021-11-27","mobile":"+919624514131","email":null,"location_id":"3","city":"Vadodara","type":null,"f_uid":"ccDgVVJztSUoJkxOdfhMZ2IyHuz1","device_token":"fEqL_-P3SMaILQDwIsV8bg:APA91bFZuElNcMsE7ARkade_qOJ63y33u_vV-BxqXI4iJ37tp_hyfSWJ9gwPQQQNF1om0zS8EEhdXjOzoq1n0tVRzyJkFkgk1indIaUGBft0SMMKD6brVsT03_fzGNH2kXxlf-vqzBXR"}
/// player2 : {"id":2,"name":"Saiyed","dob":"25-11-2009","gender":"Female","image":"players/iGmafgP0ryYnDcdfqr80ERl0tMFhgQFmWG5ZAAJO.jpg","created_at":"2021-11-27","mobile":"+919106396734","email":null,"location_id":"3","city":"Vadodara","type":null,"f_uid":"ikyrgK8VKbUJ04DQWnP81eD9rvU2","device_token":"fEqL_-P3SMaILQDwIsV8bg:APA91bFZuElNcMsE7ARkade_qOJ63y33u_vV-BxqXI4iJ37tp_hyfSWJ9gwPQQQNF1om0zS8EEhdXjOzoq1n0tVRzyJkFkgk1indIaUGBft0SMMKD6brVsT03_fzGNH2kXxlf-vqzBXR"}
/// status : "0"
/// created_at : "2021-11-27 07:10:52"
/// updated_at : "2021-11-27 07:10:52"
/// updated : "2021-11-27 12:41:41"
/// reply : [{"id":3,"conversation_id":"2","player_id":"3","message":"Hello","created_at":"2021-11-27 07:10:52","status":"0"},{"id":5,"conversation_id":"2","player_id":"3","message":"hii","created_at":"2021-11-27 07:11:16","status":"0"},{"id":6,"conversation_id":"2","player_id":"3","message":"test","created_at":"2021-11-27 07:11:24","status":"0"},{"id":8,"conversation_id":"2","player_id":"3","message":"yeah222444","created_at":"2021-11-27 07:24:55","status":"0"},{"id":9,"conversation_id":"2","player_id":"3","message":"yeah222444","created_at":"2021-11-27 07:33:32","status":"0"},{"id":10,"conversation_id":"2","player_id":"3","message":"yeah222444","created_at":"2021-11-27 07:35:12","status":"0"},{"id":13,"conversation_id":"2","player_id":"3","message":"yeah222444","created_at":"2021-11-27 07:39:38","status":"0"},{"id":15,"conversation_id":"2","player_id":"3","message":"yeah222444","created_at":"2021-11-27 07:40:49","status":"0"},{"id":16,"conversation_id":"2","player_id":"3","message":"Hello saiyed","created_at":"2021-11-27 07:41:41","status":"0"}]

class Conversation {
  Conversation({
    int? id,
    Player1? player1,
    Player2? player2,
    String? status,
    String? createdAt,
    String? updatedAt,
    String? updated,
    String? unread,
    List<Reply>? reply,
  }) {
    _id = id;
    _player1 = player1;
    _player2 = player2;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _updated = updated;
    _reply = reply;
    _unread = unread;
  }

  Conversation.fromJson(dynamic json) {
    _id = json['id'];
    _player1 =
        json['player1'] != null ? Player1.fromJson(json['player1']) : null;
    _player2 =
        json['player2'] != null ? Player2.fromJson(json['player2']) : null;
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _updated = json['updated'];
    _unread = json['unread'];
    if (json['reply'] != null) {
      _reply = [];
      json['reply'].forEach((v) {
        _reply?.add(Reply.fromJson(v));
      });
    }
  }
  int? _id;
  Player1? _player1;
  Player2? _player2;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
  String? _updated;
  String? _unread;
  List<Reply>? _reply;

  int? get id => _id;
  Player1? get player1 => _player1;
  Player2? get player2 => _player2;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get updated => _updated;
  String? get unread => _unread;
  List<Reply>? get reply => _reply;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    if (_player1 != null) {
      map['player1'] = _player1?.toJson();
    }
    if (_player2 != null) {
      map['player2'] = _player2?.toJson();
    }
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['updated'] = _updated;
    map['unread'] = _unread;
    if (_reply != null) {
      map['reply'] = _reply?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  set unread(value) {
    _unread = value;
  }
}

/// id : 3
/// conversation_id : "2"
/// player_id : "3"
/// message : "Hello"
/// created_at : "2021-11-27 07:10:52"
/// status : "0"

class Reply {
  Reply({
    int? id,
    String? conversationId,
    String? playerId,
    String? message,
    String? createdAt,
    String? status,
  }) {
    _id = id;
    _conversationId = conversationId;
    _playerId = playerId;
    _message = message;
    _createdAt = createdAt;
    _status = status;
  }

  Reply.fromJson(dynamic json) {
    _id = json['id'];
    _conversationId = json['conversation_id'];
    _playerId = json['player_id'];
    _message = json['message'];
    _createdAt = json['created_at'];
    _status = json['status'];
  }
  int? _id;
  String? _conversationId;
  String? _playerId;
  String? _message;
  String? _createdAt;
  String? _status;

  int? get id => _id;
  String? get conversationId => _conversationId;
  String? get playerId => _playerId;
  String? get message => _message;
  String? get createdAt => _createdAt;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['conversation_id'] = _conversationId;
    map['player_id'] = _playerId;
    map['message'] = _message;
    map['created_at'] = _createdAt;
    map['status'] = _status;

    return map;
  }

  set status(value) {
    _status = value;
  }

  set createdAt(value) {
    _createdAt = value;
  }

  set message(value) {
    _message = value;
  }

  set playerId(value) {
    _playerId = value;
  }

  set conversationId(value) {
    _conversationId = value;
  }

  set id(value) {
    _id = value;
  }
}

/// id : 2
/// name : "Saiyed"
/// dob : "25-11-2009"
/// gender : "Female"
/// image : "players/iGmafgP0ryYnDcdfqr80ERl0tMFhgQFmWG5ZAAJO.jpg"
/// created_at : "2021-11-27"
/// mobile : "+919106396734"
/// email : null
/// location_id : "3"
/// city : "Vadodara"
/// type : null
/// f_uid : "ikyrgK8VKbUJ04DQWnP81eD9rvU2"
/// device_token : "fEqL_-P3SMaILQDwIsV8bg:APA91bFZuElNcMsE7ARkade_qOJ63y33u_vV-BxqXI4iJ37tp_hyfSWJ9gwPQQQNF1om0zS8EEhdXjOzoq1n0tVRzyJkFkgk1indIaUGBft0SMMKD6brVsT03_fzGNH2kXxlf-vqzBXR"

class Player2 {
  Player2({
    int? id,
    String? name,
    String? dob,
    String? gender,
    String? image,
    String? createdAt,
    String? mobile,
    dynamic email,
    String? locationId,
    String? city,
    dynamic type,
    String? fUid,
    String? deviceToken,
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
    _deviceToken = deviceToken;
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
    _deviceToken = json['device_token'];
  }
  int? _id;
  String? _name;
  String? _dob;
  String? _gender;
  String? _image;
  String? _createdAt;
  String? _mobile;
  dynamic _email;
  String? _locationId;
  String? _city;
  dynamic _type;
  String? _fUid;
  String? _deviceToken;

  int? get id => _id;
  String? get name => _name;
  String? get dob => _dob;
  String? get gender => _gender;
  String? get image => _image;
  String? get createdAt => _createdAt;
  String? get mobile => _mobile;
  dynamic get email => _email;
  String? get locationId => _locationId;
  String? get city => _city;
  dynamic get type => _type;
  String? get fUid => _fUid;
  String? get deviceToken => _deviceToken;

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
    map['device_token'] = _deviceToken;
    return map;
  }
}

/// id : 3
/// name : "Farana Kazi"
/// dob : "11-11-2021"
/// gender : "Female"
/// image : null
/// created_at : "2021-11-27"
/// mobile : "+919624514131"
/// email : null
/// location_id : "3"
/// city : "Vadodara"
/// type : null
/// f_uid : "ccDgVVJztSUoJkxOdfhMZ2IyHuz1"
/// device_token : "fEqL_-P3SMaILQDwIsV8bg:APA91bFZuElNcMsE7ARkade_qOJ63y33u_vV-BxqXI4iJ37tp_hyfSWJ9gwPQQQNF1om0zS8EEhdXjOzoq1n0tVRzyJkFkgk1indIaUGBft0SMMKD6brVsT03_fzGNH2kXxlf-vqzBXR"

class Player1 {
  Player1({
    int? id,
    String? name,
    String? dob,
    String? gender,
    dynamic image,
    String? createdAt,
    String? mobile,
    dynamic email,
    String? locationId,
    String? city,
    dynamic type,
    String? fUid,
    String? deviceToken,
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
    _deviceToken = deviceToken;
  }

  Player1.fromJson(dynamic json) {
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
    _deviceToken = json['device_token'];
  }
  int? _id;
  String? _name;
  String? _dob;
  String? _gender;
  dynamic _image;
  String? _createdAt;
  String? _mobile;
  dynamic _email;
  String? _locationId;
  String? _city;
  dynamic _type;
  String? _fUid;
  String? _deviceToken;

  int? get id => _id;
  String? get name => _name;
  String? get dob => _dob;
  String? get gender => _gender;
  dynamic get image => _image;
  String? get createdAt => _createdAt;
  String? get mobile => _mobile;
  dynamic get email => _email;
  String? get locationId => _locationId;
  String? get city => _city;
  dynamic get type => _type;
  String? get fUid => _fUid;
  String? get deviceToken => _deviceToken;

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
    map['device_token'] = _deviceToken;
    return map;
  }
}
