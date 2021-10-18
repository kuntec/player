/// status : true
/// message : "Sport Found"
/// data : [{"id":4,"sport_name":"Tennis","sport_desc":"tournament tennis","sport_icon":"sports/zjO3R55k9B4i3XtUB2qRuFYehkEv4iDe3bxOpuOT.jpg","created_at":"2021-10-06 08:02:50","sport_category_id":"2"},{"id":5,"sport_name":"cricket","sport_desc":"tournament cricket","sport_icon":"sports/3QCnumz68BTxzo61hlgfG1C4E9K4WRkI6PdWeapX.jpg","created_at":"2021-10-06 08:03:05","sport_category_id":"2"}]

class SportData {
  SportData({
    bool? status,
    String? message,
    List<Data>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  SportData.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Data>? _data;

  bool? get status => _status;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 4
/// sport_name : "Tennis"
/// sport_desc : "tournament tennis"
/// sport_icon : "sports/zjO3R55k9B4i3XtUB2qRuFYehkEv4iDe3bxOpuOT.jpg"
/// created_at : "2021-10-06 08:02:50"
/// sport_category_id : "2"

class Data {
  Data({
    int? id,
    String? sportName,
    String? sportDesc,
    String? sportIcon,
    String? createdAt,
    String? sportCategoryId,
  }) {
    _id = id;
    _sportName = sportName;
    _sportDesc = sportDesc;
    _sportIcon = sportIcon;
    _createdAt = createdAt;
    _sportCategoryId = sportCategoryId;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _sportName = json['sport_name'];
    _sportDesc = json['sport_desc'];
    _sportIcon = json['sport_icon'];
    _createdAt = json['created_at'];
    _sportCategoryId = json['sport_category_id'];
  }
  int? _id;
  String? _sportName;
  String? _sportDesc;
  String? _sportIcon;
  String? _createdAt;
  String? _sportCategoryId;

  int? get id => _id;
  String? get sportName => _sportName;
  String? get sportDesc => _sportDesc;
  String? get sportIcon => _sportIcon;
  String? get createdAt => _createdAt;
  String? get sportCategoryId => _sportCategoryId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['sport_name'] = _sportName;
    map['sport_desc'] = _sportDesc;
    map['sport_icon'] = _sportIcon;
    map['created_at'] = _createdAt;
    map['sport_category_id'] = _sportCategoryId;
    return map;
  }

  set sportCategoryId(String? value) {
    _sportCategoryId = value;
  }

  set createdAt(String? value) {
    _createdAt = value;
  }

  set sportIcon(String? value) {
    _sportIcon = value;
  }

  set sportDesc(String? value) {
    _sportDesc = value;
  }

  set sportName(String? value) {
    _sportName = value;
  }

  set id(int? value) {
    _id = value;
  }
}
