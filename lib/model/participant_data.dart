/// status : true
/// message : "Participant Added Successfully"
/// participant : {"id":1,"player_id":"9","event_id":"5","status":"0","amount":"500","payment_id":"0","name":"tausif","number":"7878787878","gender":"male","age":"30","type":"1","payment_mode":"1","payment_status":"0"}
/// participants : [{"id":1,"player_id":"9","event_id":"5","status":"0","amount":"500","payment_id":"0","name":"tausif","number":"7878787878","gender":"male","age":"30","type":"1","payment_mode":"1","payment_status":"0"}]

class ParticipantData {
  ParticipantData({
    bool? status,
    String? message,
    Participant? participant,
    List<Participant>? participants,
  }) {
    _status = status;
    _message = message;
    _participant = participant;
    _participants = participants;
  }

  ParticipantData.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _participant = json['participant'] != null
        ? Participant.fromJson(json['participant'])
        : null;
    if (json['participants'] != null) {
      _participants = [];
      json['participants'].forEach((v) {
        _participants?.add(Participant.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  Participant? _participant;
  List<Participant>? _participants;

  bool? get status => _status;
  String? get message => _message;
  Participant? get participant => _participant;
  List<Participant>? get participants => _participants;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_participant != null) {
      map['participant'] = _participant?.toJson();
    }
    if (_participants != null) {
      map['participants'] = _participants?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1
/// player_id : "9"
/// event_id : "5"
/// status : "0"
/// amount : "500"
/// payment_id : "0"
/// name : "tausif"
/// number : "7878787878"
/// gender : "male"
/// age : "30"
/// type : "1"
/// payment_mode : "1"
/// payment_status : "0"
//
// class Participants {
//   Participants({
//     int? id,
//     String? playerId,
//     String? eventId,
//     String? status,
//     String? amount,
//     String? paymentId,
//     String? name,
//     String? number,
//     String? gender,
//     String? age,
//     String? type,
//     String? paymentMode,
//     String? paymentStatus,
//   }) {
//     _id = id;
//     _playerId = playerId;
//     _eventId = eventId;
//     _status = status;
//     _amount = amount;
//     _paymentId = paymentId;
//     _name = name;
//     _number = number;
//     _gender = gender;
//     _age = age;
//     _type = type;
//     _paymentMode = paymentMode;
//     _paymentStatus = paymentStatus;
//   }
//
//   Participants.fromJson(dynamic json) {
//     _id = json['id'];
//     _playerId = json['player_id'];
//     _eventId = json['event_id'];
//     _status = json['status'];
//     _amount = json['amount'];
//     _paymentId = json['payment_id'];
//     _name = json['name'];
//     _number = json['number'];
//     _gender = json['gender'];
//     _age = json['age'];
//     _type = json['type'];
//     _paymentMode = json['payment_mode'];
//     _paymentStatus = json['payment_status'];
//   }
//   int? _id;
//   String? _playerId;
//   String? _eventId;
//   String? _status;
//   String? _amount;
//   String? _paymentId;
//   String? _name;
//   String? _number;
//   String? _gender;
//   String? _age;
//   String? _type;
//   String? _paymentMode;
//   String? _paymentStatus;
//
//   int? get id => _id;
//   String? get playerId => _playerId;
//   String? get eventId => _eventId;
//   String? get status => _status;
//   String? get amount => _amount;
//   String? get paymentId => _paymentId;
//   String? get name => _name;
//   String? get number => _number;
//   String? get gender => _gender;
//   String? get age => _age;
//   String? get type => _type;
//   String? get paymentMode => _paymentMode;
//   String? get paymentStatus => _paymentStatus;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['player_id'] = _playerId;
//     map['event_id'] = _eventId;
//     map['status'] = _status;
//     map['amount'] = _amount;
//     map['payment_id'] = _paymentId;
//     map['name'] = _name;
//     map['number'] = _number;
//     map['gender'] = _gender;
//     map['age'] = _age;
//     map['type'] = _type;
//     map['payment_mode'] = _paymentMode;
//     map['payment_status'] = _paymentStatus;
//     return map;
//   }
// }

/// id : 1
/// player_id : "9"
/// event_id : "5"
/// status : "0"
/// amount : "500"
/// payment_id : "0"
/// name : "tausif"
/// number : "7878787878"
/// gender : "male"
/// age : "30"
/// type : "1"
/// payment_mode : "1"
/// payment_status : "0"

class Participant {
  Participant({
    int? id,
    String? playerId,
    String? eventId,
    String? status,
    String? amount,
    String? paymentId,
    String? name,
    String? number,
    String? gender,
    String? age,
    String? type,
    String? paymentMode,
    String? paymentStatus,
  }) {
    _id = id;
    _playerId = playerId;
    _eventId = eventId;
    _status = status;
    _amount = amount;
    _paymentId = paymentId;
    _name = name;
    _number = number;
    _gender = gender;
    _age = age;
    _type = type;
    _paymentMode = paymentMode;
    _paymentStatus = paymentStatus;
  }

  Participant.fromJson(dynamic json) {
    _id = json['id'];
    _playerId = json['player_id'];
    _eventId = json['event_id'];
    _status = json['status'];
    _amount = json['amount'];
    _paymentId = json['payment_id'];
    _name = json['name'];
    _number = json['number'];
    _gender = json['gender'];
    _age = json['age'];
    _type = json['type'];
    _paymentMode = json['payment_mode'];
    _paymentStatus = json['payment_status'];
  }
  int? _id;
  String? _playerId;
  String? _eventId;
  String? _status;
  String? _amount;
  String? _paymentId;
  String? _name;
  String? _number;
  String? _gender;
  String? _age;
  String? _type;
  String? _paymentMode;
  String? _paymentStatus;

  int? get id => _id;
  String? get playerId => _playerId;
  String? get eventId => _eventId;
  String? get status => _status;
  String? get amount => _amount;
  String? get paymentId => _paymentId;
  String? get name => _name;
  String? get number => _number;
  String? get gender => _gender;
  String? get age => _age;
  String? get type => _type;
  String? get paymentMode => _paymentMode;
  String? get paymentStatus => _paymentStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['player_id'] = _playerId;
    map['event_id'] = _eventId;
    map['status'] = _status;
    map['amount'] = _amount;
    map['payment_id'] = _paymentId;
    map['name'] = _name;
    map['number'] = _number;
    map['gender'] = _gender;
    map['age'] = _age;
    map['type'] = _type;
    map['payment_mode'] = _paymentMode;
    map['payment_status'] = _paymentStatus;
    return map;
  }

  set paymentStatus(String? value) {
    _paymentStatus = value;
  }

  set paymentMode(String? value) {
    _paymentMode = value;
  }

  set type(String? value) {
    _type = value;
  }

  set age(String? value) {
    _age = value;
  }

  set gender(String? value) {
    _gender = value;
  }

  set number(String? value) {
    _number = value;
  }

  set name(String? value) {
    _name = value;
  }

  set paymentId(String? value) {
    _paymentId = value;
  }

  set amount(String? value) {
    _amount = value;
  }

  set status(String? value) {
    _status = value;
  }

  set eventId(String? value) {
    _eventId = value;
  }

  set playerId(String? value) {
    _playerId = value;
  }

  set id(int? value) {
    _id = value;
  }
}
