/// status : true
/// message : "Service Successfully Added"
/// service : {"service_id":"9","player_id":"9","name":"test","poster_image":"servicedata/gmrc19bJBnnSZoNqirr0hRr0YqdBMdCzdSrQ980b.png","address":"test","city":"test","contact_name":"test","contact_no":"9898989898","secondary_no":"9595959595","about":"test","location_link":"test","monthly_fees":"1000","coaches":"test","fees_per_match":"2000","fees_per_day":"500","experience":"5","company_name":"test","created_at":"21/10/2021","id":2}
/// services : [{"id":2,"service_id":"9","poster_image":"servicedata/gmrc19bJBnnSZoNqirr0hRr0YqdBMdCzdSrQ980b.png","name":"test","address":"test","city":"test","contact_name":"test","contact_no":"9898989898","secondary_no":"9595959595","about":"test","location_link":"test","monthly_fees":"1000","coaches":"test","fees_per_match":"2000","fees_per_day":"500","experience":"5","company_name":"test","created_at":"21/10/2021","player_id":"9"}]

class ServiceModel {
  ServiceModel({
    bool? status,
    String? message,
    Service? service,
    List<Service>? services,
  }) {
    _status = status;
    _message = message;
    _service = service;
    _services = services;
  }

  ServiceModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _service =
        json['service'] != null ? Service.fromJson(json['service']) : null;
    if (json['services'] != null) {
      _services = [];
      json['services'].forEach((v) {
        _services?.add(Service.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  Service? _service;
  List<Service>? _services;

  bool? get status => _status;
  String? get message => _message;
  Service? get service => _service;
  List<Service>? get services => _services;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_service != null) {
      map['service'] = _service?.toJson();
    }
    if (_services != null) {
      map['services'] = _services?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 2
/// service_id : "9"
/// poster_image : "servicedata/gmrc19bJBnnSZoNqirr0hRr0YqdBMdCzdSrQ980b.png"
/// name : "test"
/// address : "test"
/// city : "test"
/// contact_name : "test"
/// contact_no : "9898989898"
/// secondary_no : "9595959595"
/// about : "test"
/// location_link : "test"
/// monthly_fees : "1000"
/// coaches : "test"
/// fees_per_match : "2000"
/// fees_per_day : "500"
/// experience : "5"
/// company_name : "test"
/// created_at : "21/10/2021"
/// player_id : "9"

// class Services {
//   Services({
//     int? id,
//     String? serviceId,
//     String? posterImage,
//     String? name,
//     String? address,
//     String? city,
//     String? contactName,
//     String? contactNo,
//     String? secondaryNo,
//     String? about,
//     String? locationLink,
//     String? monthlyFees,
//     String? coaches,
//     String? feesPerMatch,
//     String? feesPerDay,
//     String? experience,
//     String? companyName,
//     String? createdAt,
//     String? playerId,
//   }) {
//     _id = id;
//     _serviceId = serviceId;
//     _posterImage = posterImage;
//     _name = name;
//     _address = address;
//     _city = city;
//     _contactName = contactName;
//     _contactNo = contactNo;
//     _secondaryNo = secondaryNo;
//     _about = about;
//     _locationLink = locationLink;
//     _monthlyFees = monthlyFees;
//     _coaches = coaches;
//     _feesPerMatch = feesPerMatch;
//     _feesPerDay = feesPerDay;
//     _experience = experience;
//     _companyName = companyName;
//     _createdAt = createdAt;
//     _playerId = playerId;
//   }
//
//   Services.fromJson(dynamic json) {
//     _id = json['id'];
//     _serviceId = json['service_id'];
//     _posterImage = json['poster_image'];
//     _name = json['name'];
//     _address = json['address'];
//     _city = json['city'];
//     _contactName = json['contact_name'];
//     _contactNo = json['contact_no'];
//     _secondaryNo = json['secondary_no'];
//     _about = json['about'];
//     _locationLink = json['location_link'];
//     _monthlyFees = json['monthly_fees'];
//     _coaches = json['coaches'];
//     _feesPerMatch = json['fees_per_match'];
//     _feesPerDay = json['fees_per_day'];
//     _experience = json['experience'];
//     _companyName = json['company_name'];
//     _createdAt = json['created_at'];
//     _playerId = json['player_id'];
//   }
//   int? _id;
//   String? _serviceId;
//   String? _posterImage;
//   String? _name;
//   String? _address;
//   String? _city;
//   String? _contactName;
//   String? _contactNo;
//   String? _secondaryNo;
//   String? _about;
//   String? _locationLink;
//   String? _monthlyFees;
//   String? _coaches;
//   String? _feesPerMatch;
//   String? _feesPerDay;
//   String? _experience;
//   String? _companyName;
//   String? _createdAt;
//   String? _playerId;
//
//   int? get id => _id;
//   String? get serviceId => _serviceId;
//   String? get posterImage => _posterImage;
//   String? get name => _name;
//   String? get address => _address;
//   String? get city => _city;
//   String? get contactName => _contactName;
//   String? get contactNo => _contactNo;
//   String? get secondaryNo => _secondaryNo;
//   String? get about => _about;
//   String? get locationLink => _locationLink;
//   String? get monthlyFees => _monthlyFees;
//   String? get coaches => _coaches;
//   String? get feesPerMatch => _feesPerMatch;
//   String? get feesPerDay => _feesPerDay;
//   String? get experience => _experience;
//   String? get companyName => _companyName;
//   String? get createdAt => _createdAt;
//   String? get playerId => _playerId;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['service_id'] = _serviceId;
//     map['poster_image'] = _posterImage;
//     map['name'] = _name;
//     map['address'] = _address;
//     map['city'] = _city;
//     map['contact_name'] = _contactName;
//     map['contact_no'] = _contactNo;
//     map['secondary_no'] = _secondaryNo;
//     map['about'] = _about;
//     map['location_link'] = _locationLink;
//     map['monthly_fees'] = _monthlyFees;
//     map['coaches'] = _coaches;
//     map['fees_per_match'] = _feesPerMatch;
//     map['fees_per_day'] = _feesPerDay;
//     map['experience'] = _experience;
//     map['company_name'] = _companyName;
//     map['created_at'] = _createdAt;
//     map['player_id'] = _playerId;
//     return map;
//   }
// }

/// service_id : "9"
/// player_id : "9"
/// name : "test"
/// poster_image : "servicedata/gmrc19bJBnnSZoNqirr0hRr0YqdBMdCzdSrQ980b.png"
/// address : "test"
/// city : "test"
/// contact_name : "test"
/// contact_no : "9898989898"
/// secondary_no : "9595959595"
/// about : "test"
/// location_link : "test"
/// monthly_fees : "1000"
/// coaches : "test"
/// fees_per_match : "2000"
/// fees_per_day : "500"
/// experience : "5"
/// company_name : "test"
/// created_at : "21/10/2021"
/// id : 2

class Service {
  Service({
    String? serviceId,
    String? playerId,
    String? name,
    String? posterImage,
    String? address,
    String? city,
    String? contactName,
    String? contactNo,
    String? secondaryNo,
    String? about,
    String? locationLink,
    String? monthlyFees,
    String? coaches,
    String? feesPerMatch,
    String? feesPerDay,
    String? experience,
    String? companyName,
    String? sportId,
    String? sportName,
    String? createdAt,
    String? locationId,
    int? id,
  }) {
    _serviceId = serviceId;
    _playerId = playerId;
    _name = name;
    _posterImage = posterImage;
    _address = address;
    _city = city;
    _contactName = contactName;
    _contactNo = contactNo;
    _secondaryNo = secondaryNo;
    _about = about;
    _locationLink = locationLink;
    _monthlyFees = monthlyFees;
    _coaches = coaches;
    _feesPerMatch = feesPerMatch;
    _feesPerDay = feesPerDay;
    _experience = experience;
    _companyName = companyName;
    _sportId = sportId;
    _sportName = sportName;
    _createdAt = createdAt;
    _locationId = locationId;
    _id = id;
  }

  Service.fromJson(dynamic json) {
    _serviceId = json['service_id'];
    _playerId = json['player_id'];
    _name = json['name'];
    _posterImage = json['poster_image'];
    _address = json['address'];
    _city = json['city'];
    _contactName = json['contact_name'];
    _contactNo = json['contact_no'];
    _secondaryNo = json['secondary_no'];
    _about = json['about'];
    _locationLink = json['location_link'];
    _monthlyFees = json['monthly_fees'];
    _coaches = json['coaches'];
    _feesPerMatch = json['fees_per_match'];
    _feesPerDay = json['fees_per_day'];
    _experience = json['experience'];
    _companyName = json['company_name'];
    _sportId = json['sport_id'];
    _sportName = json['sport_name'];
    _createdAt = json['created_at'];
    _locationId = json['location_id'];
    _id = json['id'];
  }
  String? _serviceId;
  String? _playerId;
  String? _name;
  String? _posterImage;
  String? _address;
  String? _city;
  String? _contactName;
  String? _contactNo;
  String? _secondaryNo;
  String? _about;
  String? _locationLink;
  String? _monthlyFees;
  String? _coaches;
  String? _feesPerMatch;
  String? _feesPerDay;
  String? _experience;
  String? _companyName;
  String? _sportId;
  String? _sportName;
  String? _createdAt;
  String? _locationId;
  int? _id;

  String? get locationId => _locationId;
  String? get serviceId => _serviceId;
  String? get playerId => _playerId;
  String? get name => _name;
  String? get posterImage => _posterImage;
  String? get address => _address;
  String? get city => _city;
  String? get contactName => _contactName;
  String? get contactNo => _contactNo;
  String? get secondaryNo => _secondaryNo;
  String? get about => _about;
  String? get locationLink => _locationLink;
  String? get monthlyFees => _monthlyFees;
  String? get coaches => _coaches;
  String? get feesPerMatch => _feesPerMatch;
  String? get feesPerDay => _feesPerDay;
  String? get experience => _experience;
  String? get companyName => _companyName;
  String? get sportId => _sportId;
  String? get sportName => _sportName;
  String? get createdAt => _createdAt;
  int? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['service_id'] = _serviceId;
    map['player_id'] = _playerId;
    map['name'] = _name;
    map['poster_image'] = _posterImage;
    map['address'] = _address;
    map['city'] = _city;
    map['contact_name'] = _contactName;
    map['contact_no'] = _contactNo;
    map['secondary_no'] = _secondaryNo;
    map['about'] = _about;
    map['location_link'] = _locationLink;
    map['monthly_fees'] = _monthlyFees;
    map['coaches'] = _coaches;
    map['fees_per_match'] = _feesPerMatch;
    map['fees_per_day'] = _feesPerDay;
    map['experience'] = _experience;
    map['company_name'] = _companyName;
    map['sport_id'] = _sportId;
    map['sport_name'] = _sportName;
    map['created_at'] = _createdAt;
    map['location_id'] = _locationId;
    map['id'] = _id;
    return map;
  }

  set locationId(value) {
    _locationId = value;
  }

  set sportId(value) {
    _sportId = value;
  }

  set id(value) {
    _id = value;
  }

  set createdAt(value) {
    _createdAt = value;
  }

  set companyName(value) {
    _companyName = value;
  }

  set experience(value) {
    _experience = value;
  }

  set feesPerDay(value) {
    _feesPerDay = value;
  }

  set feesPerMatch(value) {
    _feesPerMatch = value;
  }

  set coaches(value) {
    _coaches = value;
  }

  set monthlyFees(value) {
    _monthlyFees = value;
  }

  set locationLink(value) {
    _locationLink = value;
  }

  set about(value) {
    _about = value;
  }

  set secondaryNo(value) {
    _secondaryNo = value;
  }

  set contactNo(value) {
    _contactNo = value;
  }

  set contactName(value) {
    _contactName = value;
  }

  set city(value) {
    _city = value;
  }

  set address(value) {
    _address = value;
  }

  set posterImage(value) {
    _posterImage = value;
  }

  set name(value) {
    _name = value;
  }

  set playerId(value) {
    _playerId = value;
  }

  set serviceId(value) {
    _serviceId = value;
  }

  set sportName(value) {
    _sportName = value;
  }
}
