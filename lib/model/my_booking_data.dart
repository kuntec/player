import 'package:player/model/venue_data.dart';

/// status : true
/// message : "TimeSlot Updated"
/// bookings : [{"id":4,"name":"this","number":"2569856","gender":"Male","age":"25","player_id":"9","sport_id":"7","venue_id":"7","time_slot_id":null,"created_at":"2021-11-02 01:07:08","description":null,"payment_mode":"1","payment_status":"2","booking_status":"1","amount":"1500.0","slots":[{"id":8,"booking_id":"4","venue_id":"7","time_slot_id":"36","booking_date":"2-11-2021","day":"2","created_at":null,"remaining_slots":null,"price":"1500"}],"venue":{"id":7,"name":"wankhed Stadium","description":"one of the largest stadium in india","open_time":"9:0","close_time":"12:0","address":"mumbai","city":"mumbai","sport":"cricket","player_id":"9","location_id":"1","image":"venues/dnguiq1ZweMgXzJd9tLO9a6NpItyBPlgjsCgVPIH.jpg","created_at":"20-10-2021","facilities":"all kind","location_link":"mumbai google","sport_id":null}}]

class MyBookingData {
  MyBookingData({
    bool? status,
    String? message,
    List<Bookings>? bookings,
  }) {
    _status = status;
    _message = message;
    _bookings = bookings;
  }

