/// status : true
/// message : "Tournament Added Successfully"
/// tournament : {"organizer_name":"Parth","organizer_number":"9856321475","tournament_name":"Cricket Tournament","start_date":"25/11/2020","end_date":"25/11/2020","entry_fees":"1500","timing":"8:50 AM","no_of_members":"5","age_limit":"18","address":"bhayli vadodara","prize_details":"5000 cash prize","other_info":"dont be late","location_id":"1","player_id":"1","player_name":"tausif","created_at":"25/11/2020","image":"tournaments/DvfCdIXaIIGtoiR66yC2AW7paykWZiysp6mEqlEq.jpg","id":1}
/// tournaments : [{"id":1,"organizer_name":"Parth Agrawal","organizer_number":"9856321475","tournament_name":"Cricket Tournament","image":"tournaments/EfqW5KOJkjUiVKHGi1Do4HCwwluyZjMU2YPD80jx.jpg","start_date":"25/11/2020","end_date":"25/11/2020","entry_fees":"1500","timing":"8:50 AM","no_of_members":"5","age_limit":"18","address":"bhayli vadodara","prize_details":"5000 cash prize","other_info":"dont be late","location_id":"1","player_id":"1","player_name":"tausif","created_at":"25/11/2020"}]

class TournamentData {
  TournamentData({
    bool? status,
    String? message,
    Tournament? tournament,
    List<Tournament>? tournaments,
  }) {
    _status = status;
    _message = message;
    _tournament = tournament;
    _tournaments = tournaments;
  }

