class ServicePhoto {
  ServicePhoto({
    bool? status,
    String? message,
    List<Photos>? photos,
  }) {
    _status = status;
    _message = message;
    _photos = photos;
  }

  ServicePhoto.fromJson(dynamic json) {
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
    String? serviceId,
    String? image,
    String? createdAt,
    String? status,
  }) {
    _id = id;
    _serviceId = serviceId;
    _image = image;
    _createdAt = createdAt;
    _status = status;
  }

  Photos.fromJson(dynamic json) {
    _id = json['id'];
    _serviceId = json['service_id'];
    _image = json['image'];
    _createdAt = json['created_at'];
    _status = json['status'];
  }

  int? _id;
  String? _serviceId;
  String? _image;
  String? _createdAt;
  String? _status;

  int? get id => _id;
  String? get serviceId => _serviceId;
  String? get image => _image;
  String? get createdAt => _createdAt;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['service_id'] = _serviceId;
    map['image'] = _image;
    map['created_at'] = _createdAt;
    map['status'] = _status;
    return map;
  }
}
