/// status : true
/// message : "Booking Added"
/// booking : {"name":"tausif","number":"9409394242","gender":"male","age":"32","player_id":"9","sport_id":"4","venue_id":"6","payment_mode":"1","payment_status":"1","booking_status":"1","amount":"1200","id":1}
/// slot : {"booking_id":"1","venue_id":null,"time_slot_id":"32","booking_date":"01-11-2021","day":"1","price":"100","id":4}

class BookingData {
  BookingData({
    bool? status,
    String? message,
    Booking? booking,
    Slot? slot,
  }) {
    _status = status;
    _message = message;
    _booking = booking;
    _slot = slot;
  }

  BookingData.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _booking =
        json['booking'] != null ? Booking.fromJson(json['booking']) : null;
    _slot = json['slot'] != null ? Slot.fromJson(json['slot']) : null;
  }
  bool? _status;
  String? _message;
  Booking? _booking;
  Slot? _slot;

  bool? get status => _status;
  String? get message => _message;
  Booking? get booking => _booking;
  Slot? get slot => _slot;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_booking != null) {
      map['booking'] = _booking?.toJson();
    }
    if (_slot != null) {
      map['slot'] = _slot?.toJson();
    }
    return map;
  }
}

/// booking_id : "1"
/// venue_id : null
/// time_slot_id : "32"
/// booking_date : "01-11-2021"
/// day : "1"
/// price : "100"
/// id : 4

class Slot {
  Slot({
    String? bookingId,
    String? venueId,
    String? timeSlotId,
    String? startTime,
    String? bookingDate,
    String? day,
    String? price,
    int? id,
  }) {
    _bookingId = bookingId;
    _venueId = venueId;
    _timeSlotId = timeSlotId;
    _bookingDate = bookingDate;
    _day = day;
    _price = price;
    _startTime = startTime;
    _id = id;
  }

  Slot.fromJson(dynamic json) {
    _bookingId = json['booking_id'];
    _venueId = json['venue_id'];
    _timeSlotId = json['time_slot_id'];
    _bookingDate = json['booking_date'];
    _day = json['day'];
    _price = json['price'];
    _startTime = json['start_time'];
    _id = json['id'];
  }
  String? _bookingId;
  String? _venueId;
  String? _timeSlotId;
  String? _bookingDate;
  String? _day;
  String? _price;
  String? _startTime;
  int? _id;

  String? get bookingId => _bookingId;
  String? get venueId => _venueId;
  String? get timeSlotId => _timeSlotId;
  String? get bookingDate => _bookingDate;
  String? get day => _day;
  String? get price => _price;
  String? get startTime => _startTime;
  int? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['booking_id'] = _bookingId;
    map['venue_id'] = _venueId;
    map['time_slot_id'] = _timeSlotId;
    map['booking_date'] = _bookingDate;
    map['day'] = _day;
    map['price'] = _price;
    map['start_time'] = _startTime;
    map['id'] = _id;
    return map;
  }

  set id(int? value) {
    _id = value;
  }

  set price(String? value) {
    _price = value;
  }

  set day(String? value) {
    _day = value;
  }

  set bookingDate(String? value) {
    _bookingDate = value;
  }

  set timeSlotId(String? value) {
    _timeSlotId = value;
  }

  set venueId(String? value) {
    _venueId = value;
  }

  set bookingId(String? value) {
    _bookingId = value;
  }

  set startTime(String? value) {
    _startTime = value;
  }
}

/// name : "tausif"
/// number : "9409394242"
/// gender : "male"
/// age : "32"
/// player_id : "9"
/// sport_id : "4"
/// venue_id : "6"
/// payment_mode : "1"
/// payment_status : "1"
/// booking_status : "1"
/// amount : "1200"
/// id : 1

class Booking {
  Booking({
    String? name,
    String? number,
    String? gender,
    String? age,
    String? playerId,
    String? sportId,
    String? venueId,
    String? ownerId,
    String? paymentMode,
    String? paymentStatus,
    String? bookingStatus,
    String? amount,
    int? id,
  }) {
    _name = name;
    _number = number;
    _gender = gender;
    _age = age;
    _playerId = playerId;
    _sportId = sportId;
    _venueId = venueId;
    _ownerId = ownerId;
    _paymentMode = paymentMode;
    _paymentStatus = paymentStatus;
    _bookingStatus = bookingStatus;
    _amount = amount;
    _id = id;
  }

  Booking.fromJson(dynamic json) {
    _name = json['name'];
    _number = json['number'];
    _gender = json['gender'];
    _age = json['age'];
    _playerId = json['player_id'];
    _sportId = json['sport_id'];
    _venueId = json['venue_id'];
    _ownerId = json['owner_id'];
    _paymentMode = json['payment_mode'];
    _paymentStatus = json['payment_status'];
    _bookingStatus = json['booking_status'];
    _amount = json['amount'];
    _id = json['id'];
  }
  String? _name;
  String? _number;
  String? _gender;
  String? _age;
  String? _playerId;
  String? _sportId;
  String? _venueId;
  String? _ownerId;
  String? _paymentMode;
  String? _paymentStatus;
  String? _bookingStatus;
  String? _amount;
  int? _id;

  String? get name => _name;
  String? get number => _number;
  String? get gender => _gender;
  String? get age => _age;
  String? get playerId => _playerId;
  String? get sportId => _sportId;
  String? get venueId => _venueId;
  String? get ownerId => _ownerId;
  String? get paymentMode => _paymentMode;
  String? get paymentStatus => _paymentStatus;
  String? get bookingStatus => _bookingStatus;
  String? get amount => _amount;
  int? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['number'] = _number;
    map['gender'] = _gender;
    map['age'] = _age;
    map['player_id'] = _playerId;
    map['sport_id'] = _sportId;
    map['venue_id'] = _venueId;
    map['owner_id'] = _ownerId;
    map['payment_mode'] = _paymentMode;
    map['payment_status'] = _paymentStatus;
    map['booking_status'] = _bookingStatus;
    map['amount'] = _amount;
    map['id'] = _id;
    return map;
  }

  set id(int? value) {
    _id = value;
  }

  set amount(String? value) {
    _amount = value;
  }

  set bookingStatus(String? value) {
    _bookingStatus = value;
  }

  set paymentStatus(String? value) {
    _paymentStatus = value;
  }

  set paymentMode(String? value) {
    _paymentMode = value;
  }

  set venueId(String? value) {
    _venueId = value;
  }

  set ownerId(String? value) {
    _ownerId = value;
  }

  set sportId(String? value) {
    _sportId = value;
  }

  set playerId(String? value) {
    _playerId = value;
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
}