  TournamentData.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _tournament = json['tournament'] != null
        ? Tournament.fromJson(json['tournament'])
        : null;
    if (json['tournaments'] != null) {
      _tournaments = [];
      json['tournaments'].forEach((v) {
        _tournaments?.add(Tournament.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  Tournament? _tournament;
  List<Tournament>? _tournaments;

  bool? get status => _status;
  String? get message => _message;
  Tournament? get tournament => _tournament;
  List<Tournament>? get tournaments => _tournaments;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_tournament != null) {
      map['tournament'] = _tournament?.toJson();
    }
    if (_tournaments != null) {
      map['tournaments'] = _tournaments?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1
/// organizer_name : "Parth Agrawal"
/// organizer_number : "9856321475"
/// tournament_name : "Cricket Tournament"
/// image : "tournaments/EfqW5KOJkjUiVKHGi1Do4HCwwluyZjMU2YPD80jx.jpg"
/// start_date : "25/11/2020"
/// end_date : "25/11/2020"
/// entry_fees : "1500"
/// timing : "8:50 AM"
/// no_of_members : "5"
/// age_limit : "18"
/// address : "bhayli vadodara"
/// prize_details : "5000 cash prize"
/// other_info : "dont be late"
/// location_id : "1"
/// player_id : "1"
/// player_name : "tausif"
/// created_at : "25/11/2020"

// class Tournaments {
//   Tournaments({
//     int? id,
//     String? organizerName,
//     String? organizerNumber,
//     String? tournamentName,
//     String? image,
//     String? startDate,
//     String? endDate,
//     String? entryFees,
//     String? timing,
//     String? noOfMembers,
//     String? ageLimit,
//     String? address,
//     String? prizeDetails,
//     String? otherInfo,
//     String? locationId,
//     String? playerId,
//     String? playerName,
//     String? createdAt,
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
//   }
//
//   Tournaments.fromJson(dynamic json) {
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
//   }
//   int? _id;
//   String? _organizerName;
//   String? _organizerNumber;
//   String? _tournamentName;
//   String? _image;
//   String? _startDate;
//   String? _endDate;
//   String? _entryFees;
//   String? _timing;
//   String? _noOfMembers;
//   String? _ageLimit;
//   String? _address;
//   String? _prizeDetails;
//   String? _otherInfo;
//   String? _locationId;
//   String? _playerId;
//   String? _playerName;
//   String? _createdAt;
//
//   int? get id => _id;
//   String? get organizerName => _organizerName;
//   String? get organizerNumber => _organizerNumber;
//   String? get tournamentName => _tournamentName;
//   String? get image => _image;
//   String? get startDate => _startDate;
//   String? get endDate => _endDate;
//   String? get entryFees => _entryFees;
//   String? get timing => _timing;
//   String? get noOfMembers => _noOfMembers;
//   String? get ageLimit => _ageLimit;
//   String? get address => _address;
//   String? get prizeDetails => _prizeDetails;
//   String? get otherInfo => _otherInfo;
//   String? get locationId => _locationId;
//   String? get playerId => _playerId;
//   String? get playerName => _playerName;
//   String? get createdAt => _createdAt;
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
//     return map;
//   }
// }

/// organizer_name : "Parth"
/// organizer_number : "9856321475"
/// tournament_name : "Cricket Tournament"
/// start_date : "25/11/2020"
/// end_date : "25/11/2020"
/// entry_fees : "1500"
/// timing : "8:50 AM"
/// no_of_members : "5"
/// age_limit : "18"
/// address : "bhayli vadodara"
/// prize_details : "5000 cash prize"
/// other_info : "dont be late"
/// location_id : "1"
/// player_id : "1"
/// player_name : "tausif"
/// created_at : "25/11/2020"
/// image : "tournaments/DvfCdIXaIIGtoiR66yC2AW7paykWZiysp6mEqlEq.jpg"
/// id : 1

class Tournament {
  Tournament({
    String? organizerName,
    String? organizerNumber,
    String? secondaryNumber,
    String? tournamentName,
    String? startDate,
    String? endDate,
    String? entryFees,
    String? timing,
    String? noOfMembers,
    String? ageLimit,
    String? address,
    String? prizeDetails,
    String? otherInfo,
    String? locationId,
    String? playerId,
    String? playerName,
    String? sportId,
    String? sportName,
    String? createdAt,
    String? startTime,
    String? endTime,
    String? ballType,
    String? tournamentCategory,
    String? noOfOvers,
    String? locationLink,
    String? image,
    String? status,
    int? id,
  }) {
    _organizerName = organizerName;
    _organizerNumber = organizerNumber;
    _secondaryNumber = secondaryNumber;
    _tournamentName = tournamentName;
    _startDate = startDate;
    _endDate = endDate;
    _entryFees = entryFees;
    _timing = timing;
    _noOfMembers = noOfMembers;
    _ageLimit = ageLimit;
    _address = address;
    _prizeDetails = prizeDetails;
    _otherInfo = otherInfo;
    _locationId = locationId;
    _playerId = playerId;
    _playerName = playerName;
    _sportId = sportId;
    _sportName = sportName;
    _createdAt = createdAt;

    _startTime = startTime;
    _endTime = endTime;
    _ballType = ballType;
    _tournamentCategory = tournamentCategory;
    _noOfOvers = noOfOvers;
    _locationLink = locationLink;

    _image = image;
    _status = status;
    _id = id;
  }

  Tournament.fromJson(dynamic json) {
    _organizerName = json['organizer_name'];
    _organizerNumber = json['organizer_number'];
    _secondaryNumber = json['secondary_number'];
    _tournamentName = json['tournament_name'];
    _startDate = json['start_date'];
    _endDate = json['end_date'];
    _entryFees = json['entry_fees'];
    _timing = json['timing'];
    _noOfMembers = json['no_of_members'];
    _ageLimit = json['age_limit'];
    _address = json['address'];
    _prizeDetails = json['prize_details'];
    _otherInfo = json['other_info'];
    _locationId = json['location_id'];
    _playerId = json['player_id'];
    _playerName = json['player_name'];
    _sportId = json['sport_id'];
    _sportName = json['sport_name'];
    _createdAt = json['created_at'];

    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _ballType = json['ball_type'];
    _tournamentCategory = json['tournament_category'];
    _noOfOvers = json['no_of_overs'];
    _locationLink = json['location_link'];

    _image = json['image'];
    _status = json['status'];
    _id = json['id'];
  }
  String? _organizerName;
  String? _organizerNumber;
  String? _secondaryNumber;
  String? _tournamentName;
  String? _startDate;
  String? _endDate;
  String? _entryFees;
  String? _timing;
  String? _noOfMembers;
  String? _ageLimit;
  String? _address;
  String? _prizeDetails;
  String? _otherInfo;
  String? _locationId;
  String? _playerId;
  String? _playerName;
  String? _sportId;
  String? _sportName;
  String? _createdAt;

  String? _startTime;
  String? _endTime;
  String? _ballType;
  String? _tournamentCategory;
  String? _noOfOvers;
  String? _locationLink;

  String? _image;
  String? _status;
  int? _id;

  String? get organizerName => _organizerName;
  String? get organizerNumber => _organizerNumber;
  String? get secondaryNumber => _secondaryNumber;
  String? get tournamentName => _tournamentName;
  String? get startDate => _startDate;
  String? get endDate => _endDate;
  String? get entryFees => _entryFees;
  String? get timing => _timing;
  String? get noOfMembers => _noOfMembers;
  String? get ageLimit => _ageLimit;
  String? get address => _address;
  String? get prizeDetails => _prizeDetails;
  String? get otherInfo => _otherInfo;
  String? get locationId => _locationId;
  String? get playerId => _playerId;
  String? get playerName => _playerName;
  String? get sportId => _sportId;
  String? get sportName => _sportName;
  String? get createdAt => _createdAt;

  String? get startTime => _startTime;
  String? get endTime => _endTime;
  String? get ballType => _ballType;
  String? get tournamentCategory => _tournamentCategory;
  String? get noOfOvers => _noOfOvers;
  String? get locationLink => _locationLink;

  String? get image => _image;
  String? get status => _status;
  int? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['organizer_name'] = _organizerName;
    map['organizer_number'] = _organizerNumber;
    map['secondary_number'] = _secondaryNumber;
    map['tournament_name'] = _tournamentName;
    map['start_date'] = _startDate;
    map['end_date'] = _endDate;
    map['entry_fees'] = _entryFees;
    map['timing'] = _timing;
    map['no_of_members'] = _noOfMembers;
    map['age_limit'] = _ageLimit;
    map['address'] = _address;
    map['prize_details'] = _prizeDetails;
    map['other_info'] = _otherInfo;
    map['location_id'] = _locationId;
    map['player_id'] = _playerId;
    map['player_name'] = _playerName;
    map['sport_id'] = _sportId;
    map['sport_name'] = _sportName;
    map['created_at'] = _createdAt;

    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    map['ball_type'] = _ballType;
    map['tournament_category'] = _tournamentCategory;
    map['no_of_overs'] = _noOfOvers;
    map['location_link'] = _locationLink;

    map['image'] = _image;
    map['status'] = _status;
    map['id'] = _id;
    return map;
  }

  set status(String? value) {
    _status = value;
  }

  set sportId(String? value) {
    _sportId = value;
  }

  set id(int? value) {
    _id = value;
  }

  set image(String? value) {
    _image = value;
  }

  set createdAt(String? value) {
    _createdAt = value;
  }

  set playerName(String? value) {
    _playerName = value;
  }

  set playerId(String? value) {
    _playerId = value;
  }

  set locationId(String? value) {
    _locationId = value;
  }

  set otherInfo(String? value) {
    _otherInfo = value;
  }

  set prizeDetails(String? value) {
    _prizeDetails = value;
  }

  set address(String? value) {
    _address = value;
  }

  set ageLimit(String? value) {
    _ageLimit = value;
  }

  set noOfMembers(String? value) {
    _noOfMembers = value;
  }

  set timing(String? value) {
    _timing = value;
  }

  set entryFees(String? value) {
    _entryFees = value;
  }

  set endDate(String? value) {
    _endDate = value;
  }

  set startDate(String? value) {
    _startDate = value;
  }

  set tournamentName(String? value) {
    _tournamentName = value;
  }

  set organizerNumber(String? value) {
    _organizerNumber = value;
  }

  set secondaryNumber(String? value) {
    _secondaryNumber = value;
  }

  set organizerName(String? value) {
    _organizerName = value;
  }

  set sportName(String? value) {
    _sportName = value;
  }

  set noOfOvers(String? value) {
    _noOfOvers = value;
  }

  set tournamentCategory(String? value) {
    _tournamentCategory = value;
  }

  set ballType(String? value) {
    _ballType = value;
  }

  set endTime(String? value) {
    _endTime = value;
  }

  set startTime(String? value) {
    _startTime = value;
  }

  set locationLink(String? value) {
    _locationLink = value;
  }
}
