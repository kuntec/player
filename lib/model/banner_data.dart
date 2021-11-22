/// status : true
/// message : "banners Found"
/// banners : [{"id":1,"name":"","description":"","img_url":"banner/3PfwnbIiIDroKp3bSvcsFR8hi86XPTr1tKvd6flK.jpg","created_at":"2021-11-22 12:20:22","status":""}]

class BannerData {
  BannerData({
    bool? status,
    String? message,
    List<Banners>? banners,
  }) {
    _status = status;
    _message = message;
    _banners = banners;
  }

  BannerData.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['banners'] != null) {
      _banners = [];
      json['banners'].forEach((v) {
        _banners?.add(Banners.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Banners>? _banners;

  bool? get status => _status;
  String? get message => _message;
  List<Banners>? get banners => _banners;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_banners != null) {
      map['banners'] = _banners?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1
/// name : ""
/// description : ""
/// img_url : "banner/3PfwnbIiIDroKp3bSvcsFR8hi86XPTr1tKvd6flK.jpg"
/// created_at : "2021-11-22 12:20:22"
/// status : ""

class Banners {
  Banners({
    int? id,
    String? name,
    String? description,
    String? imgUrl,
    String? createdAt,
    String? status,
  }) {
    _id = id;
    _name = name;
    _description = description;
    _imgUrl = imgUrl;
    _createdAt = createdAt;
    _status = status;
  }

  Banners.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
    _imgUrl = json['img_url'];
    _createdAt = json['created_at'];
    _status = json['status'];
  }
  int? _id;
  String? _name;
  String? _description;
  String? _imgUrl;
  String? _createdAt;
  String? _status;

  int? get id => _id;
  String? get name => _name;
  String? get description => _description;
  String? get imgUrl => _imgUrl;
  String? get createdAt => _createdAt;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['description'] = _description;
    map['img_url'] = _imgUrl;
    map['created_at'] = _createdAt;
    map['status'] = _status;
    return map;
  }
}
