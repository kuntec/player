import 'package:player/model/event_data.dart';
import 'package:player/model/tournament_data.dart';

/// status : true
/// message : "participants Found"
/// participants : [{"id":1,"player_id":"1","event_id":"1","status":"1","amount":"500","payment_id":null,"name":"Test Participant Name","number":"2581473690","gender":"Male","age":"25","type":"0","payment_mode":"1","payment_status":"2","event":{"id":1,"name":"test event name","description":"test description","status":"1","created_at":"21-11-2021","address":"test address","start_date":"22-11-2021","end_date":"23-11-2021","location_id":"2","type":"test event type","image":"events/wB5nT8YXp3ygtlrSs2uW0RHdLGYuD8gUrY3QfdfJ.jpg","location_link":"test link","start_time":"9:0","end_time":"12:0","entry_fees":"1500","members":"25","details":"other test details","player_id":"1","organizer_name":"test organizer","number":"25413652140","secondary_number":"25412563201"},"tournament":{"id":1,"organizer_name":"test organizer name","organizer_number":"78451236547","tournament_name":"Cricket Test","image":"tournaments/yfMS5J48SoulQ5egbsUjM0yZ1sqt0ZIBW8Gchafc.jpg","start_date":"22-11-2021","end_date":"26-11-2021","entry_fees":"500","timing":null,"no_of_members":"11","age_limit":"20","address":"test address","prize_details":"First Prize hamper","other_info":"greate tournament","location_id":"2","player_id":"1","player_name":"tausifali","created_at":"21-11-2021","sport_id":"4","sport_name":"Cricket","start_time":"12:0","end_time":"14:0","ball_type":"Tennis","tournament_category":"Tennis Cricket","no_of_overs":"20","location_link":"test link","status":"1"}}]

class MyParticipantData {
  MyParticipantData({
    bool? status,
    String? message,
    List<Participants>? participants,
  }) {
    _status = status;
    _message = message;
    _participants = participants;
  }