  MyBookingData.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['bookings'] != null) {
      _bookings = [];
      json['bookings'].forEach((v) {
        _bookings?.add(Bookings.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Bookings>? _bookings;

  bool? get status => _status;
  String? get message => _message;
  List<Bookings>? get bookings => _bookings;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_bookings != null) {
      map['bookings'] = _bookings?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 4
/// name : "this"
/// number : "2569856"
/// gender : "Male"
/// age : "25"
/// player_id : "9"
/// sport_id : "7"
/// venue_id : "7"
/// time_slot_id : null
/// created_at : "2021-11-02 01:07:08"
/// description : null
/// payment_mode : "1"
/// payment_status : "2"
/// booking_status : "1"
/// amount : "1500.0"
/// slots : [{"id":8,"booking_id":"4","venue_id":"7","time_slot_id":"36","booking_date":"2-11-2021","day":"2","created_at":null,"remaining_slots":null,"price":"1500"}]
/// venue : {"id":7,"name":"wankhed Stadium","description":"one of the largest stadium in india","open_time":"9:0","close_time":"12:0","address":"mumbai","city":"mumbai","sport":"cricket","player_id":"9","location_id":"1","image":"venues/dnguiq1ZweMgXzJd9tLO9a6NpItyBPlgjsCgVPIH.jpg","created_at":"20-10-2021","facilities":"all kind","location_link":"mumbai google","sport_id":null}

class Bookings {
  Bookings({
    int? id,
    String? name,
    String? number,
    String? gender,
    String? age,
    String? playerId,
    String? sportId,
    String? venueId,
    dynamic timeSlotId,
    String? createdAt,
    dynamic description,
    String? paymentMode,
    String? paymentStatus,
    String? bookingStatus,
    String? amount,
    List<Slots>? slots,
    Venue? venue,
  }) {
    _id = id;
    _name = name;
    _number = number;
    _gender = gender;
    _age = age;
    _playerId = playerId;
    _sportId = sportId;
    _venueId = venueId;
    _timeSlotId = timeSlotId;
    _createdAt = createdAt;
    _description = description;
    _paymentMode = paymentMode;
    _paymentStatus = paymentStatus;
    _bookingStatus = bookingStatus;
    _amount = amount;
    _slots = slots;
    _venue = venue;
  }

  Bookings.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _number = json['number'];
    _gender = json['gender'];
    _age = json['age'];
    _playerId = json['player_id'];
    _sportId = json['sport_id'];
    _venueId = json['venue_id'];
    _timeSlotId = json['time_slot_id'];
    _createdAt = json['created_at'];
    _description = json['description'];
    _paymentMode = json['payment_mode'];
    _paymentStatus = json['payment_status'];
    _bookingStatus = json['booking_status'];
    _amount = json['amount'];
    if (json['slots'] != null) {
      _slots = [];
      json['slots'].forEach((v) {
        _slots?.add(Slots.fromJson(v));
      });
    }
    _venue = json['venue'] != null ? Venue.fromJson(json['venue']) : null;
  }
  int? _id;
  String? _name;
  String? _number;
  String? _gender;
  String? _age;
  String? _playerId;
  String? _sportId;
  String? _venueId;
  dynamic _timeSlotId;
  String? _createdAt;
  dynamic _description;
  String? _paymentMode;
  String? _paymentStatus;
  String? _bookingStatus;
  String? _amount;
  List<Slots>? _slots;
  Venue? _venue;

  int? get id => _id;
  String? get name => _name;
  String? get number => _number;
  String? get gender => _gender;
  String? get age => _age;
  String? get playerId => _playerId;
  String? get sportId => _sportId;
  String? get venueId => _venueId;
  dynamic get timeSlotId => _timeSlotId;
  String? get createdAt => _createdAt;
  dynamic get description => _description;
  String? get paymentMode => _paymentMode;
  String? get paymentStatus => _paymentStatus;
  String? get bookingStatus => _bookingStatus;
  String? get amount => _amount;
  List<Slots>? get slots => _slots;
  Venue? get venue => _venue;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['number'] = _number;
    map['gender'] = _gender;
    map['age'] = _age;
    map['player_id'] = _playerId;
    map['sport_id'] = _sportId;
    map['venue_id'] = _venueId;
    map['time_slot_id'] = _timeSlotId;
    map['created_at'] = _createdAt;
    map['description'] = _description;
    map['payment_mode'] = _paymentMode;
    map['payment_status'] = _paymentStatus;
    map['booking_status'] = _bookingStatus;
    map['amount'] = _amount;
    if (_slots != null) {
      map['slots'] = _slots?.map((v) => v.toJson()).toList();
    }
    if (_venue != null) {
      map['venue'] = _venue?.toJson();
    }
    return map;
  }
}

/// id : 7
/// name : "wankhed Stadium"
/// description : "one of the largest stadium in india"
/// open_time : "9:0"
/// close_time : "12:0"
/// address : "mumbai"
/// city : "mumbai"
/// sport : "cricket"
/// player_id : "9"
/// location_id : "1"
/// image : "venues/dnguiq1ZweMgXzJd9tLO9a6NpItyBPlgjsCgVPIH.jpg"
/// created_at : "20-10-2021"
/// facilities : "all kind"
/// location_link : "mumbai google"
/// sport_id : null
//
// class Venue {
//   Venue({
//     int? id,
//     String? name,
//     String? description,
//     String? openTime,
//     String? closeTime,
//     String? address,
//     String? city,
//     String? sport,
//     String? playerId,
//     String? locationId,
//     String? image,
//     String? createdAt,
//     String? facilities,
//     String? locationLink,
//     dynamic sportId,
//   }) {
//     _id = id;
//     _name = name;
//     _description = description;
//     _openTime = openTime;
//     _closeTime = closeTime;
//     _address = address;
//     _city = city;
//     _sport = sport;
//     _playerId = playerId;
//     _locationId = locationId;
//     _image = image;
//     _createdAt = createdAt;
//     _facilities = facilities;
//     _locationLink = locationLink;
//     _sportId = sportId;
//   }
//
//   Venue.fromJson(dynamic json) {
//     _id = json['id'];
//     _name = json['name'];
//     _description = json['description'];
//     _openTime = json['open_time'];
//     _closeTime = json['close_time'];
//     _address = json['address'];
//     _city = json['city'];
//     _sport = json['sport'];
//     _playerId = json['player_id'];
//     _locationId = json['location_id'];
//     _image = json['image'];
//     _createdAt = json['created_at'];
//     _facilities = json['facilities'];
//     _locationLink = json['location_link'];
//     _sportId = json['sport_id'];
//   }
//   int? _id;
//   String? _name;
//   String? _description;
//   String? _openTime;
//   String? _closeTime;
//   String? _address;
//   String? _city;
//   String? _sport;
//   String? _playerId;
//   String? _locationId;
//   String? _image;
//   String? _createdAt;
//   String? _facilities;
//   String? _locationLink;
//   dynamic _sportId;
//
//   int? get id => _id;
//   String? get name => _name;
//   String? get description => _description;
//   String? get openTime => _openTime;
//   String? get closeTime => _closeTime;
//   String? get address => _address;
//   String? get city => _city;
//   String? get sport => _sport;
//   String? get playerId => _playerId;
//   String? get locationId => _locationId;
//   String? get image => _image;
//   String? get createdAt => _createdAt;
//   String? get facilities => _facilities;
//   String? get locationLink => _locationLink;
//   dynamic get sportId => _sportId;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['name'] = _name;
//     map['description'] = _description;
//     map['open_time'] = _openTime;
//     map['close_time'] = _closeTime;
//     map['address'] = _address;
//     map['city'] = _city;
//     map['sport'] = _sport;
//     map['player_id'] = _playerId;
//     map['location_id'] = _locationId;
//     map['image'] = _image;
//     map['created_at'] = _createdAt;
//     map['facilities'] = _facilities;
//     map['location_link'] = _locationLink;
//     map['sport_id'] = _sportId;
//     return map;
//   }
// }

/// id : 8
/// booking_id : "4"
/// venue_id : "7"
/// time_slot_id : "36"
/// booking_date : "2-11-2021"
/// day : "2"
/// created_at : null
/// remaining_slots : null
/// price : "1500"

class Slots {
  Slots({
    int? id,
    String? bookingId,
    String? venueId,
    String? timeSlotId,
    String? bookingDate,
    String? day,
    dynamic createdAt,
    dynamic remainingSlots,
    String? price,
    String? startTime,
  }) {
    _id = id;
    _bookingId = bookingId;
    _venueId = venueId;
    _timeSlotId = timeSlotId;
    _bookingDate = bookingDate;
    _day = day;
    _createdAt = createdAt;
    _remainingSlots = remainingSlots;
    _price = price;
    _startTime = startTime;
  }

  Slots.fromJson(dynamic json) {
    _id = json['id'];
    _bookingId = json['booking_id'];
    _venueId = json['venue_id'];
    _timeSlotId = json['time_slot_id'];
    _bookingDate = json['booking_date'];
    _day = json['day'];
    _createdAt = json['created_at'];
    _remainingSlots = json['remaining_slots'];
    _price = json['price'];
    _startTime = json['start_time'];
  }
  int? _id;
  String? _bookingId;
  String? _venueId;
  String? _timeSlotId;
  String? _bookingDate;
  String? _day;
  dynamic _createdAt;
  dynamic _remainingSlots;
  String? _price;
  String? _startTime;

  int? get id => _id;
  String? get bookingId => _bookingId;
  String? get venueId => _venueId;
  String? get timeSlotId => _timeSlotId;
  String? get bookingDate => _bookingDate;
  String? get day => _day;
  dynamic get createdAt => _createdAt;
  dynamic get remainingSlots => _remainingSlots;
  String? get price => _price;
  String? get startTime => _startTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['booking_id'] = _bookingId;
    map['venue_id'] = _venueId;
    map['time_slot_id'] = _timeSlotId;
    map['booking_date'] = _bookingDate;
    map['day'] = _day;
    map['created_at'] = _createdAt;
    map['remaining_slots'] = _remainingSlots;
    map['price'] = _price;
    map['start_time'] = _startTime;
    return map;
  }
}
