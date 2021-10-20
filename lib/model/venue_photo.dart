/// status : true
/// message : "Venue Photos Found"
/// photos : [{"id":2,"venue_id":"9","image":"venuephotos/rj5isgMivEmClmXp3sibEYkfJ1fq0794NpxYxskI.jpg","created_at":"20/10/2021"}]

class VenuePhoto {
  VenuePhoto({
    bool? status,
    String? message,
    List<Photos>? photos,
  }) {
    _status = status;
    _message = message;
    _photos = photos;
  }

  VenuePhoto.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['photos'] != null) {
      _photos = [];
      json['photos'].forEach((v) {
        _photos?.add(Photos.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Photos>? _photos;

  bool? get status => _status;
  String? get message => _message;
  List<Photos>? get photos => _photos;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_photos != null) {
      map['photos'] = _photos?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 2
/// venue_id : "9"
/// image : "venuephotos/rj5isgMivEmClmXp3sibEYkfJ1fq0794NpxYxskI.jpg"
/// created_at : "20/10/2021"

class Photos {
  Photos({
    int? id,
    String? venueId,
    String? image,
    String? createdAt,
  }) {
    _id = id;
    _venueId = venueId;
    _image = image;
    _createdAt = createdAt;
  }

  Photos.fromJson(dynamic json) {
    _id = json['id'];
    _venueId = json['venue_id'];
    _image = json['image'];
    _createdAt = json['created_at'];
  }
  int? _id;
  String? _venueId;
  String? _image;
  String? _createdAt;

  int? get id => _id;
  String? get venueId => _venueId;
  String? get image => _image;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['venue_id'] = _venueId;
    map['image'] = _image;
    map['created_at'] = _createdAt;
    return map;
  }
}