  MyParticipantData.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['participants'] != null) {
      _participants = [];
      json['participants'].forEach((v) {
        _participants?.add(Participants.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Participants>? _participants;

  bool? get status => _status;
  String? get message => _message;
  List<Participants>? get participants => _participants;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_participants != null) {
      map['participants'] = _participants?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1
/// player_id : "1"
/// event_id : "1"
/// status : "1"
/// amount : "500"
/// payment_id : null
/// name : "Test Participant Name"
/// number : "2581473690"
/// gender : "Male"
/// age : "25"
/// type : "0"
/// payment_mode : "1"
/// payment_status : "2"
/// event : {"id":1,"name":"test event name","description":"test description","status":"1","created_at":"21-11-2021","address":"test address","start_date":"22-11-2021","end_date":"23-11-2021","location_id":"2","type":"test event type","image":"events/wB5nT8YXp3ygtlrSs2uW0RHdLGYuD8gUrY3QfdfJ.jpg","location_link":"test link","start_time":"9:0","end_time":"12:0","entry_fees":"1500","members":"25","details":"other test details","player_id":"1","organizer_name":"test organizer","number":"25413652140","secondary_number":"25412563201"}
/// tournament : {"id":1,"organizer_name":"test organizer name","organizer_number":"78451236547","tournament_name":"Cricket Test","image":"tournaments/yfMS5J48SoulQ5egbsUjM0yZ1sqt0ZIBW8Gchafc.jpg","start_date":"22-11-2021","end_date":"26-11-2021","entry_fees":"500","timing":null,"no_of_members":"11","age_limit":"20","address":"test address","prize_details":"First Prize hamper","other_info":"greate tournament","location_id":"2","player_id":"1","player_name":"tausifali","created_at":"21-11-2021","sport_id":"4","sport_name":"Cricket","start_time":"12:0","end_time":"14:0","ball_type":"Tennis","tournament_category":"Tennis Cricket","no_of_overs":"20","location_link":"test link","status":"1"}

class Participants {
  Participants({
    int? id,
    String? playerId,
    String? eventId,
    String? status,
    String? amount,
    dynamic paymentId,
    String? name,
    String? number,
    String? gender,
    String? age,
    String? type,
    String? paymentMode,
    String? paymentStatus,
    Event? event,
    Tournament? tournament,
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
    _event = event;
    _tournament = tournament;
  }

  Participants.fromJson(dynamic json) {
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
    _event = json['event'] != null ? Event.fromJson(json['event']) : null;
    _tournament = json['tournament'] != null
        ? Tournament.fromJson(json['tournament'])
        : null;
  }
  int? _id;
  String? _playerId;
  String? _eventId;
  String? _status;
  String? _amount;
  dynamic _paymentId;
  String? _name;
  String? _number;
  String? _gender;
  String? _age;
  String? _type;
  String? _paymentMode;
  String? _paymentStatus;
  Event? _event;
  Tournament? _tournament;

  int? get id => _id;
  String? get playerId => _playerId;
  String? get eventId => _eventId;
  String? get status => _status;
  String? get amount => _amount;
  dynamic get paymentId => _paymentId;
  String? get name => _name;
  String? get number => _number;
  String? get gender => _gender;
  String? get age => _age;
  String? get type => _type;
  String? get paymentMode => _paymentMode;
  String? get paymentStatus => _paymentStatus;
  Event? get event => _event;
  Tournament? get tournament => _tournament;

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
    if (_event != null) {
      map['event'] = _event?.toJson();
    }
    if (_tournament != null) {
      map['tournament'] = _tournament?.toJson();
    }
    return map;
  }

  set tournament(value) {
    _tournament = value;
  }

  set event(value) {
    _event = value;
  }

  set paymentStatus(value) {
    _paymentStatus = value;
  }

  set paymentMode(value) {
    _paymentMode = value;
  }

  set type(value) {
    _type = value;
  }

  set age(value) {
    _age = value;
  }

  set gender(value) {
    _gender = value;
  }

  set number(value) {
    _number = value;
  }

  set name(value) {
    _name = value;
  }

  set paymentId(value) {
    _paymentId = value;
  }

  set amount(value) {
    _amount = value;
  }

  set status(value) {
    _status = value;
  }

  set eventId(value) {
    _eventId = value;
  }

  set playerId(value) {
    _playerId = value;
  }

  set id(value) {
    _id = value;
  }
}

/// id : 1
/// organizer_name : "test organizer name"
/// organizer_number : "78451236547"
/// tournament_name : "Cricket Test"
/// image : "tournaments/yfMS5J48SoulQ5egbsUjM0yZ1sqt0ZIBW8Gchafc.jpg"
/// start_date : "22-11-2021"
/// end_date : "26-11-2021"
/// entry_fees : "500"
/// timing : null
/// no_of_members : "11"
/// age_limit : "20"
/// address : "test address"
/// prize_details : "First Prize hamper"
/// other_info : "greate tournament"
/// location_id : "2"
/// player_id : "1"
/// player_name : "tausifali"
/// created_at : "21-11-2021"
/// sport_id : "4"
/// sport_name : "Cricket"
/// start_time : "12:0"
/// end_time : "14:0"
/// ball_type : "Tennis"
/// tournament_category : "Tennis Cricket"
/// no_of_overs : "20"
/// location_link : "test link"
/// status : "1"
//
// class Tournament {
//   Tournament({
//     int? id,
//     String? organizerName,
//     String? organizerNumber,
//     String? tournamentName,
//     String? image,
//     String? startDate,
//     String? endDate,
//     String? entryFees,
//     dynamic timing,
//     String? noOfMembers,
//     String? ageLimit,
//     String? address,
//     String? prizeDetails,
//     String? otherInfo,
//     String? locationId,
//     String? playerId,
//     String? playerName,
//     String? createdAt,
//     String? sportId,
//     String? sportName,
//     String? startTime,
//     String? endTime,
//     String? ballType,
//     String? tournamentCategory,
//     String? noOfOvers,
//     String? locationLink,
//     String? status,
//   }) {
//     _id = id;
//     _organizerName = organizerName;
//     _organizerNumber = organizerNumber;
//     _tournamentName = tournamentName;
//     _image = image;
//     _startDate = startDate;
//     _endDate = endDate;
//     _entryFees = entryFees;
//     _timing = timing;
//     _noOfMembers = noOfMembers;
//     _ageLimit = ageLimit;
//     _address = address;
//     _prizeDetails = prizeDetails;
//     _otherInfo = otherInfo;
//     _locationId = locationId;
//     _playerId = playerId;
//     _playerName = playerName;
//     _createdAt = createdAt;
//     _sportId = sportId;
//     _sportName = sportName;
//     _startTime = startTime;
//     _endTime = endTime;
//     _ballType = ballType;
//     _tournamentCategory = tournamentCategory;
//     _noOfOvers = noOfOvers;
//     _locationLink = locationLink;
//     _status = status;
//   }
//
//   Tournament.fromJson(dynamic json) {
//     _id = json['id'];
//     _organizerName = json['organizer_name'];
//     _organizerNumber = json['organizer_number'];
//     _tournamentName = json['tournament_name'];
//     _image = json['image'];
//     _startDate = json['start_date'];
//     _endDate = json['end_date'];
//     _entryFees = json['entry_fees'];
//     _timing = json['timing'];
//     _noOfMembers = json['no_of_members'];
//     _ageLimit = json['age_limit'];
//     _address = json['address'];
//     _prizeDetails = json['prize_details'];
//     _otherInfo = json['other_info'];
//     _locationId = json['location_id'];
//     _playerId = json['player_id'];
//     _playerName = json['player_name'];
//     _createdAt = json['created_at'];
//     _sportId = json['sport_id'];
//     _sportName = json['sport_name'];
//     _startTime = json['start_time'];
//     _endTime = json['end_time'];
//     _ballType = json['ball_type'];
//     _tournamentCategory = json['tournament_category'];
//     _noOfOvers = json['no_of_overs'];
//     _locationLink = json['location_link'];
//     _status = json['status'];
//   }
//   int? _id;
//   String? _organizerName;
//   String? _organizerNumber;
//   String? _tournamentName;
//   String? _image;
//   String? _startDate;
//   String? _endDate;
//   String? _entryFees;
//   dynamic _timing;
//   String? _noOfMembers;
//   String? _ageLimit;
//   String? _address;
//   String? _prizeDetails;
//   String? _otherInfo;
//   String? _locationId;
//   String? _playerId;
//   String? _playerName;
//   String? _createdAt;
//   String? _sportId;
//   String? _sportName;
//   String? _startTime;
//   String? _endTime;
//   String? _ballType;
//   String? _tournamentCategory;
//   String? _noOfOvers;
//   String? _locationLink;
//   String? _status;
//
//   int? get id => _id;
//   String? get organizerName => _organizerName;
//   String? get organizerNumber => _organizerNumber;
//   String? get tournamentName => _tournamentName;
//   String? get image => _image;
//   String? get startDate => _startDate;
//   String? get endDate => _endDate;
//   String? get entryFees => _entryFees;
//   dynamic get timing => _timing;
//   String? get noOfMembers => _noOfMembers;
//   String? get ageLimit => _ageLimit;
//   String? get address => _address;
//   String? get prizeDetails => _prizeDetails;
//   String? get otherInfo => _otherInfo;
//   String? get locationId => _locationId;
//   String? get playerId => _playerId;
//   String? get playerName => _playerName;
//   String? get createdAt => _createdAt;
//   String? get sportId => _sportId;
//   String? get sportName => _sportName;
//   String? get startTime => _startTime;
//   String? get endTime => _endTime;
//   String? get ballType => _ballType;
//   String? get tournamentCategory => _tournamentCategory;
//   String? get noOfOvers => _noOfOvers;
//   String? get locationLink => _locationLink;
//   String? get status => _status;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['organizer_name'] = _organizerName;
//     map['organizer_number'] = _organizerNumber;
//     map['tournament_name'] = _tournamentName;
//     map['image'] = _image;
//     map['start_date'] = _startDate;
//     map['end_date'] = _endDate;
//     map['entry_fees'] = _entryFees;
//     map['timing'] = _timing;
//     map['no_of_members'] = _noOfMembers;
//     map['age_limit'] = _ageLimit;
//     map['address'] = _address;
//     map['prize_details'] = _prizeDetails;
//     map['other_info'] = _otherInfo;
//     map['location_id'] = _locationId;
//     map['player_id'] = _playerId;
//     map['player_name'] = _playerName;
//     map['created_at'] = _createdAt;
//     map['sport_id'] = _sportId;
//     map['sport_name'] = _sportName;
//     map['start_time'] = _startTime;
//     map['end_time'] = _endTime;
//     map['ball_type'] = _ballType;
//     map['tournament_category'] = _tournamentCategory;
//     map['no_of_overs'] = _noOfOvers;
//     map['location_link'] = _locationLink;
//     map['status'] = _status;
//     return map;
//   }
// }

/// id : 1
/// name : "test event name"
/// description : "test description"
/// status : "1"
/// created_at : "21-11-2021"
/// address : "test address"
/// start_date : "22-11-2021"
/// end_date : "23-11-2021"
/// location_id : "2"
/// type : "test event type"
/// image : "events/wB5nT8YXp3ygtlrSs2uW0RHdLGYuD8gUrY3QfdfJ.jpg"
/// location_link : "test link"
/// start_time : "9:0"
/// end_time : "12:0"
/// entry_fees : "1500"
/// members : "25"
/// details : "other test details"
/// player_id : "1"
/// organizer_name : "test organizer"
/// number : "25413652140"
/// secondary_number : "25412563201"
//
// class Event {
//   Event({
//     int? id,
//     String? name,
//     String? description,
//     String? status,
//     String? createdAt,
//     String? address,
//     String? startDate,
//     String? endDate,
//     String? locationId,
//     String? type,
//     String? image,
//     String? locationLink,
//     String? startTime,
//     String? endTime,
//     String? entryFees,
//     String? members,
//     String? details,
//     String? playerId,
//     String? organizerName,
//     String? number,
//     String? secondaryNumber,
//   }) {
//     _id = id;
//     _name = name;
//     _description = description;
//     _status = status;
//     _createdAt = createdAt;
//     _address = address;
//     _startDate = startDate;
//     _endDate = endDate;
//     _locationId = locationId;
//     _type = type;
//     _image = image;
//     _locationLink = locationLink;
//     _startTime = startTime;
//     _endTime = endTime;
//     _entryFees = entryFees;
//     _members = members;
//     _details = details;
//     _playerId = playerId;
//     _organizerName = organizerName;
//     _number = number;
//     _secondaryNumber = secondaryNumber;
//   }
//
//   Event.fromJson(dynamic json) {
//     _id = json['id'];
//     _name = json['name'];
//     _description = json['description'];
//     _status = json['status'];
//     _createdAt = json['created_at'];
//     _address = json['address'];
//     _startDate = json['start_date'];
//     _endDate = json['end_date'];
//     _locationId = json['location_id'];
//     _type = json['type'];
//     _image = json['image'];
//     _locationLink = json['location_link'];
//     _startTime = json['start_time'];
//     _endTime = json['end_time'];
//     _entryFees = json['entry_fees'];
//     _members = json['members'];
//     _details = json['details'];
//     _playerId = json['player_id'];
//     _organizerName = json['organizer_name'];
//     _number = json['number'];
//     _secondaryNumber = json['secondary_number'];
//   }
//   int? _id;
//   String? _name;
//   String? _description;
//   String? _status;
//   String? _createdAt;
//   String? _address;
//   String? _startDate;
//   String? _endDate;
//   String? _locationId;
//   String? _type;
//   String? _image;
//   String? _locationLink;
//   String? _startTime;
//   String? _endTime;
//   String? _entryFees;
//   String? _members;
//   String? _details;
//   String? _playerId;
//   String? _organizerName;
//   String? _number;
//   String? _secondaryNumber;
//
//   int? get id => _id;
//   String? get name => _name;
//   String? get description => _description;
//   String? get status => _status;
//   String? get createdAt => _createdAt;
//   String? get address => _address;
//   String? get startDate => _startDate;
//   String? get endDate => _endDate;
//   String? get locationId => _locationId;
//   String? get type => _type;
//   String? get image => _image;
//   String? get locationLink => _locationLink;
//   String? get startTime => _startTime;
//   String? get endTime => _endTime;
//   String? get entryFees => _entryFees;
//   String? get members => _members;
//   String? get details => _details;
//   String? get playerId => _playerId;
//   String? get organizerName => _organizerName;
//   String? get number => _number;
//   String? get secondaryNumber => _secondaryNumber;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['name'] = _name;
//     map['description'] = _description;
//     map['status'] = _status;
//     map['created_at'] = _createdAt;
//     map['address'] = _address;
//     map['start_date'] = _startDate;
//     map['end_date'] = _endDate;
//     map['location_id'] = _locationId;
//     map['type'] = _type;
//     map['image'] = _image;
//     map['location_link'] = _locationLink;
//     map['start_time'] = _startTime;
//     map['end_time'] = _endTime;
//     map['entry_fees'] = _entryFees;
//     map['members'] = _members;
//     map['details'] = _details;
//     map['player_id'] = _playerId;
//     map['organizer_name'] = _organizerName;
//     map['number'] = _number;
//     map['secondary_number'] = _secondaryNumber;
//     return map;
//   }
// }
